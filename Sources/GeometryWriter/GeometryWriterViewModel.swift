//
//  GeometryWriterViewModel.swift
//  
//
//  Created by Anton Heestand on 2022-03-15.
//

import Foundation
import SwiftUI
import PixelKit
import RenderKit
import MultiViews

final class GeometryWriterViewModel<Content: View>: ObservableObject {
        
    private let viewPix: ViewPIX
    private let xReducePix: ReducePIX
    private let yReducePix: ReducePIX
    
    private let hostingController: MPHostingController<Content>
    private var view: MPView { hostingController.view }
    
    let maximumSize = CGSize(width: 500, height: 500)
    
    private var containerView: MPView
    
    private var topFraction: CGFloat?
    private var leadingFraction: CGFloat?
    private var trailingFraction: CGFloat?
    private var bottomFraction: CGFloat?
    
    @Published var fractionFrame: CGRect?
    
    var origin: CGPoint? {
        guard let frame = fractionFrame else { return nil }
        return CGPoint(x: frame.minX * maximumSize.width,
                       y: frame.minY * maximumSize.height)
    }
    
    var size: CGSize? {
        guard let frame = fractionFrame else { return nil }
        return CGSize(width: frame.width * maximumSize.width,
                      height: frame.height * maximumSize.height)
    }
    
    var frame: CGRect? {
        guard let origin = origin else { return nil }
        guard let size = size else { return nil }
        return CGRect(origin: origin, size: size)
    }
    
    init(content: () -> Content) {
        
        PixelKit.main.disableLogging()
        
        viewPix = ViewPIX()
        viewPix.autoSize = false
        
        xReducePix = ReducePIX()
        xReducePix.input = viewPix
        xReducePix.cellList = .row
        xReducePix.method = .maximum
        
        yReducePix = ReducePIX()
        yReducePix.input = viewPix
        yReducePix.cellList = .column
        yReducePix.method = .maximum
        
        hostingController = MPHostingController(rootView: content())
        
        containerView = MPView()
        containerView.frame = CGRect(origin: .zero, size: maximumSize)
        containerView.addSubview(view)
        
        #if os(macOS)
        view.wantsLayer = true
        view.layer!.backgroundColor = .clear
        #else
        view.backgroundColor = .clear
        #endif
        
        view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            view.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            view.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
        ])

        viewPix.renderView = containerView
        
        yReducePix.delegate = self
        xReducePix.delegate = self
        
        forceRender()
    }
    
    func forceRender() {
        
        DispatchQueue.main.async { [weak self] in
            self?.render()
        }
    }
    
    func render() {
        viewPix.viewNeedsRender()
    }
}

extension GeometryWriterViewModel: NODEDelegate {
    
    func nodeDidRender(_ node: NODE) {
          
        guard let pix = node as? PIX else { return }
        
        guard pix == xReducePix || pix == yReducePix else { return }
            
        guard let pixels = pix.renderedPixels else { return }
        
        let values = pixels.raw.flatMap({ $0 }).map(\.color.alpha)
        
        if pix == xReducePix {
                        
            var leadingIndex: Int!
            for (index, value) in values.enumerated() {
                if value > 0.01 {
                    leadingIndex = index
                    break
                }
            }
            
            var trailingIndex: Int!
            for (index, value) in values.enumerated().reversed() {
                if value > 0.01 {
                    trailingIndex = index
                    break
                }
            }
            
            guard leadingIndex != nil && trailingIndex != nil else { return }
            
            leadingFraction = CGFloat(leadingIndex) / CGFloat(values.count)
            trailingFraction = CGFloat(trailingIndex + 1) / CGFloat(values.count)
            
        } else if pix == yReducePix {
            
            var topIndex: Int!
            for (index, value) in values.enumerated() {
                if value > 0.01 {
                    topIndex = index
                    break
                }
            }
            
            var bottomIndex: Int!
            for (index, value) in values.enumerated().reversed() {
                if value > 0.01 {
                    bottomIndex = index
                    break
                }
            }
            
            guard topIndex != nil && bottomIndex != nil else { return }
            
            topFraction = CGFloat(topIndex) / CGFloat(values.count)
            bottomFraction = CGFloat(bottomIndex + 1) / CGFloat(values.count)
        }
        
        calculateFractionFrame()
    }
    
    func calculateFractionFrame() {
        
        guard let topFraction: CGFloat = topFraction else { return }
        guard let leadingFraction: CGFloat = leadingFraction else { return }
        guard let trailingFraction: CGFloat = trailingFraction else { return }
        guard let bottomFraction: CGFloat = bottomFraction else { return }
        
        let width: CGFloat = trailingFraction - leadingFraction
        let height: CGFloat = bottomFraction - topFraction
        
        fractionFrame = CGRect(x: leadingFraction, y: topFraction, width: width, height: height)
    }
}

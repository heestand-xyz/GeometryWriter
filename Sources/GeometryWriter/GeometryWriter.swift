//
//  GeometryWriter.swift
//
//
//  Created by Anton Heestand on 2022-03-15.
//

import SwiftUI
import CoreGraphicsExtensions

public struct GeometryWriter<Content: View>: View {
    
    private let content: (GeometryWriterProxy) -> Content
    
    @StateObject private var viewModel: GeometryWriterViewModel<Content>
    
    public init(content: @escaping (GeometryWriterProxy) -> Content) {
        self.content = content
        _viewModel = StateObject(wrappedValue: GeometryWriterViewModel(content: {
            let emptyProxy = GeometryWriterProxy(origin: .zero, size: .zero)
            return content(emptyProxy)
        }))
    }
    
    public var body: some View {
        if let frame = viewModel.frame {
            GeometryReader { geometryProxy in
                let origin = geometryProxy.frame(in: .global).origin + frame.origin
                let proxy = GeometryWriterProxy(origin: origin, size: frame.size)
                content(proxy)
                    .frame(width: 0, height: 0)
                    .frame(width: viewModel.maximumSize.width,
                           height: viewModel.maximumSize.height)
            }
            .frame(width: frame.width, height: frame.height, alignment: .topLeading)
            .offset(x: -frame.origin.x, y: -frame.origin.y)
        }
    }
}

//
//  GeometryWriterViewRepresentable.swift
//  
//
//  Created by Anton Heestand on 2022-03-16.
//

//import SwiftUI
//import MultiViews
//
//struct GeometryWriterViewRepresentable<Content: View>: MPViewRepresentable {
//    
//    let content: () -> Content
//    
//    let viewModel: GeometryWriterViewModel
//    
//    func makeUIView(context: Context) -> MPView {
//
//        containerView = MPView()
//        containerView.frame = CGRect(origin: .zero, size: maximumSize)
//        containerView.addSubview(view)
//        
//        view.backgroundColor = .clear
//        
//        view.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            view.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
//            view.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
//        ])
//    }
//    
//    func updateUIView(_ uiView: MPView, context: Context) {
//        <#code#>
//    }
//}

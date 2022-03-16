//
//  GeometryWriter.swift
//
//
//  Created by Anton Heestand on 2022-03-15.
//

import SwiftUI

public struct GeometryWriter<Content: View>: View {
    
    private let content: () -> Content
    
    @StateObject private var viewModel: GeometryWriterViewModel<Content>
    
    public init(content: @escaping () -> Content) {
        self.content = content
        _viewModel = StateObject(wrappedValue: GeometryWriterViewModel(content: content))
    }
    
    public var body: some View {
        if let frame = viewModel.frame {
            content()
                .frame(width: 0, height: 0)
                .frame(width: viewModel.maximumSize.width,
                       height: viewModel.maximumSize.height)
                .frame(width: frame.width, height: frame.height, alignment: .topLeading)
                .offset(x: -frame.origin.x, y: -frame.origin.y)
        }
    }
}

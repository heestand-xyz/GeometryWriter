import SwiftUI

public struct GeometryWriter<Content: View>: View {
    
    private let content: () -> Content
    
    @StateObject private var viewModel: GeometryWriterViewModel<Content>
    
    public init(content: @escaping () -> Content) {
        self.content = content
        _viewModel = StateObject(wrappedValue: GeometryWriterViewModel(content: content))
//        viewModel.update(content: content)
    }
    
    public var body: some View {
        if let frame = viewModel.frame {
            content()
                .frame(width: 0, height: 0)
                .frame(width: viewModel.maximumSize.width,
                       height: viewModel.maximumSize.height)
                .frame(width: frame.width, height: frame.height, alignment: .topLeading)
                .offset(x: -frame.origin.x, y: -frame.origin.y)
//            if let image = viewModel.image {
//                Image(image: image)
//                    .resizable()
//                    .aspectRatio(image.size, contentMode: .fit)
//                    .border(.blue)
//                    .overlay(
//                        Rectangle()
//                            .stroke()
//                            .foregroundColor(.blue)
//                            .opacity(0.5)
//                            .padding(viewModel.padding)
//                    )
//                    .overlay(
//                        Rectangle()
//                            .stroke()
//                            .foregroundColor(.blue)
//                            .opacity(0.5)
//                            .frame(height: 20)
//                    )
//                    .overlay(
//                        Rectangle()
//                            .stroke()
//                            .foregroundColor(.blue)
//                            .opacity(0.5)
//                            .frame(width: 20)
//                    )
//            }
        }
    }
}

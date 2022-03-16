# SwiftUI GeometryWriter

The `GeometryWriter` writes the minimum frame to a `View`.

It is the opposite of a `GeometryReader`, as in that the `GeometryReader` will take up as much space as possible and the `GeometryWriter` will take up as little space as possible, constraining a view to it's visible frame. Any area with opacity `0.0 will be cropped.

<img src="https://github.com/heestand-xyz/GeometryWriter/blob/main/Assets/Toggle.png?raw=true" width="337"/>

<img src="https://github.com/heestand-xyz/GeometryWriter/blob/main/Assets/DatePicker.png?raw=true" width="342"/>

The blue border is the resulting frame of a view in a `GeometryWriter`.

## Code Example

```swift
import SwiftUI
import GeometryWriter

struct ContentView: View {
    
    @State private var active: Bool = false
    
    var body: some View {
        
        GeometryWriter { _ in
            
            Toggle(isOn: $active) {
                EmptyView()
            }
        }
        .border(.blue)
    }
}
```

## Swift Package

```swift
.package(url: "https://github.com/heestand-xyz/GeometryWriter", from: "1.0.0")
```

Minimum requirement: iOS 14

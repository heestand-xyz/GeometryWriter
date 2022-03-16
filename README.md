# GeometryWriter for SwiftUI

```swift
import SwiftUI
import GeometryWriter

struct ContentView: View {
    
    var body: some View {
    
        GeometryWriter {
        
            Toggle(isOn: .constant(true), label: { EmptyView() })
        }
        .border(.blue)
    }
}
```

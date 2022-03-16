//
//  File.swift
//  
//
//  Created by Anton Heestand on 2022-03-16.
//

import CoreGraphics

public struct GeometryWriterProxy {
    
    let origin: CGPoint
    public let size: CGSize
    
    public enum CoordinateSpace {
        case local
        case global
    }
    
    public func frame(in coordinateSpace: CoordinateSpace) -> CGRect {
        switch coordinateSpace {
        case .local:
            return CGRect(origin: .zero, size: size)
        case .global:
            return CGRect(origin: origin, size: size)
        }
    }
}

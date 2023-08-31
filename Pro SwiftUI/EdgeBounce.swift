//
//  EdgeBounce.swift
//  Pro SwiftUI
//
//  Created by Madhan on 15/08/2023.
//

import SwiftUI

extension Animation{
    
    static var edgeBounce: Animation{
        .timingCurve(0, 1, 1, 0)
    }
    
    static func edgeBounce(duration: TimeInterval = 0.2) -> Animation {
        .timingCurve(0, 1, 1, 0, duration: duration)
    }
    
    static var easeInOutBack: Animation {
        .timingCurve(0.7, -0.5, 0.3, 1.5)
    }
    
    static func easeInOutBack(duration: TimeInterval = 0.2) -> Animation {
        .timingCurve(1, -0.78, 0, 1.63, duration: duration)
    }
}

struct EdgeBounce: View {
    
    @State private var offset = -200.0
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .offset(y: offset)
            .animation(.easeInOutBack(duration: 2).repeatForever(autoreverses: true), value: offset)
            .onTapGesture {
                offset = 200
            }
    }
}



#Preview {
    EdgeBounce()
}

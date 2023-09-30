//
//  RadialLayouts.swift
//  Pro SwiftUI
//
//  Created by Madhan on 19/09/2023.
//

import SwiftUI

struct RadialLayout: Layout {
    
    var rollOut = 0.0
    
    var animatableData: Double{
        get { rollOut }
        set { rollOut = newValue }
    }
    
    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        proposal.replacingUnspecifiedDimensions()
    }
    
    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        let radius = min(bounds.size.width, bounds.size.height) / 2
        let angle = Angle.degrees(360 / Double(subviews.count)).radians * rollOut
        
        for (index, subview) in subviews.enumerated(){
            let viewSize = subview.sizeThatFits(.unspecified)
            
            let xPos = cos(angle * Double(index) - .pi / 2) * (radius - viewSize.width / 2)
            let yPos = sin(angle * Double(index) - .pi / 2) * (radius - viewSize.height / 2)
            
            let point = CGPoint(x: bounds.midX + xPos, y: bounds.midY + yPos)
             
            subview.place(at: point, anchor: .center, proposal: .unspecified)
        }
    }
    
}

struct RadialLayoutsPractice: View {
    
    
    @State private var count = 16
    @State private var isExpanded = false
    
    var body: some View {
        
        
        RadialLayout(rollOut: !isExpanded ? 0 : 1){
            ForEach(0..<count, id: \.self){ _ in
                
                    Circle()
                    .frame(width: 32, height: 32)
            }
        }
        .safeAreaInset(edge: .bottom) {
            Stepper("Count: \(count)", value: $count.animation(), in: 0...36)
                .padding()
            Button("Expand"){
                withAnimation(.easeInOut(duration: 1)) {
                    isExpanded.toggle()
                }
            }
        }
        
    }
}

#Preview {
    RadialLayoutsPractice()
}

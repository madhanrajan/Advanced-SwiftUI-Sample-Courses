//
//  RelativeWidthLayout.swift
//  Pro SwiftUI
//
//  Created by Madhan on 21/09/2023.
//

import SwiftUI

struct RelativeHStack: Layout {
    
    var spacing = 0.0
    
    
    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        let width = proposal.replacingUnspecifiedDimensions().width
        let viewFrames = frames(for: subviews, in: width)
        let lowestView = viewFrames.max { $0.maxY < $1.maxY } ?? .zero
        
        return CGSize(width: width, height: lowestView.maxY)
    }
    
    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        let viewFrames = frames(for: subviews, in: bounds.width)
        
        for index in subviews.indices {
            let frame = viewFrames[index]
            let position = CGPoint(x: bounds.minX + frame.minX, y: bounds.midY)
            subviews[index].place(at: position, anchor: .leading, proposal: ProposedViewSize(frame.size))
        }
    }
    
    func frames(for subviews: Subviews, in totalWidth: Double) -> [CGRect] {
        let totalSpacing = spacing * Double(subviews.count - 1)
        let availableWidth = totalWidth - totalSpacing
        
        let totalPriorities = subviews.reduce(0) { $0 + $1.priority }
        
        var viewFrames = [CGRect]()
        var x = 0.0
        
        for subview in subviews {
            let subviewWidth = availableWidth * subview.priority / totalPriorities
            let proposal = ProposedViewSize(width: subviewWidth, height: nil)
            let size = subview.sizeThatFits(proposal)
            
            let frame = CGRect(x: x, y: 0, width: size.width, height: size.height)
            viewFrames.append(frame)
            
            x += size.width + spacing
        }
        
        return viewFrames
    }
}

struct RelativeWidthLayout: View {
    var body: some View {
        RelativeHStack(spacing:  0){
            Text("First")
                .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                .background(.red)
                .layoutPriority(40)
            
            Text("Second")
                .frame(maxWidth: .infinity)
                .background(.green)
                .layoutPriority(20)
            
            Text("Third")
                .frame(maxWidth: .infinity)
                .background(.blue)
                .layoutPriority(10)
        }
    }
}

#Preview {
    RelativeWidthLayout()
}

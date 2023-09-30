//
//  MasonryLayout.swift
//  Pro SwiftUI
//
//  Created by Madhan on 21/09/2023.
//

import SwiftUI

struct MasonryLayout: Layout{
    
    struct Cache {
        var frames: [CGRect]
        var width = 0.0
    }
    
    var columns: Int
    var spacing: Double
    
    static var layoutProperties: LayoutProperties{
        var property = LayoutProperties()
        property.stackOrientation = .vertical
        return property
    }
    
    init(columns: Int = 3, spacing: Double = 5) {
        self.columns = max(1, columns)
        self.spacing = spacing
    }
    
    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout Cache) -> CGSize {
        let width = proposal.replacingUnspecifiedDimensions().width
        let viewFrames = frames(for: subviews, totalWidth: width)
        let bottomView = viewFrames.max { $0.maxY < $1.maxY } ?? .zero
        
        cache.frames = viewFrames
        cache.width = width
        
        return CGSize(width: width, height: bottomView.maxY)
    }
    
    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout Cache) {
        
        if cache.width != bounds.width {
            cache.frames = frames(for: subviews, totalWidth: bounds.width)
            cache.width = bounds.width
        }
        
        for index in subviews.indices {
            let frame = cache.frames[index]
            let position = CGPoint(x: bounds.minX + frame.minX, y: bounds.minX + frame.minY)
            subviews[index].place(at: position, proposal: ProposedViewSize(frame.size))
        }
    }
    
    func frames(for subviews: Subviews , totalWidth: Double) -> [CGRect]{
        let totalSpacing = spacing * Double(columns - 1)
        let columnWidth = (totalWidth - totalSpacing) / Double(columns)
        let columnWidthWithSpacing = columnWidth + spacing
        let proposedSize = ProposedViewSize(width: columnWidth, height: nil)
        
        var viewFrames = [CGRect]()
        var columnHeights = Array(repeating: 0.0, count: columns)
        
        for subview in subviews {
            var selectedColumn = 0
            var selectedHeight = Double.greatestFiniteMagnitude
            
            for (columnIndex, height) in columnHeights.enumerated(){
                if height < selectedHeight {
                    selectedColumn = columnIndex
                    selectedHeight = height
                }
            }
            
            let x = Double(selectedColumn) * columnWidthWithSpacing
            let y = columnHeights[selectedColumn]
            let size = subview.sizeThatFits(proposedSize)
            let frame = CGRect(x: x, y: y, width: size.width, height: size.height)
            
            columnHeights[selectedColumn] += size.height + spacing
            viewFrames.append(frame)
        }
        
        return viewFrames
    }
    
    func makeCache(subviews: Subviews) -> Cache {
        Cache(frames: [])
    }
}

struct PlaceHolderView: View {
    let color: Color = [.blue, .green, .cyan, .indigo, .red, .orange, .pink, .purple].randomElement()!
    let size: CGSize
    
    var body: some View{
        ZStack{
            RoundedRectangle(cornerRadius: 10)
                .fill(color)
            
            Text("\(Int(size.width))x\(Int(size.height))")
                .foregroundStyle(.white)
                .minimumScaleFactor(0.5)
        }
        .aspectRatio(size, contentMode: .fill)
    }
}

struct MasonryLayoutGuide: View {
    
    @State private var columns = 3
    
    @State private var views = (0..<20).map { _ in
        CGSize(width: .random(in: 100...500), height: .random(in: 100...500))
    }
    
    var body: some View {
        ScrollView{
            MasonryLayout(columns: columns){
                ForEach(0..<20){ viewIndex in
                    PlaceHolderView(size: views[viewIndex])
                }
            }
            .padding(.horizontal)
        }
        .safeAreaInset(edge: .bottom) {
            Stepper("Columns \(columns)", value: $columns.animation(), in: 1...5)
                .padding()
                .background(.regularMaterial)
        }
    }
}

#Preview {
    MasonryLayoutGuide()
}

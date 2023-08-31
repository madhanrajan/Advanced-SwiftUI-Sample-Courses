//
//  Optionals.swift
//  Pro SwiftUI
//
//  Created by Madhan on 02/08/2023.
//

import SwiftUI

struct AnimatableZIndexModifier: ViewModifier, Animatable {
    
    var index: Double
    
    var animatableData: Double{
        get{index}
        set{index = newValue}
    }
    
    func body(content: Content) -> some View {
        content
            .zIndex(index)
    }
}

extension View{
    func animatibleZIndex(_ index: Double) -> some View {
        self.modifier(AnimatableZIndexModifier(index: index))
    }
}

struct Optionals: View {
    
    @State var redAtFront = false
    
    let colors: [Color] = [.blue, . green, .orange, .purple, .cyan]
    
    var body: some View {
        VStack{
            
            Button("Toggle Z Index") {
                withAnimation() {
                    redAtFront.toggle()
                }
            }
            
            ZStack{
                RoundedRectangle(cornerRadius: 25)
                    .fill(.red)
                    .animatibleZIndex(redAtFront ? 6 : 0)
                
                ForEach(0..<5) { i in
                    RoundedRectangle(cornerRadius: 25)
                        .fill(colors[i])
                        .offset(x: Double(i+1) * 20, y:Double(i+1)*20)
                        .zIndex(Double(i))
                }
            }
            .frame(width: 200, height: 200)
            
        }
    }
}

#Preview {
    Optionals()
}

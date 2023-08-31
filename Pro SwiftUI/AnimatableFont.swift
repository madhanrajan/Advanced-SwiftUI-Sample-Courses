//
//  AnimatableFont.swift
//  Pro SwiftUI
//
//  Created by Madhan on 02/08/2023.
//

import SwiftUI

struct AnimatableFontModifier: ViewModifier, Animatable {
    
    var fontSize: Double
    
    func body(content: Content) -> some View {
        content
            .font(.system(size: fontSize))
    }
}

extension View {
    func animatableFont(size: Double) -> some View{
        self.modifier(AnimatableFontModifier(fontSize: size))
    }
}

struct AnimatableFont: View {
    
    @State var scaleUp = false
    
    var body: some View {
        VStack{
            Text("Hello, World!")
                .animatableFont(size: !scaleUp ? 18 : 30)
                
            
            Toggle("Change font size", isOn: $scaleUp.animation(.spring(response: 0.5, dampingFraction: 0.5)))
                .padding()
        }
        
        
    }
}

#Preview {
    AnimatableFont()
}

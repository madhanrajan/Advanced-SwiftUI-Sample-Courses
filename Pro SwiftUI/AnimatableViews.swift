//
//  AnimatableViews.swift
//  Pro SwiftUI
//
//  Created by Madhan on 04/08/2023.
//

import SwiftUI

struct CountingText: View, Animatable {
    var value: Double
    var fractionLength = 8
    
    var animatableData: Double{
        get{ value }
        set {value = newValue}
    }
    
    var body: some View{
        Text(value.formatted(.number.precision(.fractionLength(fractionLength))))
    }
}

struct TypewriterText: View, Animatable {
    var string: String
    var count = 0
    
    var animatableData: Double {
        get { Double(count) }
        set { count = Int(max(0, newValue)) }
    }
    
    var body: some View {
        let stringToShow = String(string.prefix(count))
        Text(string)
            .hidden()
            .overlay (
                Text(stringToShow)
                
            )
    }
}

struct AnimatableViews: View {
    
    @State private var value = 0
    let message = "This is a long text that appears letter by letter"
    
    var body: some View {
        VStack{
            TypewriterText(string: message, count: value)
                .multilineTextAlignment(.center)
                .frame(width: 300, alignment: .leading)
            
            
            Button("Type!"){
                withAnimation(.linear(duration: 2)) {
                    value = message.count
                }
            }
            
            Button("Reset"){
                withAnimation(.linear(duration: 2)) {
                    value = 0
                }
            }
            
        }
    }
}

#Preview {
    AnimatableViews()
}

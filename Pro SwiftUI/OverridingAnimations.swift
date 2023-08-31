//
//  OverridingAnimations.swift
//  Pro SwiftUI
//
//  Created by Madhan on 15/08/2023.
//

import SwiftUI

func withMotionAnimation<Result>(_ animation: Animation? = .default, _ body: () throws -> Result) rethrows -> Result {
    
    if UIAccessibility.isReduceMotionEnabled {
        return try body()
    }else{
        return try withAnimation(animation, body)
    }
    
}

func withHighPriorityAnimation<Result>(_ animation: Animation? = .default, _ body: () throws -> Result) rethrows -> Result{
    var transaction = Transaction(animation: animation)
    transaction.disablesAnimations = true
    
    return try withTransaction(transaction, body)
    
    
}

struct MotionAnimationModifier<V: Equatable>: ViewModifier{
    
    @Environment(\.accessibilityReduceMotion) var accessibilityReduceMotion
    
    let animation: Animation?
    let value: V
    
    func body(content: Content) -> some View{
        if accessibilityReduceMotion{
            content
        }else{
            content.animation(animation, value: value)
        }
    }
    
}

extension View{
    func motionAnimation<V: Equatable>( _ animation: Animation?, value: V) -> some View{
        self.modifier(MotionAnimationModifier(animation: animation, value: value))
    }
}

struct CircleGrid: View{
    
    var useRedFill = false
    
    
    
    var body: some View{
        LazyVGrid(columns: [.init(.adaptive(minimum: 64))], content: {
            ForEach(0..<30){ i in
                Circle()
                    .fill(useRedFill ? .red : .blue)
                    .frame(height: 64)
                    .transaction { transaction in
                        transaction.animation = transaction.animation?.delay(Double(i) / 10)
                    }
            }
            
            
            
        })
    }
}

struct OverridingAnimations: View {
    
    @State private var useRedFill = false
    
    var body: some View {
        
        VStack{
            CircleGrid(useRedFill: useRedFill)
                
            Spacer()
            
            Button("Use red fill") {
                withAnimation {
                    useRedFill.toggle()
                }
            }
            
        }
        .padding()
    }
}

#Preview {
    OverridingAnimations()
}

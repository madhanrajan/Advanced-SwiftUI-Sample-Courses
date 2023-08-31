//
//  EnvironmentLessions.swift
//  Pro SwiftUI
//
//  Created by Madhan on 31/08/2023.
//

import SwiftUI

struct FormAsteriskIsRequired: EnvironmentKey{
    static var defaultValue = false
}

extension EnvironmentValues{
    var addAsterisk: Bool {
        get {
            self[FormAsteriskIsRequired.self]
        }
        set{
            self[FormAsteriskIsRequired.self] = newValue
        }
    }
}

extension View{
    func addAsterisk(_ value: Bool = true) -> some View{
        environment(\.addAsterisk, value)
    }
}

struct AsteriskedTextField: View {
    @Environment(\.addAsterisk) var addAsterisk
    
    let title: String
    @Binding var text: String
    
    var body: some View{
        
        HStack{
            TextField(title, text: $text)
            
            if addAsterisk{
                Image(systemName: "asterisk")
                    .imageScale(.small)
                    .foregroundStyle(.red)
            }
        }
        
    }
    
    
}

struct StrokeWidthEnvironment: EnvironmentKey{
    
    static var defaultValue: CGFloat = 1.0
    
}

extension EnvironmentValues{
    
    public var strokeWidth: CGFloat{
        get{
            self[StrokeWidthEnvironment.self]
        }set{
            self[StrokeWidthEnvironment.self] = newValue
        }
    }
    
}

extension View{
    public func strokeWidth( _ value: CGFloat) -> some View{
        environment(\.strokeWidth, value)
    }
}

struct CirclesView: View{
    
    @Environment(\.strokeWidth) var strokeWidth
    
    var body: some View{
        VStack{
            ForEach(0..<3){ _ in
                Circle()
                    .stroke(.blue, lineWidth: strokeWidth)
            }
        }
    }
}



struct EnvironmentLessons: View {
    
    @State var sliderValue = 0.0
    
    @State var asteriskState = false
    
    var body: some View {
        VStack{
            
            CirclesView()
            
            Slider(value: $sliderValue, in: 0...10)
        }
        .strokeWidth(sliderValue)
        .padding()
    }
}

#Preview {
    EnvironmentLessons()
}

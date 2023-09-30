//
//  LearningPreferences.swift
//  Pro SwiftUI
//
//  Created by Madhan on 31/08/2023.
//

import SwiftUI

struct WidthPreferenceKey: PreferenceKey {
    static let defaultValue = 0.0
    
    static func reduce(value: inout Double, nextValue: () -> Double) {
        value = nextValue()
    }
}

struct SizingView: View {
    @State private var width = 50.0
    
    var body: some View{
        Color.red
            .frame(width: width, height: 100)
            .onTapGesture {
                width = Double.random(in: 50...160)
            }
            .preference(key: WidthPreferenceKey.self, value: width)
    }
}

struct LearningPreferences: View {
    
    @State private var width = 0.0
    
    var body: some View {
        NavigationStack{
            VStack{
                SizingView()
                
                Text("100%")
                    .frame(width: width)
                    .background(.red)
                Text("150%")
                    .frame(width: width * 1.5)
                    .background(.blue)
                Text("200%")
                    .frame(width: width * 2.0)
                    .background(.green)
                
                
            }
            .onPreferenceChange(WidthPreferenceKey.self) {
                width = $0
            }
            .navigationTitle("Width \(width)")
        }
    }
}

#Preview {
    LearningPreferences()
}

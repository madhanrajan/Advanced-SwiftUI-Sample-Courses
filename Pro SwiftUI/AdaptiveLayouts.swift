//
//  AdaptiveLayouts.swift
//  Pro SwiftUI
//
//  Created by Madhan on 19/09/2023.
//

import SwiftUI

struct ExampleView: View{
    @State private var counter = 0
    let color: Color
    
    var body: some View{
        Button(action: {
            counter += 1
        }, label: {
            RoundedRectangle(cornerRadius: 15)
                .fill(color)
                .overlay{
                    Text(String(counter))
                        .foregroundStyle(.white)
                        .font(.largeTitle )
                }
        })
        .frame(width: 100, height: 100)
        .rotationEffect(.degrees(.random(in: -20...20)))
    }
}

struct AdaptiveLayouts: View {
    
    let layouts = [AnyLayout(VStackLayout()), AnyLayout(HStackLayout()), AnyLayout(ZStackLayout()), AnyLayout(GridLayout())]
    @State private var currentLayout = 0
    
    var layout: AnyLayout{
        layouts[currentLayout]
    }
    
    
    var body: some View {
        VStack{
            Spacer()
            
            layout{
                GridRow{
                    ExampleView(color: .red)
                    ExampleView(color: .green)
                }
                
                GridRow {
                    ExampleView(color: .blue)
                    ExampleView(color: .orange)
                }
                
            }
            
            Spacer()
            
            Button("Change layout") {
                withAnimation {
                    currentLayout += 1
                    
                    currentLayout %= layouts.count
                    
                }
            }
            .buttonStyle(.borderedProminent)
        }
    }
}

#Preview {
    AdaptiveLayouts()
}

//
//  ItemsShuffle.swift
//  Pro SwiftUI
//
//  Created by Madhan on 01/08/2023.
//

import SwiftUI

struct ItemsShuffle: View {
    
    @State private var items = Array(1...20)
    
    let colors: [Color] = [.blue, .cyan, .gray, .green, .indigo, .mint, .orange, .pink, .purple, .red]
    
    let symbols = ["run", "archery", "basketball", "bowling", "dance", "golf", "hiking","jumprope", "rugby","tennis","volleyball", "yoga"]
        
    @State var id = UUID()
    
    var body: some View {
            VStack{
                
                    
                ZStack{
                    Circle()
                        .fill(colors    .randomElement()!)
                        
                    Image(systemName: "figure.\(symbols.randomElement()!)")
                        .font(.system(size: 144))
                        .foregroundColor(.white)
                        
                }
                
                .transition(.slide)
                .id(id)

                Button("Change"){
                    withAnimation(.easeInOut(duration: 1)) {
                        id = UUID()
                    }
                }
                .buttonStyle(.borderedProminent)
                .padding(.bottom)
            }
        }
}

#Preview{
    ItemsShuffle()
}

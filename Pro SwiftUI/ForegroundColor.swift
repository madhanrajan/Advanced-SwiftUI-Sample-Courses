//
//  ForegroundColor.swift
//  Pro SwiftUI
//
//  Created by Madhan on 02/08/2023.
//

import SwiftUI

struct ForegroundColor: View {
    
    @State private var isRed = false
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .foregroundStyle(!isRed ? .green : .red)
            .font(.largeTitle)
            .onTapGesture{
                withAnimation(.easeInOut.repeatForever()) {
                    isRed.toggle()
                }
            }
    }
}

#Preview {
    ForegroundColor()
}

//
//  OverridingEnvironment.swift
//  Pro SwiftUI
//
//  Created by Madhan on 31/08/2023.
//

import SwiftUI

struct WelcomeView: View{
    var body: some View{
        VStack{
            Image(systemName: "sun.max")
                .transformEnvironment(\.font) { font in
                    font = font?.weight(.black)
                }
            Text("Welcome!")
        }
    }
}

struct OverridingEnvironment: View {
    var body: some View {
        WelcomeView()
            .font(.largeTitle)
    }
}

#Preview {
    OverridingEnvironment()
}

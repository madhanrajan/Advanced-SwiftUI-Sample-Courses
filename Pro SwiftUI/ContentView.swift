//
//  ContentView.swift
//  Pro SwiftUI
//
//  Created by Madhan on 31/07/2023.
//

import SwiftUI
import Alamofire

struct ContentView: View {
    
    @State var shouldBeVisible = false
    
    var body: some View {
        VStack {
            Text("Hello")
                .hidden(shouldBeVisible)
            Toggle(shouldBeVisible ? "" : "Toggle to hide view", isOn: $shouldBeVisible.animation())
            
        }
        .padding()
    }
}

extension View{
    func hidden(_ hidden: Bool) -> some View{
        self.opacity(hidden ? 0 : 1)
    }
}





struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}



//
//  AnchorPreferences.swift
//  Pro SwiftUI
//
//  Created by Madhan on 31/08/2023.
//

import SwiftUI

struct Category: Identifiable, Equatable {
    let id: String
    let symbol: String
}

struct CategoryPreference: Equatable {
    let category: Category
    let anchor: Anchor<CGRect>
}

struct CategoryPreferenceKey: PreferenceKey {
    static let defaultValue = [CategoryPreference]()
    
    static func reduce(value: inout [CategoryPreference], nextValue: () -> [CategoryPreference]) {
        
        if !value.contains(nextValue().first!){
            value.append(contentsOf: nextValue())
        }
        
    }
}

struct CategoryButton: View{
    var category: Category
    @Binding var selection: Category?
    
    var body: some View{
        Button(action: {
            
            withAnimation {
                selection = category
            }
            
        }, label: {
            VStack{
                Image(systemName: category.symbol)
                Text(category.id)
            }
        })
        .buttonStyle(.plain)
        .accessibilityElement()
        .accessibilityLabel(category.id)
        .anchorPreference(key: CategoryPreferenceKey.self, value: .bounds, transform: {
            [CategoryPreference(category: category, anchor: $0)]
        })
    }
}

struct AnchorPreferences: View {
    
    @State private var selectedCategory: Category?
    
    let categories = [
        Category(id: "Arctic", symbol: "snowflake"),
        Category(id: "Beach", symbol: "beach.umbrella"),
        Category(id: "Shared Homes", symbol: "house")
    ]
    
    var body: some View {
        VStack {
            HStack(spacing: 20) {
                ForEach(categories) { category in
                    CategoryButton(category: category, selection: $selectedCategory)
                }
            }
        }.overlayPreferenceValue(CategoryPreferenceKey.self, { preferences in
            GeometryReader{ proxy in
                if let selected = preferences.first(where: {$0.category == selectedCategory}){
                    let frame = proxy[selected.anchor]
                    
                    Rectangle()
                        .fill(.black)
                        .frame(width: frame.width, height: 2)
                        .position(x: frame.midX, y: frame.maxY)
                }
            }
        })
        
    }
}

#Preview {
    AnchorPreferences()
}

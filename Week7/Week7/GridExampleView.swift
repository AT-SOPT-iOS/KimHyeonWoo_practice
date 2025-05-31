//
//  VerticalSmileys.swift
//  Week7
//
//  Created by 김현우 on 5/24/25.
//
import SwiftUI

struct VerticalSmileys: View {
    let columns = [GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns) {
                ForEach(0x1f600...0x1f679, id: \.self) { value in
                    Text(String(format:"%x", value))
                    Text(emoji(value))
                        .font(.largeTitle)
                }
            }
        }
    }
    
    private func emoji(_ value: Int) -> String {
        guard let scalar = UnicodeScalar(value) else { return "" }
        return String(Character(scalar))
    }
}

//
//  ContentView.swift
//  Week7
//
//  Created by 김현우 on 5/24/25.
//

import SwiftUI

struct SheetDetailView: View {
    @Binding var isPresented: Bool
    
    var body: some View {
        ZStack {
            Color.yellow.opacity(0.2)
                .ignoresSafeArea()
        
            VStack(spacing: 20) {
                Text("시트 뷰")
                    .font(.title)
                
                Button("닫기") {
                    isPresented = false
                }
                .padding()
                .background(Color.orange)
                .foregroundStyle(.white)
                .clipShape(Capsule())
            }
        }
    }
}

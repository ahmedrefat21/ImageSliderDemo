//
//  ContentView.swift
//  ImageSliderDemo
//
//  Created by Ahmed Refat on 09/09/2024.
//

import SwiftUI

import SwiftUI

struct ContentView: View {
    
    @State private var currentPage = 0
    let images = ["mobil1", "mobil2" , "mobil3"]
    
    var body: some View {
        VStack {
            TabView(selection: $currentPage) {
                ForEach(0..<images.count, id: \.self) { index in
                    Image(images[index])
                        .resizable()
                        .scaledToFill()
                        .tag(index)
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
            .frame(height: 200)
            .cornerRadius(10)
            .padding([.leading, .trailing], 10)
            Spacer()
            .onReceive(timer) { _ in
                withAnimation {
                    currentPage = (currentPage + 1) % images.count
                }
            }
        }
    }
    
    let timer = Timer.publish(every: 2, on: .main, in: .common).autoconnect()
}

#Preview {
    ContentView()
}

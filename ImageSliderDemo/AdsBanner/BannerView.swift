//
//  BannerView.swift
//  ImageSliderDemo
//
//  Created by Ahmed Refat on 16/10/2024.
//

import SwiftUI
import Combine

struct BannerView: View {
    
    @StateObject private var handler: BannerView.Handler
    init(banners: [String]) {
        _handler = .init(wrappedValue: BannerView.Handler(banners: banners))
    }
    
    var body: some View {
        
        VStack {
            ZStack {
                ForEach(handler.banners.indices, id: \.self) { index in
                    AdsBannerCard(imageURL: handler.banners[index])
                        .offset(x: CGFloat(index - handler.currentBannerIndex) * UIScreen.main.bounds.width + handler.offset)
                        //.animation(handler.isDragging ? .linear : .linear, value: handler.offset)
                        .gesture(
                            DragGesture()
                                .onChanged { value in
                                    handler.isDragging = true
                                    //handler.offset = -value.translation.width
                                }
                                .onEnded { value in
                                    if value.translation.width < 0 {
                                        handler.bannerSwipedLeft()
                                    } else if value.translation.width > 0 {
                                        handler.bannerSwipedRight()
                                    }
                                    handler.offset = 0
                                    handler.isDragging = false
                                    handler.resetTimer()
                                }
                        )
                }
            }
            .onAppear {
                handler.startTimer()
            }
            .onDisappear {
                handler.stopTimer()
            }
            PageDotsIndicatorView(currentIndex: $handler.currentBannerIndex, numberOfPages: handler.banners.count)
                .padding(.vertical, 5)
        }
    }
}

#Preview {
    BannerView(
        banners: [
            "https://pv-staging-uploads-bucket.s3.amazonaws.com/Admin/offers_banners/0c6d8273-97e9-4182-993c-8d0a5294d634-FB_IMG.png",
            "https://pv-staging-uploads-bucket.s3.amazonaws.com/Dealer/offers_banners/4e6cb2c9-6f71-4d0d-85ef-fbd1f4fa95aa-discover-lifeblood-mileage-fb-og.jpg",
            "https://pv-staging-uploads-bucket.s3.amazonaws.com/Admin/offers_banners/0c6d8273-97e9-4182-993c-8d0a5294d634-FB_IMG.png",
            "https://11plc.com/wp-content/uploads/2021/12/05-A-1.jpg"
        ])
}

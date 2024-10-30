//
//  AdsBannerView.swift
//  ImageSliderDemo
//
//  Created by Ahmed Refat on 16/10/2024.
//

import SwiftUI

struct AdsBannerView: View {

    @StateObject private var handler: AdsBannerView.Handler
    init(banners: [String]) {
        _handler = .init(wrappedValue: AdsBannerView.Handler(banners: banners))
    }

    var body: some View {
        if handler.banners.isEmpty {
            EmptyView()
        } else {
            VStack(spacing: 0) {
                TabView(selection: $handler.currentBannerIndex) {
                    AdsBannerCard(imageURL: handler.banners[handler.lastIndex])
                        .tag(handler.firstIndex - 1)
                        //.isHidden(handler.banners.count <= 1, remove: true)

                    ForEach(handler.banners.indices, id: \.self) { index in
                        AdsBannerCard(imageURL: handler.banners[index])
                            .tag(index)
                    }

                    AdsBannerCard(imageURL: handler.banners[handler.firstIndex])
                        .tag(handler.banners.count)
                        //.isHidden(handler.banners.count <= 1, remove: true)
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                .aspectRatio(2, contentMode: .fit)
                .onChange(of: handler.currentBannerIndex) {_ in
                    handler.handleCircularSwipe()
                    handler.resetTimer()
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
}
#Preview {
    AdsBannerView(
        banners: [
            "https://pv-staging-uploads-bucket.s3.amazonaws.com/Admin/offers_banners/0c6d8273-97e9-4182-993c-8d0a5294d634-FB_IMG.png",
            "https://pv-staging-uploads-bucket.s3.amazonaws.com/Dealer/offers_banners/4e6cb2c9-6f71-4d0d-85ef-fbd1f4fa95aa-discover-lifeblood-mileage-fb-og.jpg",
            "https://pv-staging-uploads-bucket.s3.amazonaws.com/Admin/offers_banners/0c6d8273-97e9-4182-993c-8d0a5294d634-FB_IMG.png",
            "https://11plc.com/wp-content/uploads/2021/12/05-A-1.jpg"
        ]
    )
}

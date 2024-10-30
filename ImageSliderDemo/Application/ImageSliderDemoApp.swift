//
//  ImageSliderDemoApp.swift
//  ImageSliderDemo
//
//  Created by Ahmed Refat on 09/09/2024.
//

import SwiftUI

@main
struct ImageSliderDemoApp: App {
    var body: some Scene {
        WindowGroup {
            BannerView(banners: [
                "https://pv-staging-uploads-bucket.s3.amazonaws.com/Admin/offers_banners/0c6d8273-97e9-4182-993c-8d0a5294d634-FB_IMG.png",
                "https://pv-staging-uploads-bucket.s3.amazonaws.com/Dealer/offers_banners/4e6cb2c9-6f71-4d0d-85ef-fbd1f4fa95aa-discover-lifeblood-mileage-fb-og.jpg",
                "https://pv-staging-uploads-bucket.s3.amazonaws.com/Admin/offers_banners/0c6d8273-97e9-4182-993c-8d0a5294d634-FB_IMG.png",
                "https://11plc.com/wp-content/uploads/2021/12/05-A-1.jpg"
            ])
        }
    }
}

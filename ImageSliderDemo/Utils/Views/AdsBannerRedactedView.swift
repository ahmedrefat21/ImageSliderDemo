//
//  AdsBannerRedactedView.swift
//  ExxonMobil
//
//  Created by lap store on 21/11/2023.
//

import SwiftUI

struct AdsBannerRedactedView: View {
    var body: some View {
        VStack(spacing: 8) {
            Image(Constants.OffersListImages.offerPlaceholder)
                .offerImageModifier()
                .cornerRadius(12)
            PageDotsIndicatorView(currentIndex: .constant(0), numberOfPages: 4)
        }
        .redacted(reason: .placeholder)
    }
}

#Preview {
    AdsBannerRedactedView()
}

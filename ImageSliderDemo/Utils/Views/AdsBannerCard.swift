//
//  AdsBannerCard.swift
//  ExxonMobil
//
//  Created by Ahmed Refat on 11/09/2024.
//

import SwiftUI
import Kingfisher

struct AdsBannerCard: View {
    var imageURL: String
    var body: some View {
        KFImage(URL(string: imageURL))
            .placeholder {
                Image(Constants.OffersListImages.offerPlaceholder)
                    .offerImageModifier()
                    .cornerRadius(12)
            }
            .offerImageModifier()
            .cornerRadius(12)
            .padding(.horizontal, 20)
    }
}

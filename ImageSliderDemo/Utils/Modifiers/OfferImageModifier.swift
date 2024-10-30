//
//  OfferImageModifier.swift
//  ExxonMobil
//
//  Created by lap store on 15/11/2023.
//

import SwiftUI
import Kingfisher

extension Image {
    func offerImageModifier() -> some View {
        self
            .resizable()
            .aspectRatio(2, contentMode: .fit)
            .frame(maxWidth: .infinity)
   }
}

extension KFImage {
    func offerImageModifier() -> some View {
        self
            .resizable()
            .aspectRatio(2, contentMode: .fit)
            .frame(maxWidth: .infinity)
   }
}

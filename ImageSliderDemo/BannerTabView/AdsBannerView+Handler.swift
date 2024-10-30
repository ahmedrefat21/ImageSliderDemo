//
//  AdsBannerView+Handler.swift
//  ImageSliderDemo
//
//  Created by Ahmed Refat on 16/10/2024.
//

import Foundation
import Combine
import SwiftUI

extension AdsBannerView {
    @MainActor
    class Handler: ObservableObject {

        @Published var currentBannerIndex: Int = 0
        var banners: [String]
        var firstIndex: Int { 0 }
        var lastIndex: Int { banners.count - 1 }
        private var timerCancellable: Cancellable?
        private let duration: Double = 5

        init(banners: [String]) {
            self.banners = banners
        }

        func startTimer() {
            if banners.count > 1 {
                timerCancellable = Timer.publish(every: duration, on: .main, in: .common)
                    .autoconnect()
                    .sink { _ in
                        self.autoSwipe()
                    }
            }
        }

        func stopTimer() {
            timerCancellable?.cancel()
        }

        func resetTimer() {
            stopTimer()
            startTimer()
        }

        func setIndexWithDispatch(index: Int) {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                self.currentBannerIndex = index
            }
        }

        func setIndexWithAnimation() {
            withAnimation(.linear(duration: 0.5)) {
                currentBannerIndex += 1
            }
        }

        func handleCircularSwipe() {
            if currentBannerIndex == banners.count {
                setIndexWithDispatch(index: firstIndex)
            } else if currentBannerIndex == firstIndex - 1 {
                setIndexWithDispatch(index: lastIndex)
            }
        }

        func autoSwipe() {
            if currentBannerIndex == banners.count {
                setIndexWithDispatch(index: firstIndex)
            } else {
                setIndexWithAnimation()
            }
        }
    }
}

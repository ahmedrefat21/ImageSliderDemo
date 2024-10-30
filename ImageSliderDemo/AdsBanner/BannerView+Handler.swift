//
//  BannerView+Handler.swift
//  ImageSliderDemo
//
//  Created by Ahmed Refat on 16/10/2024.
//


import Foundation
import Combine
import SwiftUI

extension BannerView {
    @MainActor
    class Handler: ObservableObject {
        
        @Published var currentBannerIndex: Int = 0
        @Published var offset: CGFloat = 0
        @Published var isDragging: Bool = false
        var banners: [String]
        var firstIndex: Int { 0 }
        var lastIndex: Int { banners.count - 1 }
        private var timerCancellable: Cancellable?
        private let duration: Double = 5
        
        init(banners: [String]) {
            self.banners = banners
        }
        
        func startTimer() {
            timerCancellable = Timer.publish(every: duration, on: .main, in: .common)
                .autoconnect()
                .sink { [weak self] _ in
                    self?.autoSwipe()
                }
        }
            
        func stopTimer() {
            timerCancellable?.cancel()
        }
            
        func resetTimer() {
            stopTimer()
            startTimer()
        }
          
        func changeToPreviousBanner() {
            if currentBannerIndex == firstIndex {
                withAnimation(.none) {
                    currentBannerIndex = lastIndex
                }
            } else {
                withAnimation(.linear) {
                    currentBannerIndex -= 1
                }
            }
        }
        
        func changeToNextBanner() {
            if currentBannerIndex == lastIndex {
                withAnimation(.none) {
                    currentBannerIndex = firstIndex
                }
            } else {
                withAnimation(.linear) {
                    currentBannerIndex += 1
                }
            }
        }
        func bannerSwipedLeft() {
            if !isArabicLanguageSelected() {
                self.changeToNextBanner()
            } else {
                self.changeToPreviousBanner()
            }
        }
        
        func bannerSwipedRight() {
            if !isArabicLanguageSelected() {
                self.changeToPreviousBanner()
            }else {
                self.changeToNextBanner()
            }
        }
        
        func autoSwipe() {
            if !isDragging {
                changeToNextBanner()
            }
        }
        
        func isArabicLanguageSelected() -> Bool {
           true
        }

    }
}

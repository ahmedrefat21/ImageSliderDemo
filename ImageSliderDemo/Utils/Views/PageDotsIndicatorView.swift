//
//  PageDotsIndicatorView.swift
//  ImageSliderDemo
//
//  Created by Ahmed Refat on 11/09/2024.
//

import SwiftUI

struct PageDotsIndicatorView: View {

    // MARK: - Binding Properties
    @Binding var currentIndex: Int

    // MARK: - Public Properties
    let numberOfPages: Int
    var visibleCount = 5
    var circleSize: CGFloat = 10
    var circleSpacing: CGFloat = 6
    var primaryIndicatorImage = Constants.CommonImages.selectedIndicator
    var secondaryIndicatorImage = Constants.CommonImages.unselectedIndicator
    let smallRangeScale: CGFloat = 0.8
    let wideRangeScale: CGFloat = 0.6

    // MARK: - Body
    var body: some View {
        VStack(alignment: .center) {
            ScrollViewReader { scroll in
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: circleSpacing) {
                        ForEach(0..<numberOfPages) { index in
                            Image(currentIndex == index ? primaryIndicatorImage :
                                    secondaryIndicatorImage)
                            .resizable()
                            .scaleEffect(getScaleEffect(index: index))
                            .frame(width: circleSize, height: circleSize)
                            .id(index)
                        }
                    }
                }.frame(width: getScrollWidth(), alignment: .center)
                    .disabled(true)
                .onChange(of: currentIndex, perform: { _ in
                    withAnimation {
                        scroll.scrollTo(currentIndex, anchor: .center)
                    }
                })
            }
        }
    }
}

#Preview {
    PageDotsIndicatorView(currentIndex: .constant(0), numberOfPages: 10)
}


extension PageDotsIndicatorView {
    func indexInWideRange(index: Int) -> Bool {
        if currentIndex - 2 < 0 {
            return (0...4).contains(index)
        } else if currentIndex + 2 > numberOfPages - 1 {
            return ((numberOfPages - 5)...(numberOfPages - 1)).contains(index)
        } else {
            return ((currentIndex - 2)...(currentIndex + 2)).contains(index)
        }
    }

    func indexInSmallRange(index: Int) -> Bool {
        if currentIndex - 2 < 0 {
            return (0...3).contains(index)
        } else if currentIndex + 2 > numberOfPages - 1 {
            return ((numberOfPages - 4)...(numberOfPages - 1)).contains(index)
        } else {
            return ((currentIndex - 1)...(currentIndex + 1)).contains(index)
        }
    }

    func getScaleEffect(index: Int) -> CGFloat {
        if currentIndex == index {
            return 1
        } else if indexInSmallRange(index: index) {
            return smallRangeScale
        } else {
            return wideRangeScale
        }
    }

    func getScrollWidth() -> CGFloat {
        var actualCount = CGFloat(visibleCount)
        if numberOfPages < visibleCount {
            actualCount = CGFloat(numberOfPages)
        }
        return (actualCount * circleSize) + ((actualCount - 1) * circleSpacing)
    }
}

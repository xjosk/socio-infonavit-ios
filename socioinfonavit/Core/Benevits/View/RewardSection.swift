//
//  RewardSection.swift
//  socioinfonavit
//
//  Created by Andrei Carvajal on 19/02/26.
//

import SwiftUI
import CachedAsyncImage

struct RewardSection: View {
    var benevitSection: BenevitSection? = nil
    
    var body: some View {
        VStack(alignment: .leading) {
            Group {
                if let benevitSection = benevitSection {
                    Text(benevitSection.title)
                } else {
                    Rectangle()
                        .fill(.white)
                        .frame(width: 90, height: 20)
                }
            }
            .padding(.horizontal)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 16) {
                    if let benevitSection = benevitSection {
                        ForEach(benevitSection.benevitItems, id: \.self) { item in
                            RewardCard(benevitItem: item)
                        }
                    } else {
                        ForEach(0...3, id: \.self) { _ in
                            RewardCard()
                        }
                    }
                }
                .padding(.horizontal)
            }
        }
    }
}

#Preview {
    RewardSection()
        .background(Color.gray.opacity(0.25))
}

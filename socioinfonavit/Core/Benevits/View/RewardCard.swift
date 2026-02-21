//
//  RewardCard.swift
//  socioinfonavit
//
//  Created by Andrei Carvajal on 20/02/26.
//

import SwiftUI
import CachedAsyncImage

struct RewardCard: View {
    var benevitItem: BenevitItem? = nil
    
    var body: some View {
        RoundedRectangle(cornerRadius: 8)
            .fill(Color.white)
            .frame(width: 180, height: 200)
            .overlay(
                GeometryReader { proxy in
                    if let benevitItem = benevitItem {
                        if !benevitItem.isLocked {
                            VStack(alignment: .leading) {
                                CachedAsyncImage(url: URL(string: benevitItem.benevit.providerImagePath))
                                { asyncImagePhase in
                                    if let image = asyncImagePhase.image {
                                        image
                                            .resizable()
                                    } else {
                                        ProgressView()
                                            .frame(alignment: .center)
                                    }
                                }
                                .frame(height: proxy.size.height / 3)
                                
                                VStack(alignment: .leading) {
                                    Text(benevitItem.benevit.name)
                                        .font(.footnote)
                                    Spacer()
                                    Text(benevitItem.benevit.location)
                                        .font(.footnote)
                                        .fontWeight(.bold)
                                    Text(benevitItem.benevit.promotion)
                                        .font(.footnote)
                                }
                                .padding()
                            }
                        } else {
                            VStack {
                                CachedAsyncImage(url: URL(string: benevitItem.benevit.benefitImagePath!))
                                { asyncImagePhase in
                                    if let image = asyncImagePhase.image {
                                        image
                                            .resizable()
                                    } else {
                                        ProgressView()
                                            .frame(alignment: .center)
                                    }
                                }
                                Button {
                                    
                                } label: {
                                    Text("LO QUIERO")
                                        .font(.caption)
                                        .tint(.white)
                                        .foregroundColor(.white)
                                        .frame(maxWidth: .infinity)
                                        .padding(.vertical, 8)
                                        .background(Color.appRed)
                                        .clipShape(RoundedRectangle(cornerRadius: 4))
                                }
                            }
                            .padding()
                        }
                    } else {
                        VStack {
                            Rectangle()
                                .fill(.appGray.opacity(0.75))
                                .frame(height: proxy.size.height / 3)
                        }
                    }
                }
            )
            .clipShape(RoundedRectangle(cornerRadius: 8))
    }
}

#Preview {
    RewardCard()
}

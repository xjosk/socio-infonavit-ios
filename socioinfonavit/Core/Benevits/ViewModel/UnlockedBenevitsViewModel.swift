//
//  UnlockedBenevitsViewModel.swift
//  socioinfonavit
//
//  Created by Andrei Carvajal on 20/02/26.
//

import Foundation
import Combine

class UnlockedBenevitsViewModel: ObservableObject {
    @Published var benevitsState: AsyncDataState<[BenevitSection]> = .loading
    private let rewardRepository: RewardRepository
    
    
    init(rewardRepository: RewardRepository = RewardRepositoryImpl()) {
        self.rewardRepository = rewardRepository
    }
    
    func getUnlockedRewards() async throws {
        do {
            let result = try await rewardRepository.getUnlockedRewards()
            
            let sections: [BenevitSection] = result.map { key, value in
                BenevitSection(
                    title: key,
                    benevitItems: value
                )
            }
            
            benevitsState = .success(sections)
        } catch {
            benevitsState = .failure(String(describing: error))
        }
    }
}

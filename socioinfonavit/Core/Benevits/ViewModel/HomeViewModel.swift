//
//  HomeViewModel.swift
//  socioinfonavit
//
//  Created by Andrei Carvajal on 20/02/26.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject {
    @Published var benevitsState: AsyncDataState<[BenevitSection]> = .loading
    @Published var query: String = ""
    
    private let rewardRepository: RewardRepository
    private var cancellables = Set<AnyCancellable>()
    
    init(rewardRepository: RewardRepository = RewardRepositoryImpl()) {
        self.rewardRepository = rewardRepository
        setupSearchDebounce()
    }
    
    private func setupSearchDebounce() {
        $query
            .debounce(for: .milliseconds(500), scheduler: RunLoop.main)
            .removeDuplicates()
            .sink { [weak self] value in
                Task {
                    try? await self?.getRewards(with: value)
                }
            }
            .store(in: &cancellables)
    }
    
    func getRewards(with query: String = "") async throws {
        benevitsState = .loading
        
        do {
            let result = try await rewardRepository.getRewards(with: query)
            
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

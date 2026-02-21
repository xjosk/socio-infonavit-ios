//
//  RewardRepository.swift
//  socioinfonavit
//
//  Created by Andrei Carvajal on 20/02/26.
//

import Foundation

protocol RewardRepository: AnyObject {
    func getRewards(with query: String) async throws -> [String : [BenevitItem]]
    func getUnlockedRewards() async throws -> [String: [BenevitItem]]
}

final class RewardRepositoryImpl: RewardRepository {
    func getUnlockedRewards() async throws -> [String : [BenevitItem]] {
        try await Task.sleep(nanoseconds: 2_000_000_000)
        
        let benevits = [
            Benevit(
                name: "PlayStation 5",
                providerImagePath: "https://i.imgur.com/9JeKKN1.png",
                benefitImagePath: nil,
                category: "Entretenimiento",
                location: "Todo México",
                promotion: "10% de descuento",
            ),
            Benevit(
                name: "Dyson V15 Vacuum",
                providerImagePath: "https://i.imgur.com/wuKMt79.png",
                benefitImagePath: nil,
                category: "Electrónicos",
                location: "Sólo CDMX",
                promotion: "15% de descuento",
            ),
            Benevit(
                name: "$200 Amazon Gift Card",
                providerImagePath: "https://i.imgur.com/9JeKKN1.png",
                benefitImagePath: nil,
                category: "Finanzas",
                location: "Todo México",
                promotion: "Obtén $200 en tarjeta de regalo",
            ),
            Benevit(
                name: "Milwaukee Impact Drill",
                providerImagePath: "https://i.imgur.com/9JeKKN1.png",
                benefitImagePath: nil,
                category: "Mecánica",
                location: "Sólo Tampico, Colima, San Luis Potosí",
                promotion: "20% de descuento",
            ),
            Benevit(
                name: "Nintendo Switch OLED",
                providerImagePath: "https://i.imgur.com/wuKMt79.png",
                benefitImagePath: nil,
                category: "Entretenimiento",
                location: "Todo México",
                promotion: "12% de descuento",
            ),
            Benevit(
                name: "Samsung 55\" 4K TV",
                providerImagePath: "https://i.imgur.com/9JeKKN1.png",
                benefitImagePath: nil,
                category: "Electrónicos",
                location: "Sólo Quintana Roo",
                promotion: "25% de descuento",
            ),
            Benevit(
                name: "$50 Starbucks Gift Card",
                providerImagePath: "https://i.imgur.com/9JeKKN1.png",
                benefitImagePath: nil,
                category: "Finanzas",
                location: "Todo México",
                promotion: "Recibe $50 en tarjeta",
            ),
            Benevit(
                name: "$100 Visa Gift Card",
                providerImagePath: "https://i.imgur.com/wuKMt79.png",
                benefitImagePath: nil,
                category: "Finanzas",
                location: "Sólo CDMX",
                promotion: "Recibe $100 en tarjeta",
            ),
            Benevit(
                name: "Bosch Socket Wrench Kit",
                providerImagePath: "https://i.imgur.com/9JeKKN1.png",
                benefitImagePath: nil,
                category: "Mecánica",
                location: "Sólo Tampico, Colima, San Luis Potosí",
                promotion: "18% de descuento",
            ),
        ]
        
        let enrichedBenevits = benevits.map { BenevitItem(benevit: $0, isLocked: false) }
        
        let groupedByCategory = Dictionary(grouping: enrichedBenevits) { $0.benevit.category }
        
        return groupedByCategory
    }
    
    func getRewards(with query: String = "") async throws -> [String : [BenevitItem]] {
        try await Task.sleep(nanoseconds: 2_000_000_000)
        
        let benevits = LandingBenevits(
            locked: [
                Benevit(
                    name: "Xbox Series X",
                    providerImagePath: "https://i.imgur.com/9JeKKN1.png",
                    benefitImagePath: "https://i.imgur.com/TfHflS4.png",
                    category: "Entretenimiento",
                    location: "Todo México",
                    promotion: "10% de descuento",
                ),
                Benevit(
                    name: "AirPods Pro",
                    providerImagePath: "https://i.imgur.com/9JeKKN1.png",
                    benefitImagePath: "https://i.imgur.com/TfHflS4.png",
                    category: "Entretenimiento",
                    location: "Sólo CDMX",
                    promotion: "15% de descuento",
                ),
                Benevit(
                    name: "Instant Pot Duo",
                    providerImagePath: "https://i.imgur.com/wuKMt79.png",
                    benefitImagePath: "https://i.imgur.com/TfHflS4.png",
                    category: "Electrónicos",
                    location: "Sólo Quintana Roo",
                    promotion: "20% de descuento",
                ),
                Benevit(
                    name: "Makita Tool Set",
                    providerImagePath: "https://i.imgur.com/9JeKKN1.png",
                    benefitImagePath: "https://i.imgur.com/TfHflS4.png",
                    category: "Mecánica",
                    location: "Sólo Tampico, Colima, San Luis Potosí",
                    promotion: "22% de descuento",
                ),
                Benevit(
                    name: "KitchenAid Stand Mixer",
                    providerImagePath: "https://i.imgur.com/wuKMt79.png",
                    benefitImagePath: "https://i.imgur.com/TfHflS4.png",
                    category: "Electrónicos",
                    location: "Todo México",
                    promotion: "18% de descuento",
                ),
                Benevit(
                    name: "Spotify Premium 1 Year",
                    providerImagePath: "https://i.imgur.com/wuKMt79.png",
                    benefitImagePath: "https://i.imgur.com/TfHflS4.png",
                    category: "Entretenimiento",
                    location: "Todo México",
                    promotion: "1 año por $999",
                ),
            ],
            unlocked: [
                Benevit(
                    name: "PlayStation 5",
                    providerImagePath: "https://i.imgur.com/9JeKKN1.png",
                    benefitImagePath: nil,
                    category: "Entretenimiento",
                    location: "Todo México",
                    promotion: "10% de descuento",
                ),
                Benevit(
                    name: "Dyson V15 Vacuum",
                    providerImagePath: "https://i.imgur.com/wuKMt79.png",
                    benefitImagePath: nil,
                    category: "Electrónicos",
                    location: "Sólo CDMX",
                    promotion: "15% de descuento",
                ),
                Benevit(
                    name: "$200 Amazon Gift Card",
                    providerImagePath: "https://i.imgur.com/9JeKKN1.png",
                    benefitImagePath: nil,
                    category: "Finanzas",
                    location: "Todo México",
                    promotion: "Obtén $200 en tarjeta de regalo",
                ),
                Benevit(
                    name: "Milwaukee Impact Drill",
                    providerImagePath: "https://i.imgur.com/9JeKKN1.png",
                    benefitImagePath: nil,
                    category: "Mecánica",
                    location: "Sólo Tampico, Colima, San Luis Potosí",
                    promotion: "20% de descuento",
                ),
                Benevit(
                    name: "Nintendo Switch OLED",
                    providerImagePath: "https://i.imgur.com/wuKMt79.png",
                    benefitImagePath: nil,
                    category: "Entretenimiento",
                    location: "Todo México",
                    promotion: "12% de descuento",
                ),
                Benevit(
                    name: "Samsung 55\" 4K TV",
                    providerImagePath: "https://i.imgur.com/9JeKKN1.png",
                    benefitImagePath: nil,
                    category: "Electrónicos",
                    location: "Sólo Quintana Roo",
                    promotion: "25% de descuento",
                ),
                Benevit(
                    name: "$50 Starbucks Gift Card",
                    providerImagePath: "https://i.imgur.com/9JeKKN1.png",
                    benefitImagePath: nil,
                    category: "Finanzas",
                    location: "Todo México",
                    promotion: "Recibe $50 en tarjeta",
                ),
                Benevit(
                    name: "$100 Visa Gift Card",
                    providerImagePath: "https://i.imgur.com/wuKMt79.png",
                    benefitImagePath: nil,
                    category: "Finanzas",
                    location: "Sólo CDMX",
                    promotion: "Recibe $100 en tarjeta",
                ),
                Benevit(
                    name: "Bosch Socket Wrench Kit",
                    providerImagePath: "https://i.imgur.com/9JeKKN1.png",
                    benefitImagePath: nil,
                    category: "Mecánica",
                    location: "Sólo Tampico, Colima, San Luis Potosí",
                    promotion: "18% de descuento",
                ),
            ],
        )
        
        let enrichedBenevits: [BenevitItem] =
        benevits.locked.map {
            BenevitItem(
                benevit: $0,
                isLocked: true
            )
        }
        +
        benevits.unlocked.map {
            BenevitItem(
                benevit: $0,
                isLocked: false
            )
        }
        
        let filteredBenevits = query.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
        ? enrichedBenevits
        : enrichedBenevits.filter {
            $0.benevit.name.localizedCaseInsensitiveContains(query)
            || $0.benevit.category.localizedCaseInsensitiveContains(query)
            || $0.benevit.location.localizedCaseInsensitiveContains(query)
        }
        
        let groupedByCategory = Dictionary(grouping: filteredBenevits) { $0.benevit.category }
        
        return groupedByCategory
    }
}

//
//  Benevit.swift
//  socioinfonavit
//
//  Created by Andrei Carvajal on 20/02/26.
//

import Foundation

struct Benevit: Decodable & Hashable {
    let name: String
    let providerImagePath: String
    let benefitImagePath: String?
    let category: String
    let location: String
    let promotion: String
}

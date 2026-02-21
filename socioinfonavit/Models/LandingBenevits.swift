//
//  LandingBenevits.swift
//  socioinfonavit
//
//  Created by Andrei Carvajal on 20/02/26.
//

import Foundation

struct LandingBenevits: Decodable {
    let locked: [Benevit]
    let unlocked: [Benevit]
}

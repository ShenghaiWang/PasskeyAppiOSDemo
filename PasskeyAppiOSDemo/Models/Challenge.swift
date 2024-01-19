//
//  Challenge.swift
//  PasskeyAppiOSDemo
//
//  Created by Tim Wang on 26/1/2024.
//

import Foundation

struct Challenge {
    let challenge: Data
}

extension Challenge {
    init(user: User) {
        let challenge = (user.name + UUID().uuidString).data(using: .utf8) ?? Data()
        self.init(challenge: challenge)
    }
}

//
//  User.swift
//  PasskeyAppiOSDemo
//
//  Created by Tim Wang on 26/1/2024.
//

import Foundation

struct User {
    let name: String
    let id: String

    init(name: String, id: String = UUID().uuidString) {
        self.name = name
        self.id = id
    }
}

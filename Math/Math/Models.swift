//
//  Model.swift
//  Math
//
//  Created by vitasiy on 28/08/2023.
//

import Foundation

struct Attempt {
    let counter: Int
    let time: String
    let solved: Int
    let level: Int
}

struct Player {
    var name: String
    var attempts: [Attempt]
}


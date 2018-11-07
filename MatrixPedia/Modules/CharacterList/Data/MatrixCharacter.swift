//
//  MatrixCharacter.swift
//  MatrixPedia
//
//  Created by Adrián Silva on 07/11/2018.
//  Copyright © 2018 Adrián Silva. All rights reserved.
//

import Foundation

enum MatrixCharacterType: String, Codable {
    case resistance, programs, exiles, potentials, truce
}

struct MatrixCharacter: Codable {
    let id: Int
    let alias: String
    let type: MatrixCharacterType
}



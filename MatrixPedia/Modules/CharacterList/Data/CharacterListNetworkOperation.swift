//
//  CharacterListNetworkOperation.swift
//  MatrixPedia
//
//  Created by Adrián Silva on 07/11/2018.
//  Copyright © 2018 Adrián Silva. All rights reserved.
//

import Foundation

final class CharactersListNetworkOperation: MatrixPediaOperation {

    var characters: [MatrixCharacter]? = nil
    var error: NSError? = nil

    var endPoint: String {
        return "/characters"
    }

    func finish(with data: Data?) {
        let decoder = JSONDecoder()
        guard let charactersData = data,
            let newCharacters = try? decoder.decode([MatrixCharacter].self, from: charactersData),
            newCharacters.count > 0 else {
            error = getError()
            return
        }

        self.characters = newCharacters
    }
}

extension CharactersListNetworkOperation {
    func getError() -> NSError {
        return NSError(domain: "CharacterListNetworkOperation",
                       code: 0,
                       userInfo: [NSLocalizedDescriptionKey: "Error parsing characters"])
    }
}

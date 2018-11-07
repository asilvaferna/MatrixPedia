//
//  CharacterListRepository.swift
//  MatrixPedia
//
//  Created by Adrián Silva on 07/11/2018.
//  Copyright © 2018 Adrián Silva. All rights reserved.
//

import Foundation

protocol CharactersRepository {
    func retrieveCharacters()
}

protocol CharactersRepositoryOutput: class {
    func charactersSuccess(_ characters: [MatrixCharacter])
    func charactersError(_ error: NSError?)
}

final class CharactersRepositoryImpl: CharactersRepository {
    var networkDataSource: CharactersNetworkDataSource
    weak var output: CharactersRepositoryOutput?

    init(networkDataSource: CharactersNetworkDataSource) {
        self.networkDataSource = networkDataSource
    }

    func retrieveCharacters() {
        networkDataSource.retrieveCharacters { [weak self] characters, error in
            guard error == nil, let characters = characters else {
                self?.output?.charactersError(error)
                return
            }
            self?.output?.charactersSuccess(characters)
        }
    }
}

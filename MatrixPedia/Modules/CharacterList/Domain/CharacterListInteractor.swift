//
//  CharacterListInteractor.swift
//  MatrixPedia
//
//  Created by Adrián Silva on 07/11/2018.
//  Copyright © 2018 Adrián Silva. All rights reserved.
//

import Foundation

protocol CharacterListInteractor {
    func loadCharacters()
}

protocol CharacterListInteractorOutput: class {
    func loadedCharacters(_ characters: [MatrixCharacter])
    func failedLoadingCharacters()
}

final class CharacterListInteractorImpl {
    weak var output: CharacterListInteractorOutput?
    var repository: CharactersRepository?
}

extension CharacterListInteractorImpl: CharacterListInteractor {
    func loadCharacters() {
        repository?.retrieveCharacters()
    }
}

extension CharacterListInteractorImpl: CharactersRepositoryOutput {
    func charactersSuccess(_ characters: [MatrixCharacter]) {
        output?.loadedCharacters(characters)
    }

    func charactersError(_ error: NSError?) {
        output?.failedLoadingCharacters()
    }
}

//
//  CharacterListPresenter.swift
//  MatrixPedia
//
//  Created by Adrián Silva on 07/11/2018.
//  Copyright © 2018 Adrián Silva. All rights reserved.
//

import Foundation

protocol CharacterListPresenter {
    func viewDidLoad()
    func userDidSelectCharacter(withId id: Int)
}

protocol CharacterListPresenterOutput: class {
    func loadCharacters(_ characters: [CharacterViewModel])
    func showError(message: String)
}

final class CharacterListPresenterImpl {
    var interactor: CharacterListInteractor?
    weak var view: CharacterListPresenterOutput?
    var router: CharacterListRouter?
}

extension CharacterListPresenterImpl: CharacterListPresenter {
    func viewDidLoad() {
        interactor?.loadCharacters()
    }

    func userDidSelectCharacter(withId id: Int) {
        router?.openCharacter(withId: id)
    }
}

extension CharacterListPresenterImpl: CharacterListInteractorOutput {
    func loadedCharacters(_ characters: [MatrixCharacter]) {
        let characterViewModel = characters.map { CharacterViewModel(id: $0.id, name: $0.alias, type: $0.type.rawValue) }
        view?.loadCharacters(characterViewModel)
    }

    func failedLoadingCharacters() {
        view?.showError(message: "Characters couldn't be loaded")
    }
}

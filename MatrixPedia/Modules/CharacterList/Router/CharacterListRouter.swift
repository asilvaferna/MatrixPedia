//
//  CharacterListRouter.swift
//  MatrixPedia
//
//  Created by Adrián Silva on 07/11/2018.
//  Copyright © 2018 Adrián Silva. All rights reserved.
//

import UIKit

protocol CharacterListRouter {
    func openCharacter(withId id: Int)
}

final class CharacterListRouterImpl {
    private var mainRouter: MainRouter

    init(mainRouter: MainRouter) {
        self.mainRouter = mainRouter
    }
}

extension CharacterListRouterImpl {
    static func create() -> UIViewController {
        let serviceLocator = UIApplication.serviceLocator
        let networkDataManager = serviceLocator.networkDataManager
        let interactor = CharacterListInteractorImpl()
        let networkDataSource = CharactersNetworkDataSourceImpl(networkDataManager: networkDataManager)
        let repository = CharactersRepositoryImpl(networkDataSource: networkDataSource)
        let presenter = CharacterListPresenterImpl()
        let view = CharacterListViewController()
        let mainRouter = serviceLocator.mainRouter
        let router = CharacterListRouterImpl(mainRouter: mainRouter)

        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        interactor.output = presenter
        interactor.repository = repository
        repository.output = interactor

        return view

    }
}

extension CharacterListRouterImpl: CharacterListRouter {
    func openCharacter(withId id: Int) {
        let profileController = CharacterProfileRouterImpl.create(characterId: id)
        mainRouter.present(controller: profileController)
    }
}



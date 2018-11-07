//
//  CharactersNetworkDataSource.swift
//  MatrixPedia
//
//  Created by Adrián Silva on 07/11/2018.
//  Copyright © 2018 Adrián Silva. All rights reserved.
//

import Foundation

typealias CharactersListCompletionHandler = (_ characters: [MatrixCharacter]?, _ error: NSError?) -> ()

protocol CharactersNetworkDataSource {
    func retrieveCharacters(_ completion: @escaping CharactersListCompletionHandler)
}

class CharactersNetworkDataSourceImpl: CharactersNetworkDataSource {
    private var networkDataManager: NetworkDataManager

    init(networkDataManager: NetworkDataManager) {
        self.networkDataManager = networkDataManager
    }

    func retrieveCharacters(_ completion: @escaping CharactersListCompletionHandler) {
        let operation = CharactersListNetworkOperation()
        networkDataManager.execute(operation) { _ in
            completion(operation.characters, operation.error)
        }
    }
}

//
//  ServiceLocator.swift
//  MatrixPedia
//
//  Created by Adrián Silva on 07/11/2018.
//  Copyright © 2018 Adrián Silva. All rights reserved.
//

import UIKit

final class ServiceLocator {
    lazy var networkDataManager: NetworkDataManager = {
        let manager = NetworkDataManagerImpl(uriRoot: "http://localhost")
        return manager
    }()

    lazy var mainRouter: MainRouterProtocols = { [unowned self] in
        let window = UIApplication.shared.keyWindow
        let mainRouter = MainRouterImpl(window: window)
        return mainRouter
    }()
}


//
//  MatrixNetworkOperation.swift
//  MatrixPedia
//
//  Created by Adrián Silva on 07/11/2018.
//  Copyright © 2018 Adrián Silva. All rights reserved.
//

import Foundation

protocol MatrixPediaOperation {
    var error: NSError? { get }
    var endPoint: String { get }
    func finish(with data: Data?)
}

extension MatrixPediaOperation {
    var error: NSError? {
        return nil
    }

    var endPoint: String {
        return ""
    }

}

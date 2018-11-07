//
//  NetworkDataManager.swift
//  MatrixPedia
//
//  Created by Adrián Silva on 07/11/2018.
//  Copyright © 2018 Adrián Silva. All rights reserved.
//

import Foundation
import Alamofire

typealias NetworkDataManagerCompletionHandler = (_ error: NSError?) -> ()

protocol NetworkDataManager {
    func execute(_ operation: MatrixPediaOperation, completion: @escaping NetworkDataManagerCompletionHandler)
}

class NetworkDataManagerImpl: NetworkDataManager {
    var uriRoot: String

    init(uriRoot: String) {
        self.uriRoot = uriRoot
    }

    func execute(_ operation: MatrixPediaOperation, completion: @escaping NetworkDataManagerCompletionHandler) {
        guard let url = URL(string: uriRoot + operation.endPoint) else {
            completion(getError(withType: .unknown, description: "Error creating url"))
            return
        }

        Alamofire.request(url, method: .get, parameters: nil).responseJSON { response in
            operation.finish(with: response.data)
            completion(nil)
        }
    }
}

extension NetworkDataManager {
    func getError(withType type: NetworkDataManagerErrorCode, description: String?) -> NSError {
        return NSError(domain: "NetworkDataManager",
                       code: type.rawValue,
                       userInfo: [NSLocalizedDescriptionKey: description ?? ""])
    }
}

enum NetworkDataManagerErrorCode: Int {
    case unknown = -1
    case operation
    case parsing
}

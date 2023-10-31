//
//  ServicesResource.swift
//  QRI App
//
//  Created by Mazhar on 16/08/2021.
//

import Foundation
class ServicesResource {
    func getServices(url:URL,completionHandler : @escaping(Result<ServicesModal, Error>)-> Void ) {
        HttpUtility.servicesManager.getApiData(requestUrl: url, resultType: ServicesModal.self) { [weak self](resp) in
            switch resp {
            case .success(let resp):
                print(resp)
                completionHandler(.success(resp!))
            case .failure(let error):
                completionHandler(.failure(error))
                print(error)
            }
        
        }
    }
    deinit {
    
    }
}

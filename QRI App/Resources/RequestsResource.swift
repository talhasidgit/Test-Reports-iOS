//
//  RequestsResource.swift
//  QRI App
//
//  Created by Mazhar on 06/08/2021.
//

import Foundation
class RequestsResource {
    func getRequests(url:URL,params: [String:Any],completionHandler : @escaping(Result<CustomerRequests, Error>)-> Void ) {
        
        HttpUtility.servicesManager.getApiData(requestUrl: url, resultType: CustomerRequests.self) { [self](resp) in
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

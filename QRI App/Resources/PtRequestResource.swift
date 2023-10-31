//
//  PtRequestResource.swift
//  QRI App
//
//  Created by Mazhar on 09/09/2021.
//

import Foundation
class PtRequestsResource {
    func getRequestsData(url:URL,params: [String:Any],completionHandler : @escaping(Result<PtRequest, Error>)-> Void ) {
        HttpUtility.servicesManager.getApiData(requestUrl: url, resultType: PtRequest.self) { [weak self](resp) in
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

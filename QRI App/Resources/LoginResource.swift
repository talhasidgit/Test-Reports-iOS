//
//  LoginResource.swift
//  QRI App
//
//  Created by Mazhar on 19/07/2021.
//

import Foundation
class LoginResource {
    func loginUser(url:URL,params: [String:Any],completionHandler : @escaping(Result<LoginUser, Error>)-> Void ) {
        HttpUtility.servicesManager.postApiData(requestUrl: url, params: params, resultType: LoginUser.self) { [self](resp) in
            switch resp {
            case .success(let resp):
                print(resp)
                completionHandler(.success(resp ?? LoginUser()))
            case .failure(let error):
                completionHandler(.failure(error))
                print(error)
            }
        
        }
    }
    deinit {
    
    }
}

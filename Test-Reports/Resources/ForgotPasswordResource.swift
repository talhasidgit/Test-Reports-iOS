//
//  ForgotPasswordResource.swift
//  QRI App
//
//  Created by Mazhar on 19/07/2021.
//

import Foundation
class ForgotPasswordResource {
    func forgotPassword(url:URL,params: [String:Any],completionHandler : @escaping(Result<ForgotPassword, Error>)-> Void ) {
        HttpUtility.servicesManager.postApiData(requestUrl: url, params: params, resultType: ForgotPassword.self) { [weak self](resp) in
            switch resp {
            case .success(let resp):
                print(resp)
                completionHandler(.success(resp ?? ForgotPassword()))
            case .failure(let error):
                completionHandler(.failure(error))
                print(error)
            }
        
        }
    }
    deinit {
    
    }
}

//
//  ResetPasswordResource.swift
//  QRI App
//
//  Created by Mazhar on 11/08/2021.
//

import Foundation
class ResetPasswordResource {
    func updatePassword(url:URL,params: [String:Any],completionHandler : @escaping(Result<ResetPassword, Error>)-> Void ) {
        HttpUtility.servicesManager.postApiData(requestUrl: url, params: params, resultType: ResetPassword.self) { [weak self](resp) in
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


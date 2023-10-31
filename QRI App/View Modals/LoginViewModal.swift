//
//  LoginViewModal.swift
//  QRI App
//
//  Created by Mazhar on 19/07/2021.
//

import Foundation
class LoginViewModal {
    func loginApi(params:[String:Any],completionHandler: @escaping (Result<LoginUser, Error>)-> Void)  {
        let loginResource = LoginResource()
        guard let url = URL(string:ApiEndpoints.loginUrl) else {
            // incorporate error
            return
        }
        loginResource.loginUser(url: url, params: params, completionHandler: {[weak self] (resp) in
            switch resp {
            case .success(let resp):
                print(resp)
                completionHandler(.success(resp))
            case .failure(let error):
                completionHandler(.failure(error))
                print(error)
            }
        })
    }
    deinit {
    
    }
}

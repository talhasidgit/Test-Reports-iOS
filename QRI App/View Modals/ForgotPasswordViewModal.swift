//
//  ForgotPasswordViewModal.swift
//  QRI App
//
//  Created by Mazhar on 19/07/2021.
//

import Foundation
class ForgotPasswordViewModal {
    func ForgotPasswordApi(params:[String:Any],completionHandler: @escaping (Result<ForgotPassword, Error>)-> Void)  {
        let forgotPasswordResource = ForgotPasswordResource()
        guard let url = URL(string:ApiEndpoints.forgotPasswordUrl) else {
            // incorporate error
            return
        }
        forgotPasswordResource.forgotPassword(url: url, params: params, completionHandler: { [weak self](resp) in
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

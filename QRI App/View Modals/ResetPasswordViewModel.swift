//
//  ResetPasswordViewModel.swift
//  QRI App
//
//  Created by Mazhar on 11/08/2021.
//

import Foundation
class ResetPasswordViewModel {
    func ResetPasswordApi(params:[String:Any],completionHandler: @escaping (Result<ResetPassword, Error>)-> Void)  {
        let resetPasswordResource = ResetPasswordResource()
        guard let url = URL(string:ApiEndpoints.resetPasswordUrl) else {
            // incorporate error
            return
        }
        resetPasswordResource.updatePassword(url: url, params: params, completionHandler: {[weak self] (resp) in
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

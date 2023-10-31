//
//  RequestsViewModal.swift
//  QRI App
//
//  Created by Mazhar on 06/08/2021.
//

import Foundation
class RequestsViewModal {
    func RequestsApi(params:[String:Any],completionHandler: @escaping (Result<CustomerRequests, Error>)-> Void)  {
        let requestResource = RequestsResource()
        let token = params["token"]
        let customerId = params["customer_id"]
        guard let url = URL(string:ApiEndpoints.RequestsUrl + "token=\(token!)&customer_id=\(customerId!)") else {
            // incorporate error
            return
        }
        requestResource.getRequests(url: url, params: params, completionHandler: { [weak self](resp) in
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

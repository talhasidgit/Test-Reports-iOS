//
//  ServicesViewModal.swift
//  QRI App
//
//  Created by Mazhar on 16/08/2021.
//

import Foundation
class ServicesViewModal {
    func ServicesApi(params:[String:Any],completionHandler: @escaping (Result<ServicesModal, Error>)-> Void)  {
        let requestResource = ServicesResource()
        let serviceSlug = params["service_slug"]
        guard let url = URL(string:ApiEndpoints.servicesUrl + "&service_slug=\(serviceSlug!)") else {
            // incorporate error
            return
        }
        requestResource.getServices(url: url, completionHandler: { [weak self](resp) in
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

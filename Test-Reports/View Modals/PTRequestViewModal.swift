//
//  PTRequestViewModal.swift
//  QRI App
//
//  Created by Ahmed on 09/03/2022.
//

import Foundation
class PTRequestViewModal {
    func ptRequestApi(params:[String:Any],completionHandler: @escaping (Result<PTCutomerReport, Error>)-> Void)  {
        let requestResource = PTReportResource()
        
        let token = params["token"]
        let request_id = params["request_id"]
        
        let url = URL(string:ApiEndpoints.downloadPTReport)
        requestResource.postResource(url: url!, params: params, completionHandler: { [weak self](resp) in
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


//                            + "token=\(token ?? "")&request_id=\(request_id ?? "")") else {
//                                return
//                            }

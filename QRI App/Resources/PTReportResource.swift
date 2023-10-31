//
//  PTReportResource.swift
//  QRI App
//
//  Created by Ahmed on 09/03/2022.
//

import Foundation
class PTReportResource {
    func postResource(url:URL,params: [String:Any],completionHandler : @escaping(Result<PTCutomerReport, Error>)-> Void ) {
        
        HttpUtility.servicesManager.postApiData(requestUrl: url, params: params, resultType: PTCutomerReport.self) { [weak self](resp) in
            switch resp {
            case .success(let resp):
                print(resp as Any)
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

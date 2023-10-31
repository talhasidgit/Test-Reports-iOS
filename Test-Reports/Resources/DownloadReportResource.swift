//
//  DownloadReportResource.swift
//  QRI App
//
//  Created by Ahmed on 24/11/2021.
//

import Foundation
class DownloadReportResource {
    func downloadReport(url:URL,params: [String:Any],completionHandler : @escaping(Result<DownloadReport, Error>)-> Void ) {
        HttpUtility.servicesManager.postApiData(requestUrl: url, params: params, resultType: DownloadReport.self) { [weak self](resp) in
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

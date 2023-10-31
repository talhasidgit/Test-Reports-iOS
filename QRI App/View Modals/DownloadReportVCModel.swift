//
//  DownloadReportVCModel.swift
//  QRI App
//
//  Created by Ahmed on 24/11/2021.
//

import Foundation
class DownloadReportVCModel {
    func downloadReportApi(params:[String:Any],completionHandler: @escaping (Result<DownloadReport, Error>)-> Void)  {
        let downloadReportResource = DownloadReportResource()
        guard let url = URL(string:ApiEndpoints.downloadReport) else {
            // incorporate error
            return
        }
        downloadReportResource.downloadReport(url: url, params: params, completionHandler: { [weak self](resp) in
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

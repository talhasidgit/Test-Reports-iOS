//
//  TestResource.swift
//  QRI App
//
//  Created by Mazhar on 09/08/2021.
//

import Foundation
class TestReportResource {
    func getTests(url:URL,params: [String:Any],completionHandler : @escaping(Result<TestModal, Error>)-> Void ) {
        HttpUtility.servicesManager.getApiData(requestUrl: url, resultType: TestModal.self) { [weak self](resp) in
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


//
//  TestViewModal.swift
//  QRI App
//
//  Created by Mazhar on 09/08/2021.
//

import Foundation
class TestReportViewModal {
    func ReportsApi(params:[String:Any],completionHandler: @escaping (Result<TestModal, Error>)-> Void)  {
        let testResource = TestReportResource()
        let token = params["token"]
        let customerId = params["customer_id"]
        let requestId = params["request_id"]
        let requestType = params["request_type"]
        guard let url = URL(string:ApiEndpoints.testsUrl + "token=\(token!)&customer_id=\(customerId!)&request_id=\(requestId!)&request_type=\(requestType!)") else {
            // incorporate error
            return
        }
        testResource.getTests(url: url, params: params, completionHandler: { [weak self](resp) in
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

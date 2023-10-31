//
//  UploadImageResource.swift
//  QRI App
//
//  Created by Mazhar on 30/08/2021.
//

import Foundation
class UploadImageResource {
    func uploadImage(url:String,params: [String:Any],data:Data,key:String,completionHandler : @escaping(Result<ImageModel, Error>)-> Void ) {
        HttpUtility.servicesManager.uploadImageApiData(requestUrl: url, params: params,imgData:data,imgkey:key, resultType: ImageModel.self) { [weak self](resp) in
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


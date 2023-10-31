//
//  UploadImageViewModel.swift
//  QRI App
//
//  Created by Mazhar on 30/08/2021.
//

import Foundation
class UploadImageViewModel {
    func uploadImageApi(params:[String:Any],imgData:Data,key:String,completionHandler: @escaping (Result<ImageModel, Error>)-> Void)  {
        let imageResource = UploadImageResource()
        imageResource.uploadImage(url: ApiEndpoints.uploadImage,params: params, data:imgData,key:key, completionHandler: {[weak self] (resp) in
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

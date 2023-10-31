//
//  HttpUtility.swift
//  QRI App
//
//  Created by Mazhar on 05/07/2021.
//
import Foundation
import Alamofire

struct HttpUtility {
    
    //MARK: - Variables
    
    static let servicesManager = HttpUtility()
    let encoding: ParameterEncoding = JSONEncoding.prettyPrinted
    
    //MARK: - Constructor
    
    private init() {}
    
    //MARK: - Get Api
    
    func getApiData<T:Decodable>(requestUrl: URL, resultType: T.Type, completionHandler:@escaping(Swift.Result<T?, Error>)-> Void) {
        
        let requestModel = Alamofire.request(requestUrl, method: .get, parameters: nil , encoding: encoding, headers: authHeader())
        requestModel.responseJSON { responseData in
            if let httpStatusCode = responseData.response?.statusCode {
                if httpStatusCode == 200 {
                    print("successfull")
                }
                else {
                    var message = ""
                    switch(httpStatusCode) {
                    case 400:
                        message = "Bad Request"
                    case 401:
                        defaults.set(nil, forKey: kUserToken)
                        Commons.transitionToLoginScreen()
                        Commons.showErrorMessage(msg: "Your session has been expired!")
                        return
                    case 404:
                        message = "Not Found"
                    case 408:
                        message = "Request Timeout"
                    case 429:
                        message = "Too Many Requests"
                    case 500:
                        message = "Server Error"
                    case 503:
                        message = "Service Unavailable"
                    default:
                        message = "Something went wrong!"
                        break
                    }
                    Commons.showErrorAlert(msg: message)
                }
            }
            
            switch(responseData.result) {
            case .success(let JSON):
                let decoder = JSONDecoder()
                do {
                    let jsonData = try JSONSerialization.data(withJSONObject: JSON)
                    let result = try decoder.decode(T.self, from: jsonData)
                    completionHandler(.success(result))
                    print(result)
                }
                catch let error {
                    debugPrint("error occured while decoding = \(error)")
                    completionHandler(.failure(error))
                }
                
            case .failure(let error):
                
                completionHandler(.failure(error))
            }
        }
        
        
    }
    
    //MARK: - Post Api
    
    func postApiData<T:Decodable>(requestUrl: URL, params: [String:Any], resultType: T.Type, completionHandler:@escaping(Swift.Result<T?,Error>)-> Void) {
        
        let requestModel = Alamofire.request(requestUrl, method: .post, parameters: params , encoding: encoding, headers: authHeader())
        requestModel.responseJSON { responseData in
            if let httpStatusCode = responseData.response?.statusCode {
                if httpStatusCode == 200 {
                    print("successfull")
                }
                else {
                    var message = ""
                    switch(httpStatusCode) {
                    case 400:
                        message = "Bad Request"
                    case 401:
                        defaults.set(nil, forKey: kUserToken)
                        Commons.transitionToLoginScreen()
                        Commons.showErrorMessage(msg: "Your session has been expired!")
                        return
                    case 404:
                        message = "Not Found"
                    case 408:
                        message = "Request Timeout"
                    case 429:
                        message = "Too Many Requests"
                    case 500:
                        message = "Server Error"
                    case 503:
                        message = "Service Unavailable"
                    default:
                        message = "Something went wrong!"
                        break
                    }
                    Commons.showErrorAlert(msg: message)
                }
            }
            switch(responseData.result) {
            case .success(let JSON):
                let decoder = JSONDecoder()
                do {
                    let jsonData = try JSONSerialization.data(withJSONObject: JSON)
                    let result = try decoder.decode(T.self, from: jsonData)
                    completionHandler(.success(result))
                    print(result)
                }
                catch let error {
                    debugPrint("error occured while decoding = \(error)")
                    completionHandler(.failure(error))
                }
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
        
    }
    //MARK: - Upload Request Api
    
    func uploadImageApiData<T:Decodable>(requestUrl: String, params: [String:Any],imgData:Data,imgkey:String, resultType: T.Type, completionHandler:@escaping(Swift.Result<T?,Error>)-> Void) {
        let URL = try! URLRequest(url: requestUrl, method: .post, headers: authHeader())
        
        Alamofire.upload(multipartFormData: { multipartFormData in
            multipartFormData.append(imgData, withName: imgkey,fileName: "profile_picture", mimeType: "image/jpg")
            for (key, value) in params {
                multipartFormData.append((value as AnyObject).data(using: String.Encoding.utf8.rawValue)!, withName: key)
            } //Optional for extra parameters
        },
        with: URL, encodingCompletion: { (result) in
            
            
            switch result {
            case .success(let upload, _, _):
                
                upload.uploadProgress(closure: { (progress) in
                    print("Upload Progress: \(progress.fractionCompleted)")
                })
                upload.response { res in
                    if let httpStatusCode = res.response?.statusCode {
                        if httpStatusCode == 200 {
                            print("successfull")
                        }
                        else {
                            var message = ""
                            switch(httpStatusCode) {
                            case 400:
                                message = "Bad Request"
                            case 401:
                                defaults.set(nil, forKey: kUserToken)
                                Commons.transitionToLoginScreen()
                                Commons.showErrorMessage(msg: "Your session has been expired!")
                                return
                            case 404:
                                message = "Not Found"
                            case 408:
                                message = "Request Timeout"
                            case 429:
                                message = "Too Many Requests"
                            case 500:
                                message = "Server Error"
                            case 503:
                                message = "Service Unavailable"
                            default:
                                message = "Something went wrong!"
                                break
                            }
                            Commons.showErrorAlert(msg: message)
                        }
                    }
                    print("statusCode: \(String(describing: res.response?.statusCode))")
                    
                }
                upload.responseJSON { response in
                    
                    let decoder = JSONDecoder()
                    do {
                        let jsonData = try JSONSerialization.data(withJSONObject: response.result.value!)
                        let result = try decoder.decode(T.self, from: jsonData)
                        completionHandler(.success(result))
                        print(result)
                    }
                    catch let error {
                        debugPrint("error occured while decoding = \(error)")
                        completionHandler(.failure(error))
                    }
                }
                
            case .failure(let encodingError):
                
                Commons.showErrorAlert(msg: "Something went wrong!")
                print(encodingError.localizedDescription)
            }
        }
        
        )
    }
    
    
    //MARK: - Header
    
    func authHeader() -> [String:String] {
        let deviceID = UIDevice.current.identifierForVendor?.uuidString ?? DefaultValue.string
        var headers = ["DeviceID":"iOS - \(deviceID)"]
        headers["Content-Type"] = "application/json"
        headers["Accept"] = "application/json"
        if let token = defaults.object(forKey: kUserToken) {
            headers["Authorization"] = "Bearer \(token)"
        }
        return headers
    }
}

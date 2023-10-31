//
//  APiEndpoints.swift
//  QRI App
//
//  Created by Mazhar on 05/07/2021.
//

import Foundation
struct ApiEndpoints
{
    static let baseUrl = "http://developers.exdnow.com:8080/qri-live/api/v1/"
    //"https://qri.com.pk/api/v1/"
    static let baseUrlFile = "http://developers.exdnow.com:8080/qri-live/api/v1/public/files/"
    static let loginUrl = baseUrl + "user/login"
    static let forgotPasswordUrl = baseUrl + "forget_password"
    static let RequestsUrl = baseUrl + "get_request?"
    static let testsUrl = baseUrl + "get_test?"
    static let resetPasswordUrl = baseUrl + "reset_password?"
    static let servicesUrl = baseUrl + "get_service?"
    static let uploadImage = baseUrl + "upload_image"
    static let downloadReport = baseUrl + "download-report"
    static let downloadPTReport = baseUrl + "download-pt-report/"
   
}

//"http://developers.exdnow.com:8080/qri-live/api/v1/"

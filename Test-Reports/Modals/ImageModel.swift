//
//  ImageModel.swift
//  QRI App
//
//  Created by Mazhar on 30/08/2021.
//

import Foundation
struct ImageModel: Decodable {
    var status : Bool?
    var message : String?
    var error : ImageError?
    var data : ImageData?
    enum CodingKeys: String, CodingKey {
        case status = "status"
        case message = "message"
        case error = "error"
        case data = "data"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        error = try values.decodeIfPresent(ImageError.self, forKey: .error)
        data = try values.decodeIfPresent(ImageData.self, forKey: .data)
    }
}
struct ImageData: Decodable {
    
    var profileImage : String?
    enum CodingKeys: String, CodingKey {
        case profileImage = "profile_image"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        profileImage = try values.decodeIfPresent(String.self, forKey: .profileImage)
    }
}
struct ImageError: Decodable {
    
    var profileImage : String?
    enum CodingKeys: String, CodingKey {
        case profileImage = "profile_image"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        profileImage = try values.decodeIfPresent(String.self, forKey: .profileImage)
    }
}

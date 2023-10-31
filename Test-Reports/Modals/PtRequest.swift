//
//  PtRequest.swift
//  QRI App
//
//  Created by Mazhar on 09/09/2021.
//

import Foundation
class PtRequest : Codable{
    
    var data : [PtRequestData]?
    var status : Bool?
    var error : String?
    
    enum CodingKeys: String, CodingKey {
        
        case data = "data"
        case status = "status"
        case error = "error"
    }
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        data = try values.decodeIfPresent([PtRequestData].self, forKey: .data)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
        error = try values.decodeIfPresent(String.self, forKey: .error)
    }
}
class PtRequestData : Codable{
    
    var id : Int?
    var planName : String?
    var requestType : String?
    var round : String?
    enum CodingKeys: String, CodingKey {
        
        case id = "id"
        case planName = "plan_name"
        case requestType = "request_type"
        case round = "round"
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        planName = try values.decodeIfPresent(String.self, forKey: .planName)
        requestType = try values.decodeIfPresent(String.self, forKey: .requestType)
        round = try values.decodeIfPresent(String.self, forKey: .round)
    }
}

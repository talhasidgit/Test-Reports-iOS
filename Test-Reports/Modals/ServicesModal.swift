//
//  ServicesModal.swift
//  QRI App
//
//  Created by Mazhar on 16/08/2021.
//

import Foundation
struct ServicesModal:Codable {

    var servicesdata : ServicesData?
    var status : Bool?
    var error : String?
    enum CodingKeys: String, CodingKey {
        
        case servicesdata = "data"
        case status = "status"
        case error = "error"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        servicesdata = try values.decodeIfPresent(ServicesData.self, forKey: .servicesdata)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
        error = try values.decodeIfPresent(String.self, forKey: .error)
    }


}
struct  ServicesData:Codable{
    
    var labs : [Lab]?
    var service : Service?
    enum CodingKeys: String, CodingKey {
        
        case labs = "labs"
        case service = "service"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        labs = try values.decodeIfPresent([Lab].self, forKey: .labs)
        service = try values.decodeIfPresent(Service.self, forKey: .service)
    }


}

struct Service:Codable{

    var createdAt : String?
    var createdBy : Int?
    var deletedAt : String?
    var descriptionField : String?
    var detailImage : String?
    var frontImage : String?
    var id : Int?
    var name : String?
    var slug : String?
    var status : Int?
    var summary : String?
    var updatedAt : String?
    var updatedBy : Int?
    enum CodingKeys: String, CodingKey {
        
        case createdAt = "created_at"
        case createdBy = "created_by"
        case deletedAt = "deleted_at"
        case descriptionField = "description"
        case detailImage = "detail_image"
        case frontImage = "front_image"
        case id = "id"
        case name = "name"
        case slug = "slug"
        case status = "status"
        case summary = "summary"
        case updatedAt = "updated_at"
        case updatedBy = "updated_by"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        createdAt = try values.decodeIfPresent(String.self, forKey: .createdAt)
        createdBy = try values.decodeIfPresent(Int.self, forKey: .createdBy)
        deletedAt = try values.decodeIfPresent(String.self, forKey: .deletedAt)
        descriptionField = try values.decodeIfPresent(String.self, forKey: .descriptionField)
        detailImage = try values.decodeIfPresent(String.self, forKey: .detailImage)
        frontImage = try values.decodeIfPresent(String.self, forKey: .frontImage)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        slug = try values.decodeIfPresent(String.self, forKey: .slug)
        status = try values.decodeIfPresent(Int.self, forKey: .status)
        summary = try values.decodeIfPresent(String.self, forKey: .summary)
        updatedAt = try values.decodeIfPresent(String.self, forKey: .updatedAt)
        createdBy = try values.decodeIfPresent(Int.self, forKey: .updatedBy)
    }


}
struct Lab:Codable{

    var createdAt : String?
    var createdBy : Int?
    var deletedAt : String!
    var descriptionField : String?
    var detailImage : String?
    var frontImage : String?
    var id : Int?
    var name : String?
    var serviceId : Int?
    var slug : String?
    var status : Int?
    var summary : String?
    var updatedAt : String?
    var updatedBy : Int?
    enum CodingKeys: String, CodingKey {
        
        case createdAt = "created_at"
        case createdBy = "created_by"
        case deletedAt = "deleted_at"
        case descriptionField = "description"
        case detailImage = "detail_image"
        case frontImage = "front_image"
        case id = "id"
        case name = "name"
        case slug = "slug"
        case status = "status"
        case summary = "summary"
        case updatedAt = "updated_at"
        case updatedBy = "updated_by"
    }
    


}

//
//  CustomerRequests.swift
//  QRI App
//
//  Created by Mazhar on 06/08/2021.
//

import Foundation
struct CustomerRequests:Codable{

    var requestdata : RequestData?
    var status : Bool?
    var error : String?
    enum CodingKeys: String, CodingKey {

        case requestdata = "data"
        case status = "status"
        case error = "error"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        requestdata = try values.decodeIfPresent(RequestData.self, forKey: .requestdata)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
        error = try values.decodeIfPresent(String.self, forKey: .error)
    }


}
struct RequestData : Codable {
    var testingRequests : [MyRequests]?
    var ptRequests : [MyRequests]?
}
struct MyRequests : Codable {

//    var approvalRemarks : String?
//    var approvedBy : Int?
    var createdAt : String?
//    var createdBy : String?
    var customerId : Int?
//    var deletedAt : String?
   var id : Int?
//    var isApproved : Int?
//    var remarks : String?
    var requestNumber : String?
    var status : Int?
//    var updatedAt : String?
//    var updatedBy : String?
    var requestType : String?
    var files : [File]?
    enum CodingKeys: String, CodingKey {

//        case approvalRemarks = "approval_remarks"
//        case approvedBy = "approved_by"
        case createdAt = "created_at"
       // case createdBy = "created_by"
        case customerId = "customer_id"
       // case deletedAt = "deleted_at"
        case id = "id"
//        case isApproved = "is_approved"
//        case remarks = "remarks"
        case requestNumber = "request_number"
        case status = "status"
//        case updatedAt = "updated_at"
//        case updatedBy = "updated_by"
        case requestType = "request_type"
        case files = "files"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        //approvalRemarks = try values.decodeIfPresent(String.self, forKey: .approvalRemarks)
        //approvedBy = try values.decodeIfPresent(Int.self, forKey: .approvedBy)
        createdAt = try values.decodeIfPresent(String.self, forKey: .createdAt)
        //createdBy = try values.decodeIfPresent(String.self, forKey: .createdBy)
        customerId = try values.decodeIfPresent(Int.self, forKey: .customerId)
        //deletedAt = try values.decodeIfPresent(String.self, forKey: .deletedAt)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
      //  isApproved = try values.decodeIfPresent(Int.self, forKey: .isApproved)
    //    remarks = try values.decodeIfPresent(String.self, forKey: .remarks)
        requestNumber = try values.decodeIfPresent(String.self, forKey: .requestNumber)
        status = try values.decodeIfPresent(Int.self, forKey: .status)
       // updatedAt = try values.decodeIfPresent(String.self, forKey: .updatedAt)
        //updatedBy = try values.decodeIfPresent(String.self, forKey: .updatedBy)
        requestType = try values.decodeIfPresent(String.self, forKey: .requestType)
        files = try values.decodeIfPresent([File].self, forKey: .files)
    }
}
struct File: Codable {
    var id : Int?
    var requestId : Int?
    var fileName : String?
    var file : String?
    var path : String?
    var deletedAt : String?
    var status : Int?
    var updatedAt : String?
    var updatedBy : String?
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case requestId = "request_id"
        case fileName = "file_name"
        case file = "file"
        case path = "path"
        case deletedAt = "deleted_at"
        case status = "status"
        case updatedAt = "updated_at"
        case updatedBy = "updated_by"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        requestId = try values.decodeIfPresent(Int.self, forKey: .requestId)
        fileName = try values.decodeIfPresent(String.self, forKey: .fileName)
        file = try values.decodeIfPresent(String.self, forKey: .file)
        path = try values.decodeIfPresent(String.self, forKey: .path)
        deletedAt = try values.decodeIfPresent(String.self, forKey: .deletedAt)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        status = try values.decodeIfPresent(Int.self, forKey: .status)
        updatedAt = try values.decodeIfPresent(String.self, forKey: .updatedAt)
        updatedBy = try values.decodeIfPresent(String.self, forKey: .updatedBy)
    }
}

struct PTCutomerReport:Codable{

    
    var status : Bool?
    var error : String?
    var link:String?
    
    enum CodingKeys: String, CodingKey {

    
        case status = "status"
        case error = "error"
        case link = "link"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
      
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
        error = try values.decodeIfPresent(String.self, forKey: .error)
        link = try values.decodeIfPresent(String.self, forKey: .link)
        
    }


}

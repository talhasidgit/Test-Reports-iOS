//
//  TestModal.swift
//  QRI App
//
//  Created by Mazhar on 09/08/2021.
//

import Foundation
struct TestModal:Codable {
    var testReports : [TestReport]?
    var status : Bool?
    var error : String?
    enum CodingKeys: String, CodingKey {
        
        case testReports = "data"
        case status = "status"
        case error = "error"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        testReports = try values.decodeIfPresent([TestReport].self, forKey: .testReports)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
        error = try values.decodeIfPresent(String.self, forKey: .error)
    }
}
struct TestReport : Codable{
    var download : Int?
    var file : String?
    var id : Int?
    var requestId : Int?
    var serviceSlug : String?
    var testId : Int?
    var testName : String?
    var labName : String?
    var sectionName : String?
    var metricsName : String?
    var report_status : Int?
    enum CodingKeys: String, CodingKey {
        
        case download = "download"
        case id = "id"
        case requestId = "request_id"
        case file = "file"
        case serviceSlug = "service_slug"
        case testId = "test_id"
        case testName = "test_name"
        case labName = "lab_name"
        case sectionName = "section_name"
        case metricsName = "metrics_name"
        case report_status = "status"
        
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        download = try values.decodeIfPresent(Int.self, forKey: .download)
        file = try values.decodeIfPresent(String.self, forKey: .file)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        requestId = try values.decodeIfPresent(Int.self, forKey: .requestId)
        serviceSlug = try values.decodeIfPresent(String.self, forKey: .serviceSlug)
        testId = try values.decodeIfPresent(Int.self, forKey: .testId)
        testName = try values.decodeIfPresent(String.self, forKey: .testName)
        labName = try values.decodeIfPresent(String.self, forKey: .labName)
        sectionName = try values.decodeIfPresent(String.self, forKey: .sectionName)
        metricsName = try values.decodeIfPresent(String.self, forKey: .metricsName)
        report_status = try values.decodeIfPresent(Int.self, forKey:.report_status)
        
    }
}

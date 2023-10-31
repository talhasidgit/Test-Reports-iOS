//
//  DownloadReport.swift
//  QRI App
//
//  Created by Ahmed on 24/11/2021.
//

import Foundation
struct DownloadReport: Codable {
    
    var link : String?
    var status : Bool?
    var error : String?

enum CodingKeys: String, CodingKey {
    
    case link = "link"
    case status = "status"
    case error = "error"
}

init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)
    link = try values.decodeIfPresent(String.self, forKey: .link)
    status = try values.decodeIfPresent(Bool.self, forKey: .status)
    error = try values.decodeIfPresent(String.self, forKey: .error)
}

}

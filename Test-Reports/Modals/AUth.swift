//
//  LoginUser.swift
//  QRI App
//
//  Created by Mazhar on 19/07/2021.
//

import Foundation
struct LoginUser: Decodable {
    
    var data : myData?
    var status : Bool?
    var error : String?
}
struct myData: Decodable {
    
    var customer : Customer?
    var userData : UserData?
    
}
struct UserData :Decodable{
    public static let userSharedInstance = UserData()
    
    var auth_token : String?
    var cell : String?
    var email : String?
    var id : Int?
    var name : String?
    var profile_image : String?
    // save and fetch user data
    func storeUserInfo(token:String,customerId:Int,userId: Int,email:String,name:String,profileImage:String) {
        
        defaults.set(token, forKey: kUserToken)
        defaults.set(customerId, forKey: kCustomerId)
        defaults.set(userId, forKey: kUserId)
        defaults.set(email, forKey: kEmail)
        defaults.set(name, forKey: kUserName)
        defaults.set(profileImage, forKey: kUserProfile)
        syncronizeDefaults()
        
    }
    
    func deleteUserToken(token:String) {
        
        defaults.set(nil, forKey: kUserToken)
        syncronizeDefaults()
        
    }
    mutating func fetchUserToken() {
        
        if let str = defaults.object(forKey: kUserToken) as? String {
            
            auth_token = str
        }
    }
    
}
struct Customer: Decodable {
    
    var city : String?
    var company : String?
    var createdAt : String?
    var createdBy : Int?
    var customerNumber : String?
    var deletedAt : String?
    var id : Int?
    var status : Int?
    var updatedAt : String?
    var updatedBy : String?
    var userId : Int?
    
}
struct ForgotPassword: Decodable{
    var message : String?
}

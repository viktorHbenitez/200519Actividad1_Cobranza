//
//  APIService.swift
//  200519CreateStoryboardNETEC
//
//  Created by Victor Hugo Benitez Bosques on 22/05/19.
//  Copyright © 2019 Victor Hugo Benitez Bosques. All rights reserved.
//

import UIKit
class APIService {
    
    let baseiTunesSearchURL = URL(string: "http://www.develogeeks.com/netec/capitulo4/consumoApi/Empleados/getList.php")!
    
    // Singleton
    static let shareInstance = APIService()
    
    func fetchEmployee(completionHandler:@escaping ([Employee]?) -> ()) {
        
        let request = URLRequest(url: baseiTunesSearchURL)
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data else {
                return completionHandler(nil)
            }
            do{
                let result =  try JSONDecoder().decode(resultWS.self, from: data)
                
                return completionHandler(result.data)
            }catch let error{
                print(error)
                return completionHandler(nil)
            }
            }.resume()
    }
    
    
}

struct Employee: Codable {
    var idEmployee: Int?
    var fullName: String?
    var email: String?
    var photo: String?
    var address: String?
    var company: String?
    var area: String?
    var seniority: String?
    var dateInPayroll: String?
    var birthday: String?
    var age: String?
    var maritalStatus: String?
    var role: String?
    var productsPurchased: String?
    
    lazy var date: Date? = {
        guard let birthdaySring = birthday,
              let birthday = Double(birthdaySring) else {return nil}
        return Date(timeIntervalSince1970: birthday)
    }()
   

}

struct resultWS: Decodable{
    var data = [Employee]()
}





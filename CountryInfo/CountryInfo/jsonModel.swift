//
//  jsonModel.swift
//  CountryInfo
//
//  Created by macOS Mojave on 1/4/19.
//  Copyright © 2019 macOS Mojave. All rights reserved.
//

import Foundation

struct Info: Decodable {
    let name: String
    let alpha2Code : String
    let callingCodes : [String]
    let capital : String
    let region : String
    let subregion : String
    let population : Int
    let latlng : [Double]
    let area : Double?
    let timezones : [String]
    let borders : [String]
    let currencies : [countrie]
    let languages : [language]
}

struct countrie : Decodable{
    let code : String?
    let name : String?
    let symbol : String?
}
struct language : Decodable{
    let name : String
}
//struct name : Decodable {
//    let name : String
//}

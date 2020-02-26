//
//  Model.swift
//  Alamofire(simple App)
//
//  Created by Sergey Golenko on 26.02.2020.
//  Copyright © 2020 Sergey Golenko. All rights reserved.
//

import Foundation

struct Item:Codable{
    let albumID:Int
    let id:Int
    let title:String
    let url:String
}

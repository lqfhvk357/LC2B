
//
//  dataSource.swift
//  LCTodayNews
//
//  Created by 罗超 on 2018/9/21.
//  Copyright © 2018年 罗超. All rights reserved.
//
// test 0.1.2

import Moya
import Result
import SwiftyJSON

public protocol ResponseToModel {
    static func swiftyJSONFrom(response: Response) -> JSON
    static func modelform(response: Response) -> Self?
    static func modelform(data: Data) -> Self?
    static func modelform(content: String) -> Self?
}

extension ResponseToModel where Self: Decodable{
    public static func swiftyJSONFrom(response: Response) -> JSON {
        let json = JSON(response.data)
        return json
    }
    
    public static func modelform(response: Response) -> Self? {
        let dcit = swiftyJSONFrom(response: response)
        if let json = try? dcit.rawData(){
            if let model = modelform(data: json){
                return model;
            }
        }
        return nil
    }
    
    public static func modelform(data: Data) -> Self?{
        do {
            let model = try JSONDecoder().decode(Self.self, from: data)
            return model
        }catch{
            print(error)
            return nil
        }
    }
    
    public static func modelform(content: String) -> Self?{
        do {
            let contentModel = try JSONDecoder().decode(Self.self, from: content.data(using: .utf8)!)
            return contentModel
        }catch{
            print(error)
            return nil
        }
    }
}

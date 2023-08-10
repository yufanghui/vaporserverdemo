//
//  File.swift
//  
//
//  Created by 58 on 2023/8/10.
//

import Foundation
import Vapor
struct TangShi:Codable,ResponseEncodable,Content{
    func encodeResponse(for request: Vapor.Request) -> NIOCore.EventLoopFuture<Vapor.Response> {
        let response = Response()
               
               do {
                   // Assuming you want to send the data as JSON
                   let jsonData = try JSONEncoder().encode(self)
                   response.body = .init(data: jsonData)
                   response.headers.replaceOrAdd(name: .contentType, value: "application/json")
                   return request.eventLoop.makeSucceededFuture(response)
               } catch {
                   return request.eventLoop.makeFailedFuture(error)
               }
    }
    
    var author: String
    var paragraphs: [String]  // 更改此行
    var tags:[String]
    var title:String
    var id:String
}


struct Greeting: Content {
    var name: String
}

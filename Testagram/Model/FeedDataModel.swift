//
//  FeedDataModel.swift
//  Testagram
//
//  Created by Ramazan Rustamov on 07.01.23.
//

import Foundation

struct FeedDataModel {
    let userName: String?
    let userImageUrl: String?
    let feedImageUrl: String?
    let imageSize: Int?
    let imageType: String?
    let imageTag: String?
    let views: Int?
    let likes: Int?
    let comments: Int?
    let downloads: Int?
    
    init(data: [String: Any]) {
        userName = data["user"] as? String
        userImageUrl = data["userImageURL"] as? String
        feedImageUrl = data["previewURL"] as? String
        imageSize = data["imageSize"] as? Int
        imageType = data["type"] as? String
        imageTag = data["tags"] as? String
        views = data["views"] as? Int
        likes = data["likes"] as? Int
        comments = data["comments"] as? Int
        downloads = data["downloads"] as? Int
        
    }
}

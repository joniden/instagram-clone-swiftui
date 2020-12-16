//
//  DataPost.swift
//  Multiplatform (iOS)
//
//  Created by Joacim Nidén on 2020-12-16.
//

import Foundation

struct DataPost: Codable {
    let id: String
    let username: String
    let image: String
    let description: String
    var hasLiked: Bool?
    var bookmarked: Bool?
    var likes: Int?
}

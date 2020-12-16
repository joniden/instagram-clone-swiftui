//
//  Post.swift
//  Multiplatform
//
//  Created by Joacim Nidén on 2020-12-14.
//

import Foundation

struct Post: Hashable, Identifiable {
	static func == (lhs: Post, rhs: Post) -> Bool {
		return lhs.id == rhs.id
	}
	
	let id: String
	let username: String
	let image: ImageLocation
    let description: NSAttributedString
    var isLiked = false
	var likes: Int = 0
	var bookmarked = false
}

enum ImageLocation: Hashable {
	case local(name: String), remote(url: URL?)
}

extension Post {
	init(dataPost: DataPost) {
		self.id = dataPost.id
		self.username = dataPost.username
		self.image = .remote(url: URL(string: dataPost.image))
		self.description = NSAttributedString(string: dataPost.description)
		self.isLiked = dataPost.hasLiked ?? false
		self.likes = dataPost.likes ?? 0
		self.bookmarked = dataPost.bookmarked ?? false
	}
}

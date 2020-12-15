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
	
	var id: String
	var username: String
	var image: ImageLocation
}

enum ImageLocation: Hashable {
	case local(name: String), remote(url: URL?)
}

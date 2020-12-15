//
//  Comment.swift
//  Multiplatform
//
//  Created by Joacim Nidén on 2020-12-15.
//

import Foundation

struct Comment: Hashable {
	let image: URL?
	let name: String
	let date: Date
	let likes: Int
	let text: String
	var subcomments: [SubComment]?
}

struct SubComment: Hashable {
	let image: URL?
	let name: String
	let date: Date
	let likes: Int
	let text: String
}

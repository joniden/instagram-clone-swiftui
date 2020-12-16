//
//  ContentViewModel.swift
//  Multiplatform
//
//  Created by Joacim Nidén on 2020-12-14.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject {
	
	@Published var posts: [Post] = []
	
	let service = APIService()
	
	func fetch() {
		service.getPosts().map { p in
			p.map { Post(dataPost: $0) }
		}
		.receive(on: DispatchQueue.main)
		.eraseToAnyPublisher()
		.assign(to: &$posts)
	}
	
	func setPost(_ post: Post) {
		guard let pos = posts.firstIndex(of: post) else {
			return
		}
		
		posts[pos] = post
	}
}

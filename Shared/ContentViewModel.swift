//
//  ContentViewModel.swift
//  Multiplatform
//
//  Created by Joacim Nidén on 2020-12-14.
//

import Foundation
import Combine

class ContentViewModel: ObservableObject {
	
	@Published var posts: [Post] = []
	
	func fetch() {
		let urls = ["https://placekitten.com/200/300",
					"https://placekitten.com/200/301",
					"https://placekitten.com/200/302"]
		
		posts = urls.map { url in
			return Post(id: UUID().uuidString, username: "Jocke", image: .remote(url: URL(string: url)))
		}

		
		
	}
}

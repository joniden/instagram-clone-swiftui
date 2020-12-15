//
//  PostViewModel.swift
//  Multiplatform
//
//  Created by Joacim Nidén on 2020-12-15.
//

import Foundation
import Combine

class PostViewModel: ObservableObject {
	
	@Published var comments: [Comment] = []
	
	func getComments() {
		
		let array = ["arr", "dffds", "fdgfdg", "fgfg", "tack", "hej hej", "fin katt"]
		
		comments = array.map { string in
			
			return Comment(image: nil,
						   name: "Jocke",
						   date: randomDate,
						   likes: 0,
						   text: string,
						   subcomments: nil)
		}
		
	}
	
	private var randomDate: Date {
		var components = DateComponents()
		components.year = 2020
		components.month = Int.random(in: 0...11)
		components.day = Int.random(in: 0...28)
		return Calendar.current.date(from: components)!
	}
	
}

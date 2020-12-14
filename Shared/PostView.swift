//
//  PostView.swift
//  Multiplatform
//
//  Created by Joacim Nidén on 2020-12-14.
//

import SwiftUI
import KingfisherSwiftUI

struct PostView: View {
	
	private let post: Post
	
	init(_ post: Post) {
		self.post = post
	}
	
    var body: some View {
		
		VStack {
			PostViewRow(post)
		}
       
    }
}

struct PostView_Previews: PreviewProvider {
    static var previews: some View {
		
		let url = URL(string: "https://placekitten.com/200/454")
		let post = Post(id: "", username: "Alexander", image: .remote(url: url))
		
		PostView(post)
    }
}

//
//  PostViewRow.swift
//  Multiplatform
//
//  Created by Joacim Nidén on 2020-12-14.
//

import SwiftUI
import KingfisherSwiftUI

struct PostViewRow: View {
		
	let post: Post
	
	@State var likes: Int = 0
	@State var isLiked = false
	@State var animate = false
	@State var size: CGFloat = 1
	@State var opacity: Double = 0
	
	init(_ post: Post) {
		self.post = post
	}
	
    var body: some View {

		VStack(alignment: .leading) {
			Text(post.username).padding(.leading, 20)
			
			ZStack {
				
				ImageView(location: post.image)
					.frame(maxHeight: 500)
					.clipped()
					.onTapGesture(count: 2) {
						isLiked = true
						handleLike()
					}
				
				Image(systemName: Icon.heart.fill(true))
					.resizable()
					.frame(width: 20, height: 20)
					.foregroundColor(.white)
					.scaleEffect(size)
					.opacity(opacity)
					.shadow(radius: 5)
					.animation(
						Animation.spring(),
						value: animate
					)

			}
			
			HStack {
				
				Image(systemName: Icon.heart.fill(isLiked))
					.resizable()
					.frame(width: 20, height: 20)
					.onTapGesture {
						isLiked.toggle()
						handleLike()
						
					}
				
				Text("number of likes: \(likes)")
			
			}.padding(.leading, 20)
				
		}
    }
	
	func handleLike() {
		likes = isLiked ? 1 : 0
		
		guard isLiked else {
			return
		}
		
		size = 3
		opacity = 1
		animate = true
		DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
			
			opacity = 0
			size = 1
			animate.toggle()
		}
	}
}

struct PostViewRow_Previews: PreviewProvider {
    static var previews: some View {
		
		//let url = URL(string: "https://placekitten.com/200/454")
		let post = Post(id: "", username: "Alexander", image: .local(name: "cat"))
		
		PostViewRow(post)
    }
}

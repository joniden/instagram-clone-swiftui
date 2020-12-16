//
//  PostRowView.swift
//  Multiplatform
//
//  Created by Joacim Nidén on 2020-12-14.
//

import SwiftUI
import KingfisherSwiftUI

struct PostRowView: View {
		
	var post: Post
	
	@State var likes: Int = 0
	@State var isLiked: Bool = false
	@State var animate = false
	@State var size: CGFloat = 1
	@State var opacity: Double = 0
	let updateCallback: (Post) -> Void
	
	init(_ post: Post, updateCallback: @escaping (Post) -> Void) {
		self.post = post
		self.updateCallback = updateCallback		
	}
	
    var body: some View {

		VStack(alignment: .leading) {
			Text(post.username).padding(.leading)
			
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

                HStack {
                    
                    Image(systemName: Icon.heart.fill(isLiked))
                        .resizable()
                        .frame(width: 22, height: 20)
                        .onTapGesture {
                            isLiked.toggle()
                            handleLike()
                            
                        }
                    
					NavigationLink(destination: PostDetailView(postRow: {self})) {
						Image(systemName: Icon.bubble.rawValue)
							.resizable()
							.frame(width: 20, height: 20)
					}
                    
                    Image(systemName: Icon.paperplane.rawValue)
                        .resizable()
                        .frame(width: 20, height: 20)
                        .onTapGesture {
            
                        }
                }
                
                Spacer()
                
                Image(systemName: Icon.bookmark.rawValue)
                    .resizable()
                    .frame(width: 16, height: 20)
                    .onTapGesture {
                        
                    }.padding(.trailing)
            
            }.padding(.leading)
            
            Text("\(likes) likes").bold().padding(.leading)
            
            Text(post.description.string).padding(.leading)
            
				
		}
    }

    func handleLike() {
        likes = isLiked ? 1 : 0
		
		var newPost = post
		newPost.isLiked = isLiked
		
		guard isLiked else {
			return
		}

		updateCallback(newPost)
		
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

struct PostRowView_Previews: PreviewProvider {
    static var previews: some View {
		
		//let url = URL(string: "https://placekitten.com/200/454")
        let post = Post(id: "", username: "Alexander", image: .local(name: "cat"), description: NSAttributedString(string: "The finest cat of them all! Don't you think?! ¡!?¿"),isLiked: false)
		
		PostRowView(post, updateCallback: {_ in })
    }
}

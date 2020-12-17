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
    @State var showCommentBtn = true

	var actionLike: ((Post) -> Void)?
	var actionTapCommentBtn: ((Post) -> Void)?
	
	init(_ post: Post) {
		self.post = post
	}
	
    var body: some View {

		VStack(alignment: .leading) {
            HStack {
                Text(post.username).padding(.leading, 20)
                
                Spacer()
                
                Image(systemName: Icon.bookmark.rawValue)
                    .resizable()
                    .frame(width: 30, height: 36)
                    .padding(4)
                    .padding(.trailing)
                    .onTapGesture {
                        actionTapCommentBtn?(post)
                    }
            }
            
			ZStack {
				
				ImageView(location: post.image)
					.frame(maxHeight: post.focus ? 500 : 300)
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
                        .frame(width: 36, height: 36)
                        .padding(4)
                        .onTapGesture {
                            isLiked.toggle()
                            handleLike()
                            
                        }
                    
						Image(systemName: Icon.bubble.rawValue)
							.resizable()
							.frame(width: 36, height: 36)
							.padding(4)
							.opacity(showCommentBtn ? 1 : 0)
							.onTapGesture {
								withAnimation {
									showCommentBtn.toggle()
								}
								actionTapCommentBtn?(post)
							}

                }.padding(.top, 4)
                
                Spacer()
                
                Image(systemName: Icon.paperplane.rawValue)
                    .resizable()
                    .frame(width: 36, height: 36)
                    .padding(4)
                    .padding(.trailing)
                    .onTapGesture {
        
                    }
   
            }.padding(.leading)
            
            Text("\(likes) likes").bold().padding(.leading, 20)
            
            Text(post.description.string).padding(.leading, 20)
		}
    }

    private func handleLike() {
        likes = isLiked ? 1 : 0
		
		var newPost = post
		newPost.isLiked = isLiked
		
		guard isLiked else {
			return
		}

		actionLike?(newPost)
		
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

extension PostRowView {
	func onLike(perform action: @escaping (Post) -> Void ) -> Self {
		var copy = self
		copy.actionLike = action
		return copy
	}
	
	func onTapCommentBtn(perform action: @escaping (Post) -> Void ) -> Self {
		var copy = self
		copy.actionTapCommentBtn = action
		return copy
	}
}

struct PostRowView_Previews: PreviewProvider {
    static var previews: some View {
		
		//let url = URL(string: "https://placekitten.com/200/454")
        let post = Post(id: "", username: "Alexander", image: .local(name: "cat"), description: NSAttributedString(string: "The finest cat of them all! Don't you think?! ¡!?¿"),isLiked: false)
		
		PostRowView(post)
    }
}

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
    
    let updateCallback: (Post) -> Void
    init(_ post: Post, updateCallback: @escaping (Post) -> Void) {
		self.post = post
		self.updateCallback = updateCallback		
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
                        
                    }
            }
            
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
                        .frame(width: 36, height: 36)
                        .padding(4)
                        .onTapGesture {
                            isLiked.toggle()
                            handleLike()
                            
                        }
                    
                    NavigationLink(destination: PostDetailView(postRow: {self}, commentBtnVisibility: {v in self.showCommentBtn = v})) {
                        if showCommentBtn {
                            Image(systemName: Icon.bubble.rawValue)
                                .resizable()
                                .frame(width: 36, height: 36)
                                .padding(4)
                        }
                    }
                    .foregroundColor(Color(.systemFill))
               
                    
       
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

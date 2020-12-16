//
//  PostDetailView.swift
//  Multiplatform
//
//  Created by Joacim Nidén on 2020-12-14.
//

import SwiftUI
import KingfisherSwiftUI

struct PostDetailView<PostRowView: View>: View {
	
    @State var isLiked = false
	@ObservedObject var viewModel = PostDetailViewModel()
	
	let postRow: PostRowView
		
	init(@ViewBuilder postRow: () -> PostRowView) {
		self.postRow = postRow()
		viewModel.getComments()
	}

    var body: some View {
		
		ScrollView {
			LazyVStack {
				postRow
				LazyVStack(alignment: .leading, spacing: 10) {
					ForEach(viewModel.comments, id: \.self) { comment in
						HStack {
							ImageView(location: .local(name: "cat"))
								.frame(width: 20, height: 20)
								.cornerRadius(10)
							VStack {
								HStack(spacing: 10) {
									Text(comment.name).bold()
									Text(comment.text)
								}
								HStack {
									Text(comment.date.daysAgo)
								}
							}
						}
					}
				}.padding()
			}
		}
       
    }
}

struct PostDetailView_Previews: PreviewProvider {
    static var previews: some View {
		
		let url = URL(string: "https://placekitten.com/200/454")
        let post = Post(id: "", username: "Alexander", image: .remote(url: url), description: NSAttributedString(string: "The finest of all cats!"), isLiked: true)
		
		PostDetailView(postRow: { PostRowView(post, updateCallback: {_ in })})
    }
}

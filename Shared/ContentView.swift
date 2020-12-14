//
//  ContentView.swift
//  Shared
//
//  Created by Joacim Nidén on 2020-12-14.
//

import SwiftUI
import UIKit
import KingfisherSwiftUI

struct ContentView: View {
	
	var colors: [Color] = [.blue, .green, .yellow, .black, .orange, .red, .pink, .gray, .purple].shuffled()
	
	@ObservedObject var viewModel = ContentViewModel()
	
	init(fetch: Bool = true) {
		if fetch {
			viewModel.fetch()
		}
	}
	
    var body: some View {
		NavigationView {
			
			VStack(alignment: .leading, spacing: 2) {
				ScrollView(.horizontal) {
					LazyHStack {
						ForEach(colors, id: \.self) { color in
							Circle()
								.foregroundColor(color)
								.frame(width: 50, height: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
							
						}
						Spacer()
					}.frame(height: 50).padding(20)
				}
				
				ScrollView {
					LazyVStack(spacing: 50) {
						ForEach(viewModel.posts) { post in
							PostViewRow(post)
						}
					}
				}
				Spacer()
				
			}.navigationBarTitle("Jockes gram", displayMode: .inline)
			
		}.navigationViewStyle(StackNavigationViewStyle())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

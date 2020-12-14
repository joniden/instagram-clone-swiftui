//
//  ImageView.swift
//  Multiplatform
//
//  Created by Joacim Nidén on 2020-12-14.
//

import SwiftUI
import KingfisherSwiftUI

struct ImageView: View {
	
	let location: ImageLocation
	
    var body: some View {
		switch location {
			case .local(name: let name):
				Image(name)
					.resizable()
					.aspectRatio(contentMode: .fill)
			case .remote(url: let url):
				KFImage(url)
					.resizable()
					.aspectRatio(contentMode: .fill)
		}
    }
}

struct ImageView_Previews: PreviewProvider {
    static var previews: some View {
		ImageView(location: .local(name: "cat"))
    }
}

//
//  Icon.swift
//  Multiplatform
//
//  Created by Joacim Nidén on 2020-12-14.
//

import Foundation

enum Icon: String {
	case heart
	
	func fill(_ isActive: Bool) -> String {
		return isActive ? "\(self.rawValue).fill" : self.rawValue
	}
	
}

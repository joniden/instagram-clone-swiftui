//
//  Date+Extensions.swift
//  Multiplatform
//
//  Created by Joacim Nidén on 2020-12-15.
//

import Foundation

extension Date {
	
	var daysAgo: String {		
		let formatter = RelativeDateTimeFormatter()
		formatter.unitsStyle = .full
		return formatter.localizedString(for: self, relativeTo: Date())
		
	}
	
}

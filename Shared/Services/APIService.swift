//
//  APIService.swift
//  Multiplatform (iOS)
//
//  Created by Joacim Nidén on 2020-12-16.
//

import Foundation
import Combine

class APIService {
	
	let baseUrl = "http://192.168.1.108:3001/posts"
	
	private func publisher<T: Codable>() -> AnyPublisher<T, Never> {
		guard let url = URL(string: baseUrl) else {
			return Result.failure(AppError.fail)
				.publisher
				.assertNoFailure()
				.eraseToAnyPublisher()
		}
		
		let request = URLRequest(url: url)
		return URLSession.shared.dataTaskPublisher(for: request)
			.map { $0.data }
			.decode(type: T.self, decoder: JSONDecoder())
			.tryMap { $0 }
			.assertNoFailure()
			.eraseToAnyPublisher()
		
	}
	
	func getPosts() -> AnyPublisher<[DataPost], Never> {
		return publisher()
	}
	
}

enum AppError: Error {
	case fail
}

//
//  Data.swift
//  FirstApp
//
//  Created by meyer on 2022-01-21.
//

import Foundation

struct Post: Codable, Identifiable {
    var id: Int
    var title: String
    var body: String
}

class Api {
    private let postURLString = "https://jsonplaceholder.typicode.com/posts"
    private lazy var decoder = JSONDecoder()
    static var shared = Api()
    
    func fetchPosts() async throws -> [Post] {
        guard let url = URL(string: postURLString) else { throw FetchError.malformedURL }
        let (data, response) = try await URLSession.shared.data(from: url)
        guard (response as? HTTPURLResponse)?.statusCode == 200 else { throw FetchError.badRequest }
        let postsData = try decoder.decode([Post].self, from: data)
        return postsData
    }
}

enum FetchError: Error {
    case malformedURL
    case badRequest
}

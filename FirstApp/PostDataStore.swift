//
//  PostData.swift
//  FirstApp
//
//  Created by meyer on 2022-01-21.
//

import Foundation
import Combine


class PostDataStore: ObservableObject {
    @Published var posts: [Post] = []
    
    init() {
        Task {
            try await getPosts()
        }
    }
    
    func getPosts() async throws {
        posts = try await Api.shared.fetchPosts()
    }
    
}

//
//  PostList.swift
//  FirstApp
//
//  Created by meyer on 2022-01-21.
//

import SwiftUI

struct PostList: View {
    @ObservedObject var store = PostDataStore()
    
    var body: some View {
        List(store.posts) { post in
            VStack(alignment: .leading, spacing: 8) {
                Text(post.title)
                    .font(.system(.title, design: .serif))
                    .bold()
                
                Text(post.body)
                    .font(.system(.headline))
                    .foregroundColor(.secondary)
            }
        }
        .edgesIgnoringSafeArea(.all)
    }
}

struct PostList_Previews: PreviewProvider {
    static var previews: some View {
        PostList()
    }
}

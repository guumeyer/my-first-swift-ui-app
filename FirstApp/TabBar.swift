//
//  TabBar.swift
//  FirstApp
//
//  Created by meyer on 2022-01-16.
//

import SwiftUI

struct TabBar: View {
    var body: some View {
        TabView {
            Home().tabItem {
                Image(systemName: "play.circle.fill")
                Text("Home")
            }
            ContentView().tabItem {
                Image(systemName: "rectangle.stack.fill")
                Text("Certificates")
            }
            
//            CourseList().tabItem {
//                Image(systemName: "rectangle.stack.fill")
//                Text("Courses")
//            }
        }
        .edgesIgnoringSafeArea(.top)
    }
}

struct TabBar_Previews: PreviewProvider {
    static var previews: some View {
        TabBar()
    }
}

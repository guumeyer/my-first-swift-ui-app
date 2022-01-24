//
//  CourseStore.swift
//  FirstApp
//
//  Created by meyer on 2022-01-22.
//

import SwiftUI
import Contentful
import Combine

let client = Client(spaceId: "vr1l5kwi3rsb",
                         environmentId: "master",
                         accessToken: "FYmbo6oHkk9bq8PGU_Jdx1v2lBDNZ8yWqQd8x2C-Dhs"
)

func fetchArray(id: String) async throws -> [Entry] {
    let query = Query.where(contentTypeId: id)
    return try await withCheckedThrowingContinuation({ continuation in
        client.fetchArray(of: Entry.self, matching: query) { result in
            switch result {
                case .success(let array):
                print(array.items)
                    continuation.resume(returning: array.items)
                case .failure(let error):
                    print("Error \(error)!")
                    continuation.resume(throwing: error)
                }
        }
    })
}

class CourseStore: ObservableObject {
    @Published var courses = courseData
    
    
    
    init() {
        DispatchQueue.main.async {
            Task (priority: .background) {
            
                self.courses = await self.fetchCourses()
            }
            
        }
    }
    
    func fetchCourses() async -> [Course] {
        var courses:[Course] = [Course]()
        guard let items = try? await fetchArray(id: "course") else { return courses }
        let cardColors:[UIColor] = [#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1), #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1), #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1), #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1), #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1), #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1), #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1)]
        items.forEach { item in
            courses.append(
                Course(title: item.fields["title"] as? String ?? "",
                       subtitle: item.fields["subtitle"] as? String ?? "",
                       image: item.fields.linkedAsset(at: "image")?.url ?? URL(string: "")!,
                       logo: #imageLiteral(resourceName: "Logo1"),
                       color: cardColors.randomElement()!,
                       show: false)
                )
        }
        
        return courses
    }
}

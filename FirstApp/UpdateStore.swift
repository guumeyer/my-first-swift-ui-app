//
//  UpdateStore.swift
//  FirstApp
//
//  Created by meyer on 2022-01-16.
//

import Foundation
import Combine

class UpdateStore: ObservableObject {
    @Published var updates: [Update] = updateData
}

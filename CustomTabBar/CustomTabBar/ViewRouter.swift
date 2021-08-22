//
//  ViewRouter.swift
//  spot
//
//  Created by brown on 2021/08/21.
//  Copyright © 2021 LCC Ltd. All rights reserved.
//

import SwiftUI

enum Page: String {
    case home, liked, records, user
}

class ViewRouter: ObservableObject {
    @Published var currentPage: Page = .home
}

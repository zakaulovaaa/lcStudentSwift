//
//  News.swift
//  lc_student
//
//  Created by Дмитрий Загузин on 21.05.2020.
//  Copyright © 2020 Дарья Закаулова. All rights reserved.
//

import UIKit

class News {
    var title: String
    var description: String
    var mainImage: UIImage?
    var linkAllImage: [String]
    var mainText: String
    var datePublish: String
    var tag: String
    
    init(title: String, description: String, mainImage: UIImage?, linkAllImage: [String], mainText: String, datePublish: String, tag: String) {
        
        self.title = title
        self.description = description
        self.linkAllImage = linkAllImage
        self.mainImage = mainImage
        self.datePublish = datePublish
        self.tag = tag
        self.mainText = mainText
        
    }
}

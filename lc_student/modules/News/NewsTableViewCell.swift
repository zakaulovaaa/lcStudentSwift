//
//  NewsTableViewCell.swift
//  lc_student
//
//  Created by Дарья Закаулова on 24.05.2020.
//  Copyright © 2020 Дарья Закаулова. All rights reserved.
//

import UIKit

var kek: [Int] = []

class NewsTableViewCell: UITableViewCell {

    @IBOutlet weak var titleNews: UITextView!
    @IBOutlet weak var descriptionNews: UITextView!
    @IBOutlet weak var descriptionNewsLC: NSLayoutConstraint!
    @IBOutlet weak var titleNewsLC: NSLayoutConstraint!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
//        descriptionNewsLC.constant = self.descriptionNews.contentSize.height
//        titleNewsLC.constant = self.titleNews.contentSize.height
//        print("!!!!!!!!!!!!!!!!!!!")
//        kek.append( Int(self.titleNews.contentSize.height) )
//        print(kek)
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

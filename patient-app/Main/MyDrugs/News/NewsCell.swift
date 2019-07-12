//
//  NewsCell.swift
//  patient-app
//
//  Created by Elliott Brunet on 12.07.19.
//  Copyright © 2019 Elliott Brunet. All rights reserved.
//

import UIKit

class NewsCell: UICollectionViewCell {

    @IBOutlet weak var title: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    class var reuseIdentifier: String {
        return "NewsCell"
    }
    
    class var nibName: String {
        return "NewsCell"
    }
    
    func configureCell(title: String) {
        self.title.text = title
    }

}

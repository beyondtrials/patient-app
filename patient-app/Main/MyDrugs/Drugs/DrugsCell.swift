//
//  DrugsCell.swift
//  patient-app
//
//  Created by Elliott Brunet on 12.07.19.
//  Copyright © 2019 Elliott Brunet. All rights reserved.
//

import UIKit

class DrugsCell: UITableViewCell {

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var molecularImage: UIImageView!
    @IBOutlet weak var onTrialIndicator: UILabel!
    @IBOutlet weak var takeSurveyButton: UIButton!
    @IBOutlet weak var attentionSign: UIImageView!
    
    @IBAction func takeSurveyAction(_ sender: Any) {
    }
    
    weak var delegate: TakeSurveyDelegate? = nil
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

protocol TakeSurveyDelegate: class {
    func takeSurvey()
}

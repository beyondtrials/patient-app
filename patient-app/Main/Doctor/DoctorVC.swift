//
//  DoctorVC.swift
//  patient-app
//
//  Created by Elliott Brunet on 13.07.19.
//  Copyright © 2019 Elliott Brunet. All rights reserved.
//

import UIKit

class DoctorVC: UIViewController {

    @IBOutlet weak var docView: UIView!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var callButton: UIButton!
    
    @IBAction func cancelAppointment(_ sender: Any) {
        if (!docView.isHidden) {
            docView.isHidden = true
            callButton.isHidden = true
            cancelButton.isHidden = true
        }
    }
    
    func showDoc() {
        docView.isHidden = false
        cancelButton.isHidden = false
        callButton.isHidden = false
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        showDoc()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

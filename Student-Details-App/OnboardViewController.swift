//
//  ViewController.swift
//  Student-Details-App
//
//  Created by Supraja on 17/03/24.
//

import UIKit

class OnboardViewController : UIViewController {
    
    @IBOutlet weak var studentAppLabel: UILabel!
    @IBOutlet weak var existingSchoolButton: UIButton!
    @IBOutlet weak var registerNewSchoolButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        existingSchoolButton.layer.cornerRadius = 7
        registerNewSchoolButton.layer.cornerRadius = 7
        
    }
    
    @IBAction func didTouchExistingSchoolButtonAction() {
        let storyboard = self.storyboard?.instantiateViewController(withIdentifier: "SchoolLogInViewController") as! SchoolLogInViewController
         self.navigationController?.pushViewController(storyboard, animated: true)
    }
    
    @IBAction func didTouchRegisterNewSchoolButtonAction() {
        let storyboard = self.storyboard?.instantiateViewController(withIdentifier: "RegisterNewSchoolViewController") as! RegisterNewSchoolViewController
         self.navigationController?.pushViewController(storyboard, animated: true)
    }
}


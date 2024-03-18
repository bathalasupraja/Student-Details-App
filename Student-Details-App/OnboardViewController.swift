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
        //164, 84, 232, 0.961)
        //67, 247, 235, 0.969)
        existingSchoolButton.layer.cornerRadius = 7
        registerNewSchoolButton.layer.cornerRadius = 7
        existingSchoolButton.layer.backgroundColor = CGColor(srgbRed: 164/255, green: 84/255, blue: 232/255, alpha: 0.961)
        registerNewSchoolButton.layer.backgroundColor = CGColor(red: 67/255, green: 247/255, blue: 235/255, alpha: 0.969)
        
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


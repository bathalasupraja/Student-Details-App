//
//  LoginPageViewController.swift
//  Student-Details-App
//
//  Created by Supraja on 22/03/24.
//

import UIKit

class HomeLoginViewController: UIViewController {
    
    static func create() -> HomeLoginViewController? {
        UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "HomeLoginViewController") as? HomeLoginViewController
    }
    
    @IBOutlet weak var schoolNameLabel: UILabel!
    @IBOutlet weak var addButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func didTouchAddButtonAction() {
        if let controller = AddStudentsViewController.create() {
            self.navigationController?.pushViewController(controller, animated: true)
        }
    }
}

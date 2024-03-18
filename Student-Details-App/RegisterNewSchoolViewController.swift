//
//  RegisterNewSchoolViewController.swift
//  Student-Details-App
//
//  Created by Supraja on 18/03/24.
//

import UIKit

class RegisterTableViewCell: UITableViewCell {
    
    static let id = "RegisterTableViewCell"
    
    @IBOutlet weak var registerButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        registerButton.layer.cornerRadius = 7
    }
}

struct TextFieldModel {
    var name: String
    var placeholder: String
    var value: String?
}

class RegisterNewSchoolViewController: UIViewController {
    
    @IBOutlet weak var newSchoolTableView: UITableView!
    
    var textFields = [TextFieldModel]()

    override func viewDidLoad() {
        super.viewDidLoad()
        createTextFields()
        newSchoolTableView.separatorStyle = .none
        newSchoolTableView.allowsSelection = false
        newSchoolTableView.dataSource = self
        newSchoolTableView.delegate = self
    }
    
    func createTextFields() {
        textFields.append(TextFieldModel(name: "School name", placeholder: "Enter school name."))
        textFields.append(TextFieldModel(name: "School Id", placeholder: "Enter school Id."))
        textFields.append(TextFieldModel(name: "Password", placeholder: "Enter Password."))
        textFields.append(TextFieldModel(name: "Confirm password", placeholder: "Enter confirm password."))
    }
    
    func getCellIdentifierAtIndexPath(_ indexPath: IndexPath) -> String {
        switch indexPath.row {
        case 0,1,2,3:
            return RegisterNewSchoolTableViewCell.id
        default:
            return RegisterTableViewCell.id
        }
    }
    
    func getCellHeightAtIndexPath(_ indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0,1,2,3:
            return 80
        default:
            return 90
        }
    }
    
    @IBAction func didTouchRegisterButtonAction() {
        let storyboard = self.storyboard?.instantiateViewController(withIdentifier: "SchoolLogInViewController") as! SchoolLogInViewController
         self.navigationController?.pushViewController(storyboard, animated: true)
    }
}

extension RegisterNewSchoolViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return textFields.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = getCellIdentifierAtIndexPath(indexPath)
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        if let registerNewSchoolTableViewCell = cell as? RegisterNewSchoolTableViewCell {
            let textField = textFields[indexPath.row]
            registerNewSchoolTableViewCell.prepareWithTextField( textField, delegate: self, indexPath: indexPath)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let height = getCellHeightAtIndexPath(indexPath)
        return height
    }
}

extension RegisterNewSchoolViewController: RegisterNewSchoolTableViewCellDelegate {
    func didUpdateText(_ text: String?, tag: Int) {
        print(text)
        print(tag)
        textFields[tag].value = text
    }
}

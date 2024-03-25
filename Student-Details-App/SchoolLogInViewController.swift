//
//  SchoolLogInViewController.swift
//  Student-Details-App
//
//  Created by Supraja on 17/03/24.
//

import UIKit

class LoginTableViewCell: UITableViewCell {
    
    static let id = "LoginTableViewCell"
    
    @IBOutlet weak var loginButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        //87, 245, 102, 0.969
        loginButton.layer.cornerRadius = 7
        loginButton.layer.backgroundColor = CGColor(red: 87/255, green: 245/255, blue: 102/255, alpha: 0.969)
    }
}

enum LoginFieldTypeEnum {
    case id, password
}

struct FieldModel {
    var type: LoginFieldTypeEnum
    var name: String
    var placeholder: String
    var value: String?
}

class SchoolLogInViewController: UIViewController {
    
    static func create() -> SchoolLogInViewController? {
        UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SchoolLogInViewController") as? SchoolLogInViewController
    }
    
    @IBOutlet weak var schoolLoginLabel: UILabel!
    @IBOutlet weak var schoolLoginTableView: UITableView!
    
    var loginFields = [FieldModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createLoginfields()
        schoolLoginTableView.separatorStyle = .none
        schoolLoginTableView.allowsSelection = false
        schoolLoginTableView.dataSource = self
        schoolLoginTableView.delegate = self
    }
    
    func createLoginfields() {
        loginFields.append(FieldModel(type: .id, name: "School Id", placeholder: "Enter school name."))
        loginFields.append(FieldModel(type: .password, name: "Password", placeholder: "Enter password."))
    }
    
    func getCellIdentifierAtIndexPath(_ indexPath: IndexPath) -> String {
        switch indexPath.row {
        case 0,1:
            return SchoolLoginTableViewCell.id
        default:
            return LoginTableViewCell.id
        }
    }
    
    func getCellHeightAtIndexPath(_ indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0,1:
            return 90
        default:
            return 100
        }
    }
    
    private func getTextForFieldType(_ type: LoginFieldTypeEnum) -> String? {
        loginFields.first(where: { $0.type == type })?.value
    }
    
    @IBAction func didTouchLoginButtonAction() {
        view.endEditing(true)
        guard let idText = getTextForFieldType(.id), let id = Int16(idText), let password = getTextForFieldType(.password) else {
            showToast("Please enter valid input", message: "Please check the entered fields.")
            return
        }
        
        if password.count >= 8 {
            if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
                appDelegate.schoolExists(id: id, password: password) { isSchoolExist in
                    if isSchoolExist {
                        self.showToast("Wrong password", message: "Please check the entered fields.")
                    }
                    if let controller = HomeLoginViewController.create() {
                        self.navigationController?.pushViewController(controller, animated: true)
                    }
                }
            } else {
                showToast("Please enter valid input", message: "Please check the entered fields.")
                
            }
        }
    }
    private func showToast(_ title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default))
        self.present(alert, animated: true)
    }
}

extension SchoolLogInViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return loginFields.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = getCellIdentifierAtIndexPath(indexPath)
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        if let schoolLoginTableViewCell = cell as? SchoolLoginTableViewCell {
            let loginField = loginFields[indexPath.row]
            schoolLoginTableViewCell.prepareWithField(loginField, delegate: self, indexPath: indexPath)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let height = getCellHeightAtIndexPath(indexPath)
        return height
    }
}

extension SchoolLogInViewController: SchoolLoginTableViewCellDelegate {
    func didUpdateText(_ text: String?, tag: Int) {
        print(text)
        print(tag)
        loginFields[tag].value = text
    }
}


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
        //201, 66, 126, 0.961
        registerButton.layer.backgroundColor = CGColor(srgbRed: 201/255, green: 66/255, blue: 126/255, alpha: 0.961)
    }
}

enum FieldTypeEnum {
    case id, name, password, confirmPassword
}

struct RegistrationFieldModel {
    var type: FieldTypeEnum
    var name: String
    var placeholder: String
    var value: String?
}

class RegisterNewSchoolViewController: UIViewController {
    
    @IBOutlet weak var newSchoolTableView: UITableView!
    
    var registrationFields = [RegistrationFieldModel]()

    override func viewDidLoad() {
        super.viewDidLoad()
        createTextFields()
        newSchoolTableView.separatorStyle = .none
        newSchoolTableView.allowsSelection = false
        newSchoolTableView.dataSource = self
        newSchoolTableView.delegate = self
    }
    
    func createTextFields() {
        registrationFields.append(RegistrationFieldModel(type: .name, name: "School name", placeholder: "Enter school name."))
        registrationFields.append(RegistrationFieldModel(type: .id, name: "School Id", placeholder: "Enter school Id."))
        registrationFields.append(RegistrationFieldModel(type: .password, name: "Password", placeholder: "Enter Password."))
        registrationFields.append(RegistrationFieldModel(type: .confirmPassword, name: "Confirm password", placeholder: "Enter confirm password."))
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
    
    private func getTextForFieldType(_ type: FieldTypeEnum) -> String? {
        registrationFields.first(where: { $0.type == type })?.value
    }
    
    @IBAction func didTouchRegisterButtonAction() {
        view.endEditing(true)
        guard let name = getTextForFieldType(.name), let idText = getTextForFieldType(.id), let id = Int16(idText), let password = getTextForFieldType(.password), let confirmPassword = getTextForFieldType(.confirmPassword) else {
            showToast("Please enter valid input", message: "Please check the entered fields.")
            return
        }
        
        if password.count >= 8 && password == confirmPassword {
            if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
                appDelegate.fetchAllSchools { schools in
                    if let schools, !schools.isEmpty, schools.first(where: { $0.id == id }) != nil {
                        self.showToast("School is already exist!", message: "Entered school is already exists, please try login instead of new registration")
                    } else {
                        appDelegate.addSchool(name: name, id: id, password: password)
                        if let controller = SchoolLogInViewController.create() {
                            self.navigationController?.pushViewController(controller, animated: true)
                        }
                    }
                }
            }
        } else {
            showToast("Wrong password", message: "Please check the entered password.")
        }
    }
    
    private func showToast(_ title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default))
        self.present(alert, animated: true)
    }
}

extension RegisterNewSchoolViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return registrationFields.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = getCellIdentifierAtIndexPath(indexPath)
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        if let registerNewSchoolTableViewCell = cell as? RegisterNewSchoolTableViewCell {
            let textField = registrationFields[indexPath.row]
            registerNewSchoolTableViewCell.prepareWithTextField( textField, delegate: self, indexPath: indexPath)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let height = getCellHeightAtIndexPath(indexPath)
        return height
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let controller = storyboard?.instantiateViewController(withIdentifier: "AddStudentDetails") {
            self.navigationController?.pushViewController(controller, animated: true)
        }
    }
}

extension RegisterNewSchoolViewController: RegisterNewSchoolTableViewCellDelegate {
    func didUpdateText(_ text: String?, tag: Int) {
        print(text)
        print(tag)
        registrationFields[tag].value = text
    }
}

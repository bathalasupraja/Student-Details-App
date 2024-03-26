//
//  AddStudentsViewController.swift
//  Student-Details-App
//
//  Created by Supraja on 22/03/24.
//

import UIKit

class SaveButtonTableViewCell: UITableViewCell {
    
    static let id = "SaveButtonTableViewCell"
    
    @IBOutlet weak var saveButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        //250, 160, 42, 0.961
        saveButton.layer.cornerRadius = 7
        saveButton.layer.backgroundColor = CGColor(srgbRed: 250/255, green: 160/255, blue: 42/255, alpha: 0.961)
    }
}


enum AddStudentsFieldTypeEnum {
    case name, id, password, fatherName, motherName, confirmPassword
}

struct SchoolDataModel {
    var type: AddStudentsFieldTypeEnum
    var name: String
    var placeholder: String
    var value: String?
}

class AddStudentsViewController: UIViewController {
    
    static func create() -> AddStudentsViewController? {
        UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AddStudentsViewController") as? AddStudentsViewController
    }
    
    @IBOutlet weak var studentsTableView: UITableView!
    
    var schoolDetails = [SchoolDataModel]()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        createSchoolDetails()
        studentsTableView.separatorStyle = .none
        studentsTableView.allowsSelection = false
        studentsTableView.dataSource = self
        studentsTableView.delegate = self
    }
    
    func createSchoolDetails() {
        schoolDetails.append(SchoolDataModel(type: .name, name: "Student Name", placeholder: "Enter student name."))
        schoolDetails.append(SchoolDataModel(type: .id,name: "Student Id", placeholder: "Enter student id."))
        schoolDetails.append(SchoolDataModel(type: .password, name: "Student Password", placeholder: "Enter student password."))
        schoolDetails.append(SchoolDataModel(type: .fatherName, name: "Father Name", placeholder: "Enter Father name."))
        schoolDetails.append(SchoolDataModel(type: .motherName, name: "Mother Name", placeholder: "Enter mother name."))
        schoolDetails.append(SchoolDataModel(type: .confirmPassword, name: "Confirm Password", placeholder: "Enter confirm password."))
    }
    
    func getCellIdentifierAtIndexPath(_ indexPath: IndexPath) -> String {
        switch indexPath.row {
        case 0,1,2,3,4,5:
            return AddStudentsTableViewCell.id
        default:
            return SaveButtonTableViewCell.id
        }
    }
        
    private func getTextForFieldType(_ type: AddStudentsFieldTypeEnum) -> String? {
        schoolDetails.first(where: { $0.type == type })?.value
    }
    
    func getCellHeightAtIndexPath(_ indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0,1,2,3,4,5:
            return 80
        default:
            return 90
        }
    }
}

extension AddStudentsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return schoolDetails.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = getCellIdentifierAtIndexPath(indexPath)
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        if let AddStudentsTableViewCell = cell as? AddStudentsTableViewCell {
            let textField = schoolDetails[indexPath.row]
            AddStudentsTableViewCell.prepareWithTextField( textField, delegate: self, indexPath: indexPath)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let height = getCellHeightAtIndexPath(indexPath)
        return height
    }
}

extension AddStudentsViewController: AddStudentsTableViewCellDelegate {
    func didUpdateText(_ text: String?, tag: Int) {
        print(text)
        print(tag)
        schoolDetails[tag].value = text
    }
}

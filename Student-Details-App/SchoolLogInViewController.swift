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
        loginButton.layer.cornerRadius = 7
    }
}

struct FieldModel {
    var name: String
    var placeholder: String
    var value: String?
}

class SchoolLogInViewController: UIViewController {
    
    @IBOutlet weak var schoolLoginLabel: UILabel!
    @IBOutlet weak var schoolLoginTableView: UITableView!
    
    var fields = [FieldModel]()

    override func viewDidLoad() {
        super.viewDidLoad()
        createFields()
        schoolLoginTableView.separatorStyle = .none
        schoolLoginTableView.allowsSelection = false
        schoolLoginTableView.dataSource = self
        schoolLoginTableView.delegate = self
    }
    
    func createFields() {
        fields.append(FieldModel(name: "School Id", placeholder: "Enter school name."))
        fields.append(FieldModel(name: "Password", placeholder: "Enter password."))
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
}

extension SchoolLogInViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fields.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = getCellIdentifierAtIndexPath(indexPath)
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        if let schoolLoginTableViewCell = cell as? SchoolLoginTableViewCell {
            let field = fields[indexPath.row]
            schoolLoginTableViewCell.prepareWithField(field, delegate: self, indexPath: indexPath)
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
        fields[tag].value = text
    }
}


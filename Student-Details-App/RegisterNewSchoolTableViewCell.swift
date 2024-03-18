//
//  RegisterNewSchoolTableViewCell.swift
//  Student-Details-App
//
//  Created by Supraja on 18/03/24.
//

import UIKit

protocol RegisterNewSchoolTableViewCellDelegate: AnyObject {
    func didUpdateText(_ text: String?, tag: Int)
}

class RegisterNewSchoolTableViewCell: UITableViewCell {
    
    static let id = "RegisterNewSchoolTableViewCell"
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    
    weak var delegate: RegisterNewSchoolTableViewCellDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func prepareWithTextField(_ textField: TextFieldModel, delegate: RegisterNewSchoolTableViewCellDelegate?, indexPath: IndexPath) {
        nameTextField.keyboardType = getKeypadTypeForIndexPath(indexPath)
        nameLabel.text = textField.name
        nameTextField.placeholder = textField.placeholder
        nameTextField.text = textField.value
        self.delegate = delegate
        nameTextField.tag = indexPath.row
    }
    
    func getKeypadTypeForIndexPath(_ indexPath: IndexPath) -> UIKeyboardType {
        switch indexPath.row {
        case 0,1:
            return .numbersAndPunctuation
        default:
            return .default
        }
    }
}

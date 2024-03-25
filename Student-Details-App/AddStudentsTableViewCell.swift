//
//  AddStudentsTableViewCell.swift
//  Student-Details-App
//
//  Created by Supraja on 22/03/24.
//

import UIKit

protocol AddStudentsTableViewCellDelegate: AnyObject {
    func didUpdateText(_ text: String?, tag: Int)
}

class AddStudentsTableViewCell: UITableViewCell {
    
    static let id = "AddStudentsTableViewCell"
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    
    weak var delegate: AddStudentsTableViewCellDelegate?
    

    override func awakeFromNib() {
        super.awakeFromNib()
        nameTextField.delegate = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func prepareWithTextField(_ textField: SchoolDataModel, delegate: AddStudentsTableViewCellDelegate?, indexPath: IndexPath) {
        nameTextField.keyboardType = getKeypadTypeForIndexPath(indexPath)
        nameLabel.text = textField.name
        nameTextField.placeholder = textField.placeholder
        nameTextField.text = textField.value
        self.delegate = delegate
        let isPassword = textField.type == .password || textField.type == .confirmPassword
        nameTextField.isSecureTextEntry = isPassword
        nameTextField.tag = indexPath.row
    }
    
    func getKeypadTypeForIndexPath(_ indexPath: IndexPath) -> UIKeyboardType {
        switch indexPath.row {
        case 0,3,4:
            return .namePhonePad
        case 1,2,5:
            return .numbersAndPunctuation
        default:
            return .default
        }
    }
}

extension AddStudentsTableViewCell: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        nameTextField.resignFirstResponder()
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        delegate?.didUpdateText(textField.text, tag: textField.tag)
    }
}

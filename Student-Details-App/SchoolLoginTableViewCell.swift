//
//  SchoolLoginTableViewCell.swift
//  Student-Details-App
//
//  Created by Supraja on 17/03/24.
//

import UIKit

protocol SchoolLoginTableViewCellDelegate: AnyObject {
    func didUpdateText(_ text: String?, tag: Int)
}

class SchoolLoginTableViewCell: UITableViewCell {
    
    static let id = "SchoolLoginTableViewCell"
    
    @IBOutlet weak var schoolIdLabel: UILabel!
    @IBOutlet weak var schoolIdTextField: UITextField!
    
    weak var delegate: SchoolLoginTableViewCellDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        schoolIdTextField.delegate = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func prepareWithField(_ loginField: FieldModel, delegate: SchoolLoginTableViewCellDelegate?, indexPath: IndexPath) {
        schoolIdTextField.keyboardType = getKeypadTypeForIndexPath(indexPath)
        schoolIdLabel.text = loginField.name
        schoolIdTextField.placeholder = loginField.placeholder
        schoolIdTextField.text = loginField.value
        let isPassword = loginField.type == .password
        schoolIdTextField.isSecureTextEntry = isPassword
        self.delegate = delegate
        schoolIdTextField.tag = indexPath.row
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

extension SchoolLoginTableViewCell: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        schoolIdTextField.resignFirstResponder()
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        delegate?.didUpdateText(textField.text, tag: textField.tag)
    }
}

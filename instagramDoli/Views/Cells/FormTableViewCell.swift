//
//  FormTableViewCell.swift
//  instagramDoli
//
//  Created by Nicolas Dolinkue on 31/03/2023.
//

import UIKit

protocol FormTableViewCellDelegate {
    func formTableViewCell(_ cell: FormTableViewCell, didUpdateField updateModel: EditProfileFormModel)
}

class FormTableViewCell: UITableViewCell, UITextFieldDelegate {
    
    private let formLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.numberOfLines = 1
        return label
    }()
    
    private let field: UITextField = {
       let field = UITextField()
        field.returnKeyType = .done
        return field
    }()

    static let identifier = "IGFormTableViewCell"
    public var delegate: FormTableViewCellDelegate?
    private var model: EditProfileFormModel?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        clipsToBounds = true
        contentView.addSubview(formLabel)
        contentView.addSubview(field)
        field.delegate = self
        selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        //assign frame
        formLabel.frame = CGRect(x: 5, y: 0, width: contentView.width/3, height: contentView.height)
        field.frame = CGRect(x: formLabel.rigtht + 5, y: 0, width: contentView.width - 10 - formLabel.width, height: contentView.height)
    }
    
    public func configure(with model: EditProfileFormModel) {
        self.model = model
        formLabel.text = model.label
        field.placeholder = model.placeholder
        field.text = model.value
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        formLabel.text = nil
        field.placeholder = nil
        field.text = nil
    }
    
    // MARK: - Field
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        model?.value = textField.text
        textField.resignFirstResponder()
        guard let model = model else {
            return true
        }
        delegate?.formTableViewCell(self, didUpdateField: model)
        return true
    }
    

}

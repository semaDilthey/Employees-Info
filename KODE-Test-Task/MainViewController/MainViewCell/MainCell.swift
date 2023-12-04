//
//  EmployeeCell.swift
//  KODE-Test-Task
//
//  Created by Семен Гайдамакин on 23.11.2023.
//

import Foundation
import UIKit
import SkeletonView


class MainCell: UITableViewCell {
    
    static let identifier = "MainCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        backgroundColor = .kdSnowyWhite
        contentView.isSkeletonable = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    private func configureCell(with viewModel: MainCellModelProtocol?) {
        if let viewModel = viewModel {
            fullNameLabel.text = viewModel.firstName + " " + viewModel.lastName
//            departmentLabel.text = viewModel.department
            let departmentCode = viewModel.department
            let constantsManager = ConstantsManager.shared
            if let departmentName = constantsManager.departaments[departmentCode] {
                        departmentLabel.text = departmentName
                        } else {
                            departmentLabel.text = "Unknown departament"
                        }
            positionLabel.text = viewModel.position
            birthdayLabel.text = formatDateString(viewModel.birthday)
            avatarImage.set(imageURL: viewModel.avatarUrl)
        }
    }
    
    func startSkeleton() {
        contentView.showSkeleton()
    }
    
    func finishSkeleton() {
        contentView.hideSkeleton()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    var viewModel : MainCellModelProtocol? {
        didSet {
            configureCell(with: viewModel)
        }
    }
    
    let avatarImage : WebImageView = {
        let image = WebImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.backgroundColor = .white
        image.widthAnchor.constraint(equalToConstant: 72).isActive = true
        image.heightAnchor.constraint(equalToConstant: 72).isActive = true
        image.clipsToBounds = true
        image.layer.cornerRadius = 36
        image.isSkeletonable = true
        return image
    }()
    
    let fullNameLabel : UILabel = {
        let label = UILabel()
        label.font = .interFont(size: 15, weight: .regular)
        label.textColor = .kdBlack
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "             "
        label.isSkeletonable = true
        label.clipsToBounds = true
        return label
    }()
    
    let departmentLabel : UILabel = {
        let label = UILabel()
        label.font = .interFont(size: 14, weight: .medium)
        label.textColor = .kdLightGrey
        label.text = "        "
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isSkeletonable = true
        return label
    }()
    
    let positionLabel : UILabel = {
        let label = UILabel()
        label.font = .interFont(size: 13, weight: .thin)
        label.textColor = .kdLightDark
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "          "
        label.isSkeletonable = true
        return label
    }()
    
    let birthdayLabel : UILabel = {
        let label = UILabel()
        label.font = .interFont(size: 14, weight: .light)
        label.textColor = .kdLightDark
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "      "
        label.isSkeletonable = true
        label.isHidden = true
        return label
    }()
    
    private func formatDateString(_ dateString: String) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        if let date = dateFormatter.date(from: dateString) {
            dateFormatter.dateFormat = "dd MMM"
            dateFormatter.locale = Locale(identifier: "en_EN")
            return dateFormatter.string(from: date)
        } else {
            return nil
        }
    }
    
//    let separatorYearView = SeparatorView()
    
//    var separatorIsActive : Bool = false {
//        didSet {
//            if separatorIsActive {
//                separatorYearView.translatesAutoresizingMaskIntoConstraints = false
//                contentView.addSubview(separatorYearView)
//                separatorYearView.heightAnchor.constraint(equalToConstant: 30).isActive = true
//                separatorYearView.topAnchor.constraint(equalTo: avatarImage.topAnchor, constant: 10).isActive = true
//                separatorYearView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
//                separatorYearView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
//            } else {
//                separatorYearView.translatesAutoresizingMaskIntoConstraints = true
//            }
//        }
//    }
}

private extension MainCell {
    
    func setupUI() {
        contentView.addSubview(avatarImage)
        
        let nameAndDepartmentStack = UIStackView(arrangedSubviews: [fullNameLabel, departmentLabel])
        nameAndDepartmentStack.translatesAutoresizingMaskIntoConstraints = false
        nameAndDepartmentStack.spacing = 8
        nameAndDepartmentStack.isSkeletonable = true
        
        let positionAndNameAndDepartamentStack = UIStackView(arrangedSubviews: [nameAndDepartmentStack, positionLabel])
        positionAndNameAndDepartamentStack.axis = .vertical
        positionAndNameAndDepartamentStack.spacing = 5
        positionAndNameAndDepartamentStack.translatesAutoresizingMaskIntoConstraints = false
        positionAndNameAndDepartamentStack.isSkeletonable = true
        contentView.addSubview(positionAndNameAndDepartamentStack)
        contentView.addSubview(birthdayLabel)
        
        NSLayoutConstraint.activate([
            avatarImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            avatarImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16)
        ])

        NSLayoutConstraint.activate([
            positionAndNameAndDepartamentStack.leadingAnchor.constraint(equalTo: avatarImage.trailingAnchor, constant: 16),
            positionAndNameAndDepartamentStack.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            birthdayLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -21),
            birthdayLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: 10)
        ])
    }
}



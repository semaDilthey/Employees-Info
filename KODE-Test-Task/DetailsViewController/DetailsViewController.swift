//
//  DetailsViewController.swift
//  KODE-Test-Task
//
//  Created by Семен Гайдамакин on 24.11.2023.
//

import Foundation
import UIKit

class DetailsViewController : UIViewController {
    
    let viewModel : DetailsViewModel
    
    init(viewModel: DetailsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .kdSnowyWhite
        setupUpperBlock()
        setupLowerBlock()
        setBackButton()
        setupCall()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        avatarImage.addShadow(radius: 5)
    }
    
    var configureController : MainCellModelProtocol? {
        didSet {
            configure(with: configureController)
        }
    }
    
    //MARK: - Upper Block
    
    let avatarImage : WebImageView = {
        let image = WebImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.backgroundColor = .white
        image.widthAnchor.constraint(equalToConstant: 100).isActive = true
        image.heightAnchor.constraint(equalToConstant: 100).isActive = true
        image.clipsToBounds = true
        image.layer.cornerRadius = 50
        return image
    }()
    
    let fullNameLabel : UILabel = {
        let label = UILabel()
        label.font = .interFont(size: 24, weight: .extraBold)
        label.textColor = .kdBlack
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Алиса Иванова"
        label.isSkeletonable = true
        return label
    }()
    
    let departmentLabel : UILabel = {
        let label = UILabel()
        label.font = .interFont(size: 17, weight: .medium)
        label.textColor = .kdLightGrey
        label.text = "de"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isSkeletonable = true
        return label
    }()
    
    let positionLabel : UILabel = {
        let label = UILabel()
        label.font = .interFont(size: 13, weight: .thin)
        label.textColor = .kdLightDark
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Designer"
        label.isSkeletonable = true
        return label
    }()
    
    let birthdayLabel : UILabel = {
        let label = UILabel()
        label.font = .interFont(size: 14, weight: .light)
        label.textColor = .kdLightDark
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "22 сен"
        label.isSkeletonable = true
        return label
    }()
    
    //MARK: - Lower block
    
    private let lowerContainer : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .kdWhite
        return view
    }()
    
    let birthdayImage : UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "favoriteImage")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let birtdateLabel : UILabel = {
        let label = UILabel()
        label.text = "6 декабря 1998"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .interFont(size: 16, weight: .medium)
        label.textColor = .kdBlack
        return label
    }()
    
    let ageLabel : UILabel = {
        let label = UILabel()
        label.text = "24 года"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .interFont(size: 16, weight: .medium)
        label.textColor = .kdLightGrey
        return label
    }()
    
    private let separatorLine : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .kdLightGrey?.withAlphaComponent(0.2)
        return view
    }()
    
    let phoneImage : UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "phoneImage")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let phoneLabel : UILabel = {
        let label = UILabel()
        label.text = "7 967 615 55 22"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .interFont(size: 16, weight: .medium)
        label.textColor = .kdBlack
        label.isUserInteractionEnabled = true
        return label
    }()
    
    private func setupCall() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(callTapped))
        phoneLabel.addGestureRecognizer(tapGesture)
    }
    
    private func setBackButton() {
        let backButton = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(backAction))
        navigationItem.leftBarButtonItem = backButton
    }
    
    @objc func callTapped() {
        let actionSheet = UIAlertController(title: "Call this number?", message: nil, preferredStyle: .actionSheet)
        let option1 = UIAlertAction(title: phoneLabel.text, style: .default) { _ in
            
            guard let phoneNumber = self.phoneLabel.text else { return }
            let phoneNumberWithMask = self.viewModel.callNumberMask(phone: phoneNumber)
            if let phoneURL = URL(string: "tel://\(phoneNumberWithMask)") {
                    UIApplication.shared.open(phoneURL)
            } else {
           // your number not valid
            let tapAlert = UIAlertController(title: "Alert!!!", message: "Your mobile number is invalid", preferredStyle: UIAlertController.Style.alert)
                tapAlert.addAction(UIAlertAction(title: "OK", style: .destructive, handler: nil))
                self.present(tapAlert, animated: true, completion: nil)
            }  
        }

        let cancel = UIAlertAction(title: "Cancel", style: .cancel) { _ in
        }

        actionSheet.addAction(option1)
        actionSheet.addAction(cancel)

        present(actionSheet, animated: true, completion: nil)
    }
    
    @objc func backAction() {
        self.navigationController?.popViewController(animated: true)
    }
    
    private func configure(with configuration: MainCellModelProtocol?) {
        if let configuration = configuration {
            avatarImage.set(imageURL: configuration.avatarUrl)
            fullNameLabel.text = configuration.firstName + " " + configuration.lastName
            departmentLabel.text = configuration.department
            positionLabel.text = configuration.position
            birtdateLabel.text = viewModel.formatDateString(configuration.birthday)
            ageLabel.text = viewModel.calculateAge(from: configuration.birthday)!
            phoneLabel.text = viewModel.formatPhoneWithMask(phone: configuration.phone)
        }
    }
}
    
private extension DetailsViewController {
        
    func setupUpperBlock() {
        let nameAndDepartmentStack = createStack(spacing: 8, axis: .horizontal, arrangedSubviews: [fullNameLabel, departmentLabel])
        let positionAndNameAndDepartamentStack = createStack(spacing: 12, axis: .vertical, alignment: .center, arrangedSubviews: [nameAndDepartmentStack, positionLabel])
        let allElementsStack = createStack(spacing: 24, axis: .vertical, alignment: .center, arrangedSubviews: [avatarImage, positionAndNameAndDepartamentStack])
        
        view.addSubview(allElementsStack)
        
        NSLayoutConstraint.activate([
            allElementsStack.topAnchor.constraint(equalTo: view.topAnchor, constant: 72),
            allElementsStack.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
        
    func setupLowerBlock() {
        view.addSubview(lowerContainer)
                NSLayoutConstraint.activate([
                    lowerContainer.topAnchor.constraint(equalTo: positionLabel.bottomAnchor, constant: 24),
                    lowerContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                    lowerContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                    lowerContainer.bottomAnchor.constraint(equalTo: view.bottomAnchor)
                ])
        
        let ageStack = createStack(spacing: 12, axis: .horizontal, arrangedSubviews: [birthdayImage, birtdateLabel, ageLabel])
        let ageAndSeparatorStack = createStack(spacing: 21, axis: .vertical, arrangedSubviews: [ageStack, separatorLine])
        let phoneStack = createStack(spacing: 12, axis: .horizontal, arrangedSubviews: [phoneImage, phoneLabel])
        phoneStack.isUserInteractionEnabled = true
        let finalStack = createStack(spacing: 19, axis: .vertical, arrangedSubviews: [ageAndSeparatorStack, phoneStack])
        finalStack.isUserInteractionEnabled = true
        
        lowerContainer.addSubview(finalStack)
        lowerContainer.isUserInteractionEnabled = true
        finalStack.centerXAnchor.constraint(equalTo: lowerContainer.centerXAnchor).isActive = true
        finalStack.topAnchor.constraint(equalTo: lowerContainer.topAnchor, constant: 20).isActive = true
        finalStack.leadingAnchor.constraint(equalTo: lowerContainer.leadingAnchor, constant: 16).isActive = true
        finalStack.trailingAnchor.constraint(equalTo: lowerContainer.trailingAnchor, constant: -16).isActive = true
        
        separatorLine.heightAnchor.constraint(equalToConstant: 0.5).isActive = true
        
        birthdayImage.widthAnchor.constraint(equalToConstant: 20).isActive = true
        birthdayImage.heightAnchor.constraint(equalToConstant: 20).isActive = true

        phoneImage.widthAnchor.constraint(equalToConstant: 20).isActive = true
        phoneImage.heightAnchor.constraint(equalToConstant: 20).isActive = true
    }
    
}
    

private extension DetailsViewController {
    
     func createStack(spacing: CGFloat, axis: NSLayoutConstraint.Axis, alignment: UIStackView.Alignment? = .none, arrangedSubviews : [UIView]) -> UIStackView {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.spacing = spacing
        if let alignment = alignment {
            stack.alignment = alignment
        }
        stack.axis = axis
        for subview in arrangedSubviews {
            stack.addArrangedSubview(subview)
        }
        return stack
    }
    
}

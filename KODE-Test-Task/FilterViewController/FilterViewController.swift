//
//  FilterViewController.swift
//  KODE-Test-Task
//
//  Created by Семен Гайдамакин on 28.11.2023.
//

import UIKit

enum Sorting {
    case byBirthday
    case byAlphabet
}

class FilterViewController: UIViewController {

    let viewModel : FilterViewModel?

    init(viewModel: FilterViewModel?) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        view.backgroundColor = .kdSnowyWhite
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadStates()
    }
    
    private let titleFilter : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.text = "Sort by"
        label.font = UIFont.interFont(size: 18, weight: .medium)
        label.textColor = .kdLightDark
        return label
    }()
    
    private lazy var closeButton : UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .kdErrorRed
        button.setTitle("Cancel", for: .normal)
        button.titleLabel?.font = UIFont.interFont(size: 14, weight: .bold)
        button.titleLabel?.textAlignment = .center
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(didTappedClose), for: .touchUpInside)
        return button
    }()
    
    private lazy var doneButton : UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .kdPurple
        button.setTitle("Done", for: .normal)
        button.titleLabel?.font = UIFont.interFont(size: 14, weight: .bold)
        button.titleLabel?.textAlignment = .center
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(didTappedDone), for: .touchUpInside)
        return button
    }()
    
    lazy var switchBirthday : UISwitch = {
        let checkBox = UISwitch()
        checkBox.translatesAutoresizingMaskIntoConstraints = false
        checkBox.tintColor = .kdPurple
        checkBox.addTarget(self, action: #selector(selectBirthday), for: .valueChanged)
        return checkBox
    }()
    
    lazy var switchSurname : UISwitch = {
        let checkBox = UISwitch()
        checkBox.translatesAutoresizingMaskIntoConstraints = false
        checkBox.tintColor = .kdPurple
        checkBox.addTarget(self, action: #selector(selectAlphabet), for: .valueChanged)
        return checkBox
    }()
    
    private let labelBirthday : UILabel = {
        let label = UILabel()
        label.text = "Birthday"
        label.font = .interFont(size: 16, weight: .medium)
        label.textColor = .kdLightDark
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let labelSurname : UILabel = {
        let label = UILabel()
        label.text = "Last name"
        label.font = .interFont(size: 16, weight: .medium)
        label.textColor = .kdLightDark
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
        
    func saveStates() {
        viewModel?.saveSwitchStates(bday: switchBirthday, surname: switchSurname)
    }
    
    func loadStates() {
        viewModel?.loadSwitchStates(bday: switchBirthday, surname: switchSurname)
    }
  
    @objc func didTappedClose() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func didTappedDone() {
        viewModel?.doneTapped(birthdayState: switchBirthday.isOn, surnameState: switchSurname.isOn)
        self.dismiss(animated: true, completion: nil)
        saveStates()
    }
    
   
    @objc func selectBirthday() {
        if switchBirthday.isOn {
                switchSurname.isOn = false
                labelSurname.textColor = .kdLightDark
                labelBirthday.textColor = .kdPurple
                switchBirthday.onTintColor = .kdPurple
        } else {
                labelBirthday.textColor = .kdLightDark
                switchBirthday.onTintColor = .alizarin
        }
    }
    
    @objc func selectAlphabet() {
        if switchSurname.isOn {
                switchBirthday.isOn = false
                labelBirthday.textColor = .kdLightDark
                labelSurname.textColor = .kdPurple
                switchSurname.onTintColor = .kdPurple
        } else {
                labelSurname.textColor = .kdLightDark
                switchSurname.onTintColor = .alizarin
        }
    }
    
    
    
    
}

    




//MARK: - SetupUI, SetupPickers
extension FilterViewController {
    
    private func setupUI() {
        
        let headerStack = UIStackView(arrangedSubviews: [closeButton, titleFilter, doneButton])
        headerStack.axis = .horizontal
        headerStack.distribution = .equalCentering
        headerStack.translatesAutoresizingMaskIntoConstraints = false
        closeButton.widthAnchor.constraint(equalToConstant: 65).isActive = true
        doneButton.widthAnchor.constraint(equalToConstant: 65).isActive = true
        
        view.addSubview(headerStack)
        NSLayoutConstraint.activate([
            headerStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            headerStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            headerStack.topAnchor.constraint(equalTo: view.topAnchor, constant: 15)
        ])
       
        
        let surnameStack = UIStackView(arrangedSubviews: [switchSurname, labelSurname])
        surnameStack.axis = .horizontal
        surnameStack.alignment = .fill
        surnameStack.spacing = 30
        surnameStack.translatesAutoresizingMaskIntoConstraints = false
        
        let birthdayStack = UIStackView(arrangedSubviews: [switchBirthday, labelBirthday])
        birthdayStack.axis = .horizontal
        birthdayStack.alignment = .fill
        birthdayStack.spacing = 30
        birthdayStack.translatesAutoresizingMaskIntoConstraints = false
                
        let presentableStack = UIStackView(arrangedSubviews: [surnameStack, birthdayStack])
        presentableStack.axis = .vertical
        presentableStack.alignment = .fill
        presentableStack.spacing = 15
        presentableStack.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(presentableStack)
        
        NSLayoutConstraint.activate([
            presentableStack.topAnchor.constraint(equalTo: headerStack.bottomAnchor, constant: 50),
            presentableStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 44),
            presentableStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -44)
        ])
    }
}



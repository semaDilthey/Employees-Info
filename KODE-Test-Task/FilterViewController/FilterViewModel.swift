//
//  FilterViewModel.swift
//  KODE-Test-Task
//
//  Created by Семен Гайдамакин on 01.12.2023.
//

import Foundation
import UIKit

protocol FilterViewModelDelegate: AnyObject {
    func didSelectFilter(byBirthday: Bool?, bySurname: Bool?)
}

class FilterViewModel {
    
    weak var delegate : FilterViewModelDelegate?
    
    var mainViewModel: MainViewModel // инъекция зависимости

    init(mainViewModel: MainViewModel) {
        self.mainViewModel = mainViewModel
    }

    func doneTapped(birthdayState byBirthday: Bool, surnameState bySurname: Bool){
        delegate?.didSelectFilter(byBirthday: byBirthday, bySurname: bySurname)
    }
    
    func saveSwitchStates(bday : UISwitch, surname: UISwitch) {
        let userDefaults = UserDefaults.standard
        let birtdaySwitchKey = KeySwitch.birthday.rawValue
        let surnameKey = KeySwitch.surname.rawValue
        if bday.isOn {
                userDefaults.setValue(true, forKey: birtdaySwitchKey)
                userDefaults.setValue(false, forKey: surnameKey)
        } else if
            surname.isOn {
                userDefaults.setValue(true, forKey: surnameKey)
                userDefaults.setValue(false, forKey: birtdaySwitchKey)
        } else {
            userDefaults.setValue(false, forKey: surnameKey)
            userDefaults.setValue(false, forKey: birtdaySwitchKey)
        }
    }
    
    func loadSwitchStates(bday : UISwitch, surname: UISwitch) {
        let userDefaults = UserDefaults.standard
        let birtdaySwitchKey = KeySwitch.birthday.rawValue
        let surnameKey = KeySwitch.surname.rawValue

        if userDefaults.object(forKey: birtdaySwitchKey) != nil {
            let isBirthdaySwitchOn = userDefaults.bool(forKey: birtdaySwitchKey)
            bday.isOn = isBirthdaySwitchOn
        }
        
        if userDefaults.object(forKey: surnameKey) != nil {
            let isSurnameSwitchOn = userDefaults.bool(forKey: surnameKey)
            surname.isOn = isSurnameSwitchOn
        }
    }
    
    enum KeySwitch : String {
        case birthday = "birthdayKey"
        case surname = "surnameKey"
    }
}

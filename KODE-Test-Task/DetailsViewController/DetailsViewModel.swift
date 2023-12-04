//
//  DetailsViewModel.swift
//  KODE-Test-Task
//
//  Created by Семен Гайдамакин on 24.11.2023.
//

import Foundation

class DetailsViewModel {
    
    var dataStorage : DataStorageProtocol

    init(dataStorage: DataStorageProtocol) {
        self.dataStorage = dataStorage
    }
    
    func getDetailsConfiguration(at indexPath: IndexPath, with employees: [MainCellModelProtocol]) -> MainCellModelProtocol? {
        guard indexPath.row < employees.count else { return nil }
        return employees[indexPath.row]
      }

    
    func formatDateString(_ dateString: String) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        if let date = dateFormatter.date(from: dateString) {
            dateFormatter.dateFormat = "dd MMMM yyyy"
            dateFormatter.locale = Locale(identifier: "en_EN")
            return dateFormatter.string(from: date)
        } else {
            return nil
        }
    }
    
    func calculateAge(from date: String) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        if let birthDate = dateFormatter.date(from: date) {
            let currentDate = Date()
            let calendar = Calendar.current
            let components = calendar.dateComponents([.year], from: birthDate, to: currentDate)
            if let years = components.year {
                let lastDigit = years % 10
                let lastTwoDigits = years % 100
                
                if lastTwoDigits >= 11 && lastTwoDigits <= 14 {
                    return /*/"\(years) лет"*/ "\(years) years"
                } else if lastDigit == 1 {
                    return /*"\(years) год"*/ "\(years) years"
                } else if lastDigit >= 2 && lastDigit <= 4 {
                    return /*"\(years) года"*/ "\(years) years"
                } else {
                    return /*"\(years) лет"*/ "\(years) years"
                }
            }
        }
        return nil
    }
    
    func formatPhoneWithMask(phone: String) -> String {
        let numbers = phone.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
        var result = ""
        var index = numbers.startIndex // numbers iterator
        let mask = "+7 (XXX) XXX XXXX"
        // iterate over the mask characters until the iterator of numbers ends
        for ch in mask where index < numbers.endIndex {
            if ch == "X" {
                // mask requires a number in this place, so take the next one
                result.append(numbers[index])

                // move numbers iterator to the next index
                index = numbers.index(after: index)

            } else {
                result.append(ch) // just append a mask character
            }
        }
        return result
    }
    
    func callNumberMask(phone: String) -> String {
        let numbers = phone.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
        var result = ""
        var index = numbers.startIndex // numbers iterator
        let mask = "+XXXXXXXXXXX"
        // iterate over the mask characters until the iterator of numbers ends
        for ch in mask where index < numbers.endIndex {
            if ch == "X" {
                // mask requires a number in this place, so take the next one
                result.append(numbers[index])

                // move numbers iterator to the next index
                index = numbers.index(after: index)

            } else {
                result.append(ch) // just append a mask character
            }
        }
        return result
    }
    
    
    
}

//
//  Formatter.swift
//  KODE-Test-Task
//
//  Created by Семен Гайдамакин on 09.12.2023.
//

import Foundation

enum Formatter {
    /// Возращает форматированную дату в формате "29 october 2000"". Юзаем при конфигурации Details View Controller
    static func formatDate(_ dateString: String) -> String? {
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
    
    /// Возращает форматированную дату в формате "29 jun". Юзаем в ячейке Main
    static func formatDateString(_ dateString: String) -> String? {
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
    
    /// Возращает форматированную дату в формате "29 лет". Юзаем в ячейке Main
    static func calculateAge(birthday date: String) -> String? {
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
                    return /*лет*/ "\(years) years"
                } else if lastDigit == 1 {
                    return /*год*/ "\(years) years"
                } else if lastDigit >= 2 && lastDigit <= 4 {
                    return /*года*/ "\(years) years"
                } else {
                    return /*лет*/ "\(years) years"
                }
            }
        }
        return nil
    }
    
    /// Возращает форматированный номер. Юзаем в Details
    static func formatPhoneWithMask(phone: String) -> String {
        let numbers = phone.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
        var result = ""
        var index = numbers.startIndex
        let mask = "+7 (XXX) XXX XXXX"
        for ch in mask where index < numbers.endIndex {
            if ch == "X" {
                result.append(numbers[index])

                index = numbers.index(after: index)

            } else {
                result.append(ch) // just append a mask character
            }
        }
        return result
    }
    
    /// Возращает форматированный номер, необходимый уже для вызова. Юзаем в Details actions
    static func callNumberMask(phone: String) -> String {
        let numbers = phone.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
        var result = ""
        var index = numbers.startIndex
        let mask = "+XXXXXXXXXXX"
        for ch in mask where index < numbers.endIndex {
            if ch == "X" {
                result.append(numbers[index])

                index = numbers.index(after: index)

            } else {
                result.append(ch) 
            }
        }
        return result
    }
    
}

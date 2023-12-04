//
//  +Date.swift
//  KODE-Test-Task
//
//  Created by Семен Гайдамакин on 26.11.2023.
//

import Foundation

extension Date {
   func getFormattedDate(format: String) -> String {
        let dateformat = DateFormatter()
        dateformat.dateFormat = format
        return dateformat.string(from: self)
    }
}

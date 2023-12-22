//
//  ConstantsManager.swift
//  KODE-Test-Task
//
//  Created by Семен Гайдамакин on 23.11.2023.
//

import Foundation

class ConstantsManager {
    
    static let shared = ConstantsManager()
    
    private init () {}
    
    let departaments = ["android" : "Android", "ios":"iOs", "design":"Design","management":"Management","qa":"QA","back_office":"Back office","frontend":"Frontend","hr":"HR","pr":"PR","backend":"Backend","support":"Support","analytics":"Analytics"]
             

}

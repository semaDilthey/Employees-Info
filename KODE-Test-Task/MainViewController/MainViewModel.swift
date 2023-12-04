//
//  ViewModel.swift
//  KODE-Test-Task
//
//  Created by Семен Гайдамакин on 21.11.2023.
//

import Foundation
import UIKit

protocol MainViewModelProtocol {
    var networkManager : NetworkManager { get set }
    var dataStorage : DataStorageProtocol { get set }
    
    func loadData(completion: @escaping () -> Void)
    func refreshData(completion: @escaping () -> Void)
    
    func getEmployeeViewModel(at indexPath: IndexPath, in selectedDepartament: Int) -> MainCellModelProtocol?
    func numberOfRows(in selectedDepartament: Int) -> Int
    
    var loadingState : LoadingState! { get set }
    var employees : [MainCellModelProtocol]! { get set}
    var employeeForPassing : [MainCellModelProtocol]? { get set }
    var sortingMethod : Sorting? {get set}
    
    func presentCorrectSearchMessage(theCorrectSearchView: UIView, for parentView: UIView, present: Bool)
    func presentErrorController(navController: UINavigationController)
    func presentDetailsController(navController: UINavigationController)
    func filterBySortingMethod(byAlphabet: Bool?, byBirthday: Bool?)
}


class MainViewModel : MainViewModelProtocol {
    
    var networkManager : NetworkManager
    var dataStorage : DataStorageProtocol
    
    let filterViewModel: FilterViewModel?
    
    // networking State (.loading, .success, .error)
    var loadingState : LoadingState!
    
    // copy of dataStorage.employees
    var employees : [MainCellModelProtocol]!
    
    var employeeForPassing : [MainCellModelProtocol]? // use it as костыль для передачи в детаилс контроллер
        
    // sorting by Filter View Controller (.byBirthday, .byAlphabet)
    var sortingMethod : Sorting? = nil
    
    init(networkManager: NetworkManager, dataStorage: DataStorageProtocol, filterViewModel: FilterViewModel?) {
        self.networkManager = networkManager
        self.dataStorage = dataStorage
        self.filterViewModel = filterViewModel
    }
    
    // загрузка даты
    func loadData(completion: @escaping () -> Void) {
        fetchData(completion: completion)
    }
    // обновление дейт
    func refreshData(completion: @escaping () -> Void) {
        fetchData(completion: completion)
    }
    // создаем модельку ячейки для таблицы
    func getEmployeeViewModel(at indexPath: IndexPath, in selectedDepartament: Int) -> MainCellModelProtocol? {
        let filteredEmployees = filterEmployee(in: selectedDepartament)
        guard indexPath.row < filteredEmployees.count else {
                return nil
            }
        return filteredEmployees[indexPath.row]
      }
    
    // число ячеек в таблице в зависимости от выбранного департамента
    func numberOfRows(in selectedDepartament: Int) -> Int {
      let modelArray = filterEmployee(in: selectedDepartament)
        return modelArray.count
    }
    // презентит вью в случае, если нет совпадений при поиске работников через UISearchBar
    func presentCorrectSearchMessage(theCorrectSearchView: UIView, for parentView: UIView, present: Bool) {
        if present {
            theCorrectSearchView.translatesAutoresizingMaskIntoConstraints = false
            parentView.addSubview(theCorrectSearchView)
            theCorrectSearchView.centerXAnchor.constraint(equalTo: parentView.centerXAnchor).isActive = true
            theCorrectSearchView.centerYAnchor.constraint(equalTo: parentView.centerYAnchor).isActive = true
            theCorrectSearchView.widthAnchor.constraint(equalToConstant: parentView.frame.width - 100).isActive = true
            theCorrectSearchView.heightAnchor.constraint(equalToConstant: parentView.frame.width - 200).isActive = true
        } else {
            theCorrectSearchView.removeFromSuperview()
        }
        parentView.layoutIfNeeded()
    }
    
    func presentErrorController(navController: UINavigationController) {
        let coordinator = Coordinator()
        coordinator.showErrorController(controller: navController)
    }
    
    func presentDetailsController(navController: UINavigationController) {
        let coordinator = Coordinator()
        coordinator.showDetailsController(controller: navController)
    }
    
    func filterBySortingMethod(byAlphabet: Bool?, byBirthday: Bool?) {
        if let byBirthday = byBirthday, let byAlphabet = byAlphabet {
            if byBirthday {
                sortingMethod = .byBirthday
            } else if byAlphabet {
                sortingMethod = .byAlphabet
            } else {
                sortingMethod = nil
            }
        }
    }
}


private extension MainViewModel {
    
    func fetchData(completion: @escaping () -> Void) {
        loadingState = .loading
        DispatchQueue.main.asyncAfter(deadline: .now()+1) {
            self.networkManager.fetchUsersData(requestStatus: .success) { [weak self] data in
                switch data {
                case .success(let user):
                    self?.dataStorage.employees = self?.createModels(from: user.items) ?? []
                    self?.loadingState = .success
                case .failure(let error):
                    print("Error is \(error)")
                    self?.loadingState = .error(error.localizedDescription)
                }
                    completion()
                self?.employees = self?.dataStorage.employees
            }
        }
        
    }
    
    
    func createModels(from users: [EmployeeInfo]) -> [MainCellModel] {
        users.map { user in
            return MainCellModel(id: user.id,
                                     avatarUrl: user.avatarUrl,
                                     firstName: user.firstName,
                                     lastName: user.lastName,
                                     department: user.department,
                                     position: user.position,
                                     birthday: user.birthday,
                                     phone: user.phone)
        }
    }
    
    
     func filterEmployee(in selectedDepartament: Int) -> [MainCellModelProtocol]{
        guard let departament = DepartamentsEnum(rawValue: selectedDepartament) else {
                //  Кейс, когда selectedDepartament не мэтчится с rawValue
                return []
            }
        var filteredEmployee: [MainCellModelProtocol]
                  
        switch departament {
        case .all :
            if let employees = employees {
                    filteredEmployee = employees
               } else {
                   return []
               }
        case .analitycs :
            filteredEmployee = employees.filter { $0.department == "analytics"}
        case .android :
            filteredEmployee = employees.filter { $0.department == "android"}
        case .backend :
            filteredEmployee = employees.filter { $0.department == "backend"}
        case .backoffice :
            filteredEmployee = employees.filter { $0.department == "back_office"}
        case .design :
            filteredEmployee = employees.filter { $0.department == "design"}
        case .frontend :
            filteredEmployee = employees.filter { $0.department == "frontend"}
        case .hr :
            filteredEmployee = employees.filter { $0.department == "hr"}
        case .pr :
            filteredEmployee = employees.filter { $0.department == "pr"}
        case .iOs :
            filteredEmployee = employees.filter { $0.department == "ios"}
        case .management :
            filteredEmployee = employees.filter { $0.department == "management"}
        case .qa :
            filteredEmployee = employees.filter { $0.department == "qa"}
        case .support :
            filteredEmployee = employees.filter { $0.department == "support"}
        }
         
         switch sortingMethod {
         case .byBirthday : 
             filteredEmployee = sortPeopleByBirthday(filteredEmployee)
         case .byAlphabet :
             filteredEmployee.sort { $0.lastName < $1.lastName}
         case nil :
             employeeForPassing = filteredEmployee
             return filteredEmployee
         }

         employeeForPassing = filteredEmployee
         
        return filteredEmployee
    }
    
        
    func sortPeopleByBirthday(_ employee: [MainCellModelProtocol]) -> [MainCellModelProtocol] {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"

        let currentDate = Date()
       // let daysLeftBeforeNewYear = 365 - Calendar.current.ordinality(of: .day, in: .year, for: currentDate)!
        
        return employee.sorted { employee1, employee2 in
            if let date1 = dateFormatter.date(from: employee1.birthday),
               let date2 = dateFormatter.date(from: employee2.birthday) {
                // Вычисляем количество дней до дня рождения
                let daysUntilBirthday1 = Calendar.current.ordinality(of: .day, in: .year, for: date1) ?? 0
                let daysUntilBirthday2 = Calendar.current.ordinality(of: .day, in: .year, for: date2) ?? 0

            return daysUntilBirthday1 < daysUntilBirthday2
            }
            return false
        }
    }
   
}


enum LoadingState : Equatable {
    case loading, success, error(String)
}
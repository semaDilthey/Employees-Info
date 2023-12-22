//
//  ViewModel.swift
//  KODE-Test-Task
//
//  Created by Семен Гайдамакин on 21.11.2023.
//

import Foundation
import UIKit


protocol MainEmployeeHandlingProtocol {
    var employees: [MainCellModelProtocol]? { get set }
    var employeeForPassing : [MainCellModelProtocol]? { get set }
    func filterBySortingMethod(byAlphabet: Bool?, byBirthday: Bool?)
}

// Протокол для отображения данных
protocol MainPresentationHandlingProtocol {
    func presentCorrectSearchMessage(view: UIView, for parentView: UIView, present: Bool)
    var coordinator : CoordinatorProtocol { get }
}

// Основной протокол, объединяющий остальные
protocol MainViewModelProtocol: MainEmployeeHandlingProtocol, MainPresentationHandlingProtocol {
    var dataStorage: DataStorageProtocol { get set }
    var loadingState: LoadingState { get set }
    var sortingMethod : Sorting? { get set }
    
    func loadData(completion: @escaping () -> Void)
    func refreshData(completion: @escaping () -> Void)
    
    func getEmployeeViewModel(at indexPath: IndexPath, in selectedDepartament: Int) -> MainCellModelProtocol?
    func numberOfRows(in selectedDepartament: Int) -> Int
}


class MainViewModel : MainViewModelProtocol {
    
    var networkManager : Networking
    var dataStorage : DataStorageProtocol
    var coordinator : CoordinatorProtocol = Coordinator()
    
    // networking State (.loading, .success, .error)
    var loadingState : LoadingState = .loading
    
    init(networkManager: Networking, dataStorage: DataStorageProtocol) {
        self.networkManager = networkManager
        self.dataStorage = dataStorage
    }
   
    //MARK:  DataHandlingProtocol
    // загрузка даты
    func loadData(completion: @escaping () -> Void) {
        fetchData(completion: completion)
    }
    // обновление дейт
    func refreshData(completion: @escaping () -> Void) {
        fetchData(completion: completion)
    }
    
    //MARK: TableHandlingProtocol
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
    
    //MARK: EmployeeHandlingProtocol
    // copy of dataStorage.employees
    var employees : [MainCellModelProtocol]?
    var employeeForPassing : [MainCellModelProtocol]? // use it as костыль для передачи в детаилс контроллер
    
    // sorting by Filter View Controller (.byBirthday, .byAlphabet)
    var sortingMethod : Sorting? = nil
    
    func filterBySortingMethod(byAlphabet: Bool?, byBirthday: Bool?) {
        if let byBirthday, let byAlphabet {
            if byBirthday {
                sortingMethod = .byBirthday
            } else if byAlphabet {
                sortingMethod = .byAlphabet
            } else {
                sortingMethod = nil
            }
        }
    }
    
    //MARK: PresentationHandlingProtocol

    // презентит вью в случае, если нет совпадений при поиске работников через UISearchBar
    func presentCorrectSearchMessage(view: UIView, for parentView: UIView, present: Bool) {
        if present {
            view.translatesAutoresizingMaskIntoConstraints = false
            parentView.addSubview(view)
            view.centerXAnchor.constraint(equalTo: parentView.centerXAnchor).isActive = true
            view.centerYAnchor.constraint(equalTo: parentView.centerYAnchor).isActive = true
            view.widthAnchor.constraint(equalToConstant: parentView.frame.width - 100).isActive = true
            view.heightAnchor.constraint(equalToConstant: parentView.frame.width - 200).isActive = true
        } else {
            view.removeFromSuperview()
        }
        parentView.layoutIfNeeded()
    }
}


private extension MainViewModel {
    
    func fetchData(completion: @escaping () -> Void) {
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
                if let dataEmployees = self?.dataStorage.employees {
                    self?.employees = dataEmployees
                }
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
        guard let employees else { return [] }
        switch departament {
        case .all :
            filteredEmployee = employees
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
         
//         switch sortingMethod {
//         case .byBirthday : 
//             filteredEmployee = sortPeopleByBirthday(filteredEmployee)
//         case .byAlphabet :
//             filteredEmployee.sort { $0.lastName < $1.lastName}
//         case nil :
//             employeeForPassing = filteredEmployee
//             return filteredEmployee
//         }
//
//         employeeForPassing = filteredEmployee
//         
//        return filteredEmployee
         return sorting(sortingMethod: sortingMethod, employees: filteredEmployee)
    }
    
    private func sorting(sortingMethod: Sorting?, employees: [MainCellModelProtocol]) -> [MainCellModelProtocol] {
        var filteredEmployees = employees
        switch sortingMethod {
        case .byBirthday :
            filteredEmployees = sortPeopleByBirthday(filteredEmployees)
        case .byAlphabet :
            filteredEmployees.sort { $0.lastName < $1.lastName}
        case nil :
            employeeForPassing = filteredEmployees
            return filteredEmployees
        }
        employeeForPassing = filteredEmployees
        
        return filteredEmployees
    }
    
        
    func sortPeopleByBirthday(_ employee: [MainCellModelProtocol]) -> [MainCellModelProtocol] {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"

//        let currentDate = Date()
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

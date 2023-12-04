//
//  ViewController.swift
//  KODE-Test-Task
//
//  Created by Семен Гайдамакин on 21.11.2023.
//

import UIKit
import SkeletonView
import CoreGraphics

final class MainViewController: UIViewController {
    
    // MARK: - Properties

    private(set) var viewModel: MainViewModelProtocol?
    
    private let departamentsView = DepartamentsView()
    private let correctView = CorrectSearchView()

    // MARK: - Initialization

    init(viewModel: MainViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        view.backgroundColor = .kdSnowyWhite
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
        departamentsCallback()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    // MARK: - Networking Methods
    
    private func fetchData() {
        viewModel?.loadData { [weak self] in
            DispatchQueue.main.async {
                    self?.updateUIaccordingToLoadingState()
            }
        }
    }
    
    // Отвечает за переключение вкладок в хедере
    private func departamentsCallback() {
        departamentsView.reloadTableView = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
    
    // MARK: - Helper Methods for Networking acivity
    // настройка UI в зависимости от состояния сети
    private func updateUIaccordingToLoadingState() {
        
        guard let viewModel = viewModel else { return }
        switch viewModel.loadingState {
        case .loading:
            showLoadingUI()
        case .success:
            self.showSuccessUI()
        case .error(let string):
            print("Error description \(string)")
            DispatchQueue.main.async {
                self.presentErrorBanner(duration: 1.5)
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                self.showErrorUI()
               }
        case nil:
            print("Here will be nil")
        }
    }

    private func showLoadingUI() {
        DispatchQueue.main.async {
            self.navigationController?.navigationBar.layer.zPosition = 0
            self.tableView.showSkeleton()
            self.tableView.reloadData()
        }
    }

    private func showSuccessUI() {
        DispatchQueue.main.async {
            self.navigationController?.navigationBar.layer.zPosition = 0
            self.tableView.reloadData()
        }
    }

    private func showErrorUI() {
        guard let navigationController = navigationController else { return }
        viewModel?.presentErrorController(navController: navigationController)
    }

    // MARK: - Private Methods for UI

    private func setupUI() {
        setupSearchBar()
        setupDepartaments()
        setupTableView()
    }
    
    private func setupSearchBar() {
        searchBar.frame = .init(x: 0, y: 0, width: 200, height: 50)
        searchBar.placeholder = "Search..."
        searchBar.backgroundColor = .kdSnowyWhite
        searchBar.showsBookmarkButton = true
        searchBar.setImage(UIImage(named: "searchBarIcon")?.imageWithColor(color: .kdLightGrey!), for: .bookmark, state: .normal)
        searchBar.layer.cornerRadius = 15
        searchBar.clipsToBounds = true
        
        searchBar.delegate = self
        navigationItem.titleView = searchBar
    }
    
    private func setupDepartaments() {
        view.addSubview(departamentsView)
        departamentsView.backgroundColor = .red
        departamentsView.translatesAutoresizingMaskIntoConstraints = false
        departamentsView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        departamentsView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        departamentsView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        departamentsView.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(MainCell.self, forCellReuseIdentifier: MainCell.identifier)
        tableView.backgroundColor = .kdSnowyWhite
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.refreshControl = refreshControl
        
        view.addSubview(tableView)
        
        tableView.topAnchor.constraint(equalTo: departamentsView.bottomAnchor, constant: 0 ).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        view.addSubview(errorBanner)
        errorBanner.topAnchor.constraint(equalTo: view.topAnchor, constant: -100).isActive = true
        errorBanner.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        errorBanner.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        errorBanner.heightAnchor.constraint(equalToConstant: 100).isActive = true
    }
    

    //MARK: - UI Objects
        
    private let searchBar = UISearchBar()

    private var tableView : UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.isSkeletonable = true
        return table
    }()
        
    private let refreshControl : CustomRefreshControl = {
        let refresh = CustomRefreshControl()
        refresh.translatesAutoresizingMaskIntoConstraints = false
        refresh.tintColor = .kdPurple
        refresh.addTarget(self, action: #selector(refreshy), for: .valueChanged)
        return refresh
    }()
    
    let errorBanner : ErrorBanner = {
        let banner = ErrorBanner()
        banner.translatesAutoresizingMaskIntoConstraints = false
        banner.text.text = ErrorBanner.ErrorType.noInternet.rawValue
        banner.text.textColor = .kdWhite
        banner.text.font = .interFont(size: 13, weight: .medium)
        banner.backgroundColor = .kdErrorRed
        return banner
    }()
    
    func presentErrorBanner(duration: TimeInterval) {
        self.navigationController?.navigationBar.layer.zPosition = -1
        DispatchQueue.main.async {
            UIView.animate(withDuration: duration) {
                self.errorBanner.frame = .init(x: 0, y: 0, width:  UIScreen.main.bounds.width, height: 100)
            }
        }
    }
    
    //MARK: - UI Actions

    @objc func refreshy(_ sender: UIRefreshControl) {
        self.viewModel?.refreshData { [weak self] in
            DispatchQueue.main.async {
                self?.updateUIaccordingToLoadingState()
                DispatchQueue.main.async {
                    UIView.animate(withDuration: 0.3) {
                        self?.departamentsView.selectedDepartament = 0
                        self?.departamentsView.layoutIfNeeded()
                        self?.searchBar.text = ""
                    }
                    self?.tableView.reloadData()
                }
            }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            sender.endRefreshing()
        }
    }
    
   
}
    
// MARK: - UITableViewDelegate

extension MainViewController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let viewModel = viewModel, let employeeForPassing = viewModel.employeeForPassing else { return }
        // Создаем экземпляр DetailsViewController с нужной вьюмоделью
        let vc = DetailsViewController(viewModel: DetailsViewModel(dataStorage: viewModel.dataStorage))
        let viewModelToOpen = vc.viewModel.getDetailsConfiguration(at: indexPath, with: employeeForPassing)
        vc.configureController = viewModelToOpen
        // Переходим к деталям сотрудника
        searchBar.resignFirstResponder()
        navigationController?.pushViewController(vc, animated: true)
    }
}
// MARK: - SkeletonTableViewDataSource

extension MainViewController : SkeletonTableViewDataSource {
    
    func collectionSkeletonView(_ skeletonView: UITableView, cellIdentifierForRowAt indexPath: IndexPath) -> ReusableCellIdentifier {
        return MainCell.identifier
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let viewModel = viewModel else { return 1 }
        if viewModel.loadingState == .loading {
            return 10
        } else {
            return viewModel.numberOfRows(in: departamentsView.selectedDepartament)
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MainCell.identifier, for: indexPath) as! MainCell
        if let viewModel = viewModel {
            if viewModel.loadingState == .loading {
                cell.startSkeleton()
            }
            if !viewModel.dataStorage.employees.isEmpty {
                let cellViewModel = viewModel.getEmployeeViewModel(at: indexPath, in: departamentsView.selectedDepartament)
                cell.viewModel = cellViewModel
                cell.startSkeleton()
                cell.birthdayLabel.isHidden = viewModel.sortingMethod != .byBirthday
            }
            
            // Задержка для имитации загрузки данных
            let deadline: DispatchTime = departamentsView.selectedDepartament == 0 ? .now() + 1 : .now() + 0.4
            DispatchQueue.main.asyncAfter(deadline: deadline) {
                cell.finishSkeleton()
            }
        }
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.separatorInset = UIEdgeInsets(top: 0, left: 40, bottom: 0, right: 40)
        cell.layoutMargins = UIEdgeInsets.zero
        cell.preservesSuperviewLayoutMargins = false
    }
    
}

// MARK: - UISearchBarDelegate

extension MainViewController : UISearchBarDelegate  {
    
    func searchBarBookmarkButtonClicked(_ searchBar: UISearchBar) {
        
        guard let viewModel = viewModel else { return }
        let filterViewModel = FilterViewModel(mainViewModel: viewModel as! MainViewModel)
        filterViewModel.delegate = self
        let sheetViewController = FilterViewController(viewModel: filterViewModel)
                if let sheet = sheetViewController.sheetPresentationController {
                    sheet.detents = [.medium()]
                }
                present(sheetViewController, animated: true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        guard var viewModel = viewModel else { return }
        viewModel.employees = []
        
        if searchText.isEmpty {
            viewModel.employees = viewModel.dataStorage.employees
            viewModel.presentCorrectSearchMessage(theCorrectSearchView: correctView, for: view, present: false)
            searchBar.resignFirstResponder()
        } else {
            viewModel.employees = viewModel.dataStorage.employees.filter {
                $0.firstName.lowercased().contains(searchText.lowercased()) ||
                $0.lastName.lowercased().contains(searchText.lowercased())
            }
            viewModel.presentCorrectSearchMessage(theCorrectSearchView: correctView, for: view, present: false)
        }
        
        // Показываем сообщение, если нет результатов поиска
        if viewModel.employees.count == 0 {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            viewModel.presentCorrectSearchMessage(theCorrectSearchView: correctView, for: view, present: true)
        }
        
        if refreshControl.isRefreshing {
            return
           }
//        DispatchQueue.main.async {
//            self.tableView.reloadData()
//        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
  
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        return true
        
    }
}

// MARK: - FilterViewModelDelegate

extension MainViewController: FilterViewModelDelegate {
    
    // Обработка выбора фильтрации
    func didSelectFilter(byBirthday: Bool?, bySurname: Bool?) {
        
        viewModel?.filterBySortingMethod(byAlphabet: bySurname, byBirthday: byBirthday)
        
               DispatchQueue.main.async {
                   self.tableView.reloadData()
               }
        }
   }




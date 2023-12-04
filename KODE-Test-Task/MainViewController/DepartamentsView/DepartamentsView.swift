//
//  HeaderCollectionViewCell.swift
//  KODE-Test-Task
//
//  Created by Семен Гайдамакин on 27.11.2023.
//

import Foundation
import UIKit


class DepartamentsView: UIView {
    
    var collectionView: UICollectionView!
    
    var reloadTableView: (() -> Void)?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
        setupCollectionView()
        loadSelectedCell()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutIfNeeded() {
        super.layoutIfNeeded()
        loadSelectedCell()
        let indexPath = IndexPath(item: 0, section: 0) // Укажите нужный индекс секции и элемента
        collectionView.scrollToItem(at: indexPath, at: .left, animated: true)
    }
    
    let departaments = ["All", "Android", "iOs",  "Design","Management","QA", "Back office", "Frontend", "HR", "PR", "Backend", "Support", "Analytics"]
    var selectedDepartament = 0
    
    private func loadSelectedCell() {
        collectionView.reloadData()
        let indexPath = IndexPath(item: 0, section: 0)
        collectionView.selectItem(at: indexPath, animated: true, scrollPosition: [])
    }
    
    private func setupLayout() {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.scrollDirection = .horizontal
        collectionView = UICollectionView(frame: bounds, collectionViewLayout: layout)
    }

    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(DepartamentsCollectionViewCell.self, forCellWithReuseIdentifier: DepartamentsCollectionViewCell.identifier)
        collectionView.backgroundColor = .kdSnowyWhite
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        addSubview(collectionView)
        
        NSLayoutConstraint.activate([
                collectionView.topAnchor.constraint(equalTo: topAnchor),
                collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
                collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
                collectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
            ])
    }
    

}


extension DepartamentsView : UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return departaments.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DepartamentsCollectionViewCell.identifier, for: indexPath) as! DepartamentsCollectionViewCell
        cell.label.text = departaments[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let _ = collectionView.cellForItem(at: indexPath) as? DepartamentsCollectionViewCell {
            selectedDepartament = indexPath.row
            reloadTableView?()
        }
    }
}


extension DepartamentsView : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let department = departaments[indexPath.row]

            // Вычисляет размер ячейки на основе размера текста
            let textAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17)] // Устанавливает  шрифт
            let boundingRect = (department as NSString).boundingRect(with: CGSize(width: CGFloat.greatestFiniteMagnitude, height: 30), options: .usesLineFragmentOrigin, attributes: textAttributes, context: nil)

            // Добавляет дополнительное пространство, чтобы не быть слишком узким
            let cellWidth = ceil(boundingRect.width) + 20 // 20 - небольшой отступ
            let cellHeight: CGFloat = 30 // Высота ячейки

            return CGSize(width: cellWidth, height: cellHeight)
    }
}




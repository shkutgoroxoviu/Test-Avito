//
//  ViewController.swift
//  TestovoeAvito
//
//  Created by Oleg on 14.06.2023.
//

import UIKit
import SnapKit

class UpgradeListViewController: UIViewController, UpgradeListViewProtocol {
    var presenter: UpgradeListPresenterProtocol?
    
    private var message = ""
    
    private lazy var offerCollection: UICollectionView = {
        let size = NSCollectionLayoutSize(
            widthDimension: NSCollectionLayoutDimension.fractionalWidth(1),
            heightDimension: NSCollectionLayoutDimension.estimated(200)
        )
        let item = NSCollectionLayoutItem(layoutSize: size)
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: size, subitem: item, count: 1)
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20)
        section.interGroupSpacing = 15
       
        let layout = UICollectionViewCompositionalLayout(section: section)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(UpgradeListCell.self, forCellWithReuseIdentifier: UpgradeListCell.reuseID)
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
    }()
    
    private lazy var titleLable: UILabel = {
        let label = UILabel()
        label.text = "Сделайте объявление заметнее на 7 дней"
        label.font = UIFont.boldSystemFont(ofSize: 30)
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var chooseButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 8
        button.setTitle("Пригласить", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor(red: 0.07, green: 0.59, blue: 0.83, alpha: 1.00)
        button.addTarget(self, action: #selector(chooseButtonAction), for: .touchUpInside)
        return button
    }()
    
    private lazy var closeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "cancel"), for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        setupConstraints()
        presenter?.viewDidLoad()
    }
    
    func config(model: Response) {
        titleLable.text = model.result.title
        chooseButton.setTitle(model.result.actionTitle, for: .normal)
    }
    
    @objc private func chooseButtonAction() {
        let alert = UIAlertController(title: "Услуга", message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "Принять", style: .default)
        alert.addAction(alertAction)
        present(alert, animated: true)
    }
    
    private func configUI() {
        view.addSubview(offerCollection)
        view.addSubview(titleLable)
        view.addSubview(chooseButton)
        view.addSubview(closeButton)
        view.backgroundColor = .white
    }
    
    private func setupConstraints() {
        titleLable.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(160)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().inset(30)
        }
        
        offerCollection.snp.makeConstraints { make in
            make.top.equalTo(titleLable.snp.bottom).offset(20)
            make.bottom.equalTo(chooseButton.snp.top).inset(10)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
        
        chooseButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(25)
            make.trailing.equalToSuperview().inset(20)
            make.leading.equalToSuperview().offset(20)
            make.height.equalTo(50)
        }
        
        closeButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(100)
            make.leading.equalToSuperview().offset(20)
        }
    }
    
    func reloadData() {
        offerCollection.reloadData()
    }
}

extension UpgradeListViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let count = presenter?.list.count else { return 0 }
        return count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: UpgradeListCell.reuseID,
            for: indexPath
        ) as! UpgradeListCell
        guard let presenter = presenter else { return cell }
        
        cell.configUI()
        cell.config(model: presenter.builderForCell(list: presenter.list[indexPath.row]))
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? UpgradeListCell else { return }
        if !cell.isHidden() {
            cell.cellSelected(bool: true)
            message = "Без изменений"
            chooseButton.setTitle(presenter?.response?.result.actionTitle, for: .normal)
        } else {
            cell.cellSelected(bool: false)
            message = presenter?.list[indexPath.row].title ?? ""
            chooseButton.setTitle(presenter?.response?.result.selectedActionTitle, for: .normal)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? UpgradeListCell else { return }
        cell.cellSelected(bool: true)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        coordinator.animate(alongsideTransition: { context in
            self.offerCollection.collectionViewLayout.invalidateLayout()
        }, completion: nil)
    }
}

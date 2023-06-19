//
//  UICollectionViewCell.swift
//  TestovoeAvito
//
//  Created by Oleg on 14.06.2023.
//

import Foundation
import UIKit
import SnapKit

class UpgradeListCell: UICollectionViewCell {
    static var reuseID = "UpgradeListCell"
    
    private lazy var upgradeName: UILabel = {
        let label = UILabel()
        label.text = "XL-объявление"
        label.font = UIFont.boldSystemFont(ofSize: 30)
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Пользователи смогут посмотреть фотографии, описание и телефон прямо из результатов поиска."
        label.font = UIFont.systemFont(ofSize: 19)
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.text = "356 ₽"
        label.font = UIFont.boldSystemFont(ofSize: 30)
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var icon: CustomImageView = {
        let image = CustomImageView()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.layer.cornerRadius = image.frame.width / 2
        return image
    }()
    
    private lazy var chooseImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "check")
        image.isHidden = true
        return image
    }()
    
    func configUI() {
        contentView.addSubview(chooseImage)
        contentView.addSubview(icon)
        contentView.addSubview(priceLabel)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(upgradeName)
        contentView.backgroundColor = UIColor(red: 0.97, green: 0.97, blue: 0.97, alpha: 1.00)
        contentView.layer.cornerRadius = 8
        
        setupConstraints()
    }
    
    func config(model: UpgradeListModel) {
        upgradeName.text = model.upgradeName
        descriptionLabel.text = model.description
        priceLabel.text = model.price
        icon.load(urlString: model.icon)
    }
    
    func isHidden() -> Bool {
        return chooseImage.isHidden
    }
    
    func cellSelected(bool: Bool) {
        if bool == true {
            chooseImage.isHidden = true
        } else {
            chooseImage.isHidden = false
        }
    }
    
    private func setupConstraints() {
        upgradeName.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.leading.equalTo(icon.snp.trailing).offset(15)
        }
        icon.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.leading.equalToSuperview().offset(20)
            make.height.equalTo(50)
            make.width.equalTo(50)
        }
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(upgradeName.snp.bottom).offset(10)
            make.leading.equalTo(icon.snp.trailing).offset(15)
            make.trailing.equalToSuperview().inset(50)
        }
        priceLabel.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(10)
            make.leading.equalTo(icon.snp.trailing).offset(15)
            make.bottom.equalToSuperview().inset(20)
        }
        
        chooseImage.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(35)
            make.trailing.equalToSuperview().inset(15)
        }
    }
}

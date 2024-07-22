//
//  WeatherCell.swift
//  WeatherApp
//
//  Created by Anastasia on 16.07.2024.
//

import Foundation
import UIKit

final class WeatherCell: UICollectionViewCell {
    
    static let identifier = "WeatherCell"
    
    private let icon = UIImageView()
    private let title = UILabel()
    
    override var isSelected: Bool {
        didSet {
            icon.tintColor = isSelected ? .red : .black
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupCell(weatherItem: WeatherItem) {
        icon.image = UIImage(systemName: weatherItem.imageName)
        title.text = weatherItem.title
    }
    
    private func setupUI() {
        self.clipsToBounds = true
        icon.tintColor = .black
        
        title.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        title.textColor = .black
    }
    
    private func setupConstraints() {
        addSubview(icon)
        addSubview(title)

        icon.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            icon.topAnchor.constraint(equalTo: self.topAnchor, constant: 20),
            icon.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20),
            icon.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            icon.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20)
        ])
        
        title.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            title.topAnchor.constraint(equalTo: icon.bottomAnchor),
            title.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
    }
    
}

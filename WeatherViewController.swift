//
//  ViewController.swift
//  WeatherApp
//
//  Created by Anastasia on 16.07.2024.
//

import UIKit
import AVFoundation

final class WeatherViewController: UIViewController {
    
    private let headerBackgroundView = UIView()
    private let videoPlayer = VideoPlayerView()
    private lazy var collectionWeather = createCollectionView()
    
    private let service = WeatherService()
    private var weatherItems: [WeatherItem] = []
    
    private var isPlayerLaunched = false
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if !isPlayerLaunched {
            let randomIndex = Int.random(in: weatherItems.indices)
            guard let random = weatherItems[safe: randomIndex] else { return }
            
            videoPlayer.playVideo(videoURL: random.videoURL)
            collectionWeather.selectItem(
                at: IndexPath(row: randomIndex, section: 0),
                animated: true,
                scrollPosition: .centeredHorizontally
            )
            
            isPlayerLaunched = true
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        weatherItems = service.fetchItems()
        setupUI()
        setupConstraints()
    }
    
    private func setupUI() {
        headerBackgroundView.backgroundColor = .white
        headerBackgroundView.alpha = 0.8
        
        collectionWeather.showsHorizontalScrollIndicator = false
        collectionWeather.register(WeatherCell.self, forCellWithReuseIdentifier: WeatherCell.identifier)
        collectionWeather.dataSource = self
        collectionWeather.delegate = self
        collectionWeather.backgroundColor = .clear
    }
    
    private func setupConstraints() {
        view.addSubview(videoPlayer)
        view.addSubview(headerBackgroundView)
        headerBackgroundView.addSubview(collectionWeather)
        
        videoPlayer.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            videoPlayer.topAnchor.constraint(equalTo: view.topAnchor),
            videoPlayer.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            videoPlayer.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            videoPlayer.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        ])
        
        headerBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            headerBackgroundView.topAnchor.constraint(equalTo: view.topAnchor),
            headerBackgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerBackgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerBackgroundView.heightAnchor.constraint(equalToConstant: 160)
        ])
        
        collectionWeather.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionWeather.bottomAnchor.constraint(equalTo: headerBackgroundView.bottomAnchor),
            collectionWeather.leadingAnchor.constraint(equalTo: headerBackgroundView.leadingAnchor),
            collectionWeather.trailingAnchor.constraint(equalTo: headerBackgroundView.trailingAnchor),
            collectionWeather.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    private func createCollectionView() -> UICollectionView {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = .init(width: 100, height: 100)
        
        return UICollectionView(frame: .zero, collectionViewLayout: layout)
    }
}

extension WeatherViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let url = weatherItems[safe: indexPath.row]?.videoURL {
            videoPlayer.playVideo(videoURL: url)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       weatherItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionWeather.dequeueReusableCell(withReuseIdentifier: WeatherCell.identifier, for: indexPath)
        guard let cell = cell as? WeatherCell else { return UICollectionViewCell() }
        
        if let item = weatherItems[safe: indexPath.row] {
            cell.setupCell(weatherItem: item)
        }
        
        return cell
    }
}


extension Collection {
    subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}

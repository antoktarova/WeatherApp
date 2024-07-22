//
//  Service.swift
//  WeatherApp
//
//  Created by Anastasia on 16.07.2024.
//

import Foundation

final class WeatherService {
    
    private let bundle = Bundle.main
    
    func fetchItems() -> [WeatherItem] {
        return [
            WeatherItem(
                id: 1,
                title: Strings.weatherSun,
                imageName: "sun.and.horizon.circle.fill",
                videoURL: bundle.url(forResource: "sunny", withExtension: "mp4")!
            ),
            WeatherItem(
                id: 2,
                title: Strings.weatherRain,
                imageName: "cloud.rain.circle.fill",
                videoURL: bundle.url(forResource: "rainy", withExtension: "mp4")!
            ),
            WeatherItem(
                id: 3,
                title: Strings.weatherFog,
                imageName: "cloud.fog.circle.fill",
                videoURL: bundle.url(forResource: "foggy", withExtension: "mp4")!
            ),
            WeatherItem(
                id: 4,
                title: Strings.weatherCloud,
                imageName: "cloud.circle.fill",
                videoURL: bundle.url(forResource: "cloudy", withExtension: "mp4")!
            ),
            WeatherItem(
                id: 5,
                title: Strings.weatherThunder,
                imageName: "cloud.bolt.rain.circle.fill",
                videoURL: bundle.url(forResource: "thunderstorm", withExtension: "mp4")!
            ),
            WeatherItem(
                id: 6,
                title: Strings.weatherSnow,
                imageName: "snowflake.circle.fill",
                videoURL: bundle.url(forResource: "snowy", withExtension: "mp4")!
            ),
            WeatherItem(
                id: 7,
                title: Strings.weatherWind,
                imageName: "wind.circle.fill",
                videoURL: bundle.url(forResource: "windy", withExtension: "mp4")!
            )
        ]
    }
}

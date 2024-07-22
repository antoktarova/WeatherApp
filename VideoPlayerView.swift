//
//  PlayerView.swift
//  WeatherApp
//
//  Created by Anastasia on 22.07.2024.
//

import Foundation
import UIKit
import AVFoundation

final class VideoPlayerView: UIView, CAAnimationDelegate {
    
    private var currentPlayerLayer: AVPlayerLayer?
    private var currentQueuePlayer: AVQueuePlayer?
    private var currentPlaybackLooper: AVPlayerLooper?
    
    private var animationFinished: (() -> ())?
    
    func playVideo(videoURL: URL) {
        guard currentPlayerLayer != nil else {
            setupAndPlay(with: videoURL)
            return
        }
        
        animationFinished = { [weak self] in
            guard let self else { return }
            self.setupAndPlay(with: videoURL)
            self.currentPlayerLayer?.showWithAnimation()
        }
        
        currentPlayerLayer?.hideWithAnimation(delegate: self)
        return
    }
    
    private func setupAndPlay(with url: URL) {
        if let currentPlayerLayer {
            currentPlayerLayer.removeFromSuperlayer()
        }
                
        let item = AVPlayerItem(url: url)
        let queuePlayer = AVQueuePlayer(playerItem: item)
        let playerLayer = AVPlayerLayer(player: queuePlayer)
        let playbackLooper = AVPlayerLooper(player: queuePlayer, templateItem: item)
        
        playerLayer.frame = bounds
        playerLayer.videoGravity = .resizeAspectFill
        
        layer.addSublayer(playerLayer)
        queuePlayer.play()
        
        self.currentPlayerLayer = playerLayer
        self.currentQueuePlayer = queuePlayer
        self.currentPlaybackLooper = playbackLooper
    }
}

extension VideoPlayerView {
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        animationFinished?()
    }
}

private extension CALayer {
    func hideWithAnimation(delegate: CAAnimationDelegate) {
        let animation = CABasicAnimation(keyPath: #keyPath(CALayer.opacity))
        animation.delegate = delegate
        animation.fromValue = 1.0
        animation.toValue = 0.0
        animation.duration = 0.5
        animation.timingFunction = CAMediaTimingFunction(name: .linear)
        self.opacity = 0
        self.add(animation, forKey: "hide")
    }
    
    func showWithAnimation() {
        let animation = CABasicAnimation(keyPath: #keyPath(CALayer.opacity))
        animation.fromValue = 0
        animation.toValue = 1.0
        animation.duration = 0.5
        animation.timingFunction = CAMediaTimingFunction(name: .linear)
        self.opacity = 1
        self.add(animation, forKey: "show")
    }
}

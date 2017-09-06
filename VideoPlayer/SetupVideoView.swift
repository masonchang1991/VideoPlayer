//
//  SetupVideoView.swift
//  VideoPlayer
//
//  Created by Ｍason Chang on 2017/9/6.
//  Copyright © 2017年 Ｍason Chang iOS#4. All rights reserved.
//

import Foundation
import UIKit

extension VideoViewController {
    
    func setupSearchBarView() {
        
        self.searchBarView.addSubview(self.searchController.searchBar)
        self.view.addSubview(searchBarView)
        
        searchBarView.backgroundColor = UIColor.brown
        searchBarView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: UIApplication.shared.statusBarFrame.size.height).isActive = true
        searchBarView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0).isActive = true
        searchBarView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0).isActive = true
        searchBarView.heightAnchor.constraint(equalToConstant: self.searchController.searchBar.frame.height).isActive = true
        searchBarView.translatesAutoresizingMaskIntoConstraints = false
        
    }
    
    func setupPlayerView() {
        
        self.view.addSubview(playerView)
        self.playerView.topAnchor.constraint(equalTo: self.searchBarView.bottomAnchor, constant: 0).isActive = true
        self.playerView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0).isActive = true
        self.playerView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0).isActive = true
        self.playerView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -44.0).isActive = true
        self.playerView.translatesAutoresizingMaskIntoConstraints = false
        
        
    }
   
    func setupVideoButton() {
        
        self.view.addSubview(playButton)
        self.view.addSubview(muteButton)
        
        self.playButton.topAnchor.constraint(equalTo: self.playerView.bottomAnchor, constant: 0).isActive = true
        self.playButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0).isActive = true
        self.playButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0).isActive = true
        self.playButton.widthAnchor.constraint(equalToConstant: self.view.frame.width / 6).isActive = true
        self.playButton.translatesAutoresizingMaskIntoConstraints = false
        self.playButton.setTitle("Play", for: .normal)
        self.playButton.setTitleColor(UIColor.white, for: .normal)
        self.playButton.addTarget(self, action: #selector(playVideo), for: .touchUpInside)
        
        self.muteButton.topAnchor.constraint(equalTo: self.playerView.bottomAnchor, constant: 0).isActive = true
        self.muteButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0).isActive = true
        self.muteButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0).isActive = true
        self.muteButton.widthAnchor.constraint(equalToConstant: self.view.frame.width / 6).isActive = true
        self.muteButton.translatesAutoresizingMaskIntoConstraints = false
        self.muteButton.setTitle("Mute", for: .normal)
        self.muteButton.setTitleColor(UIColor.white, for: .normal)
        self.muteButton.addTarget(self, action: #selector(muteVideo), for: .touchUpInside)
        
    }
    
    func setupPlayerLayer() {
        
        self.playerView.layer.addSublayer(playerLayer)
        self.playerLayer.frame = self.playerView.bounds
        self.playerLayer.backgroundColor = UIColor.blue.cgColor
        
    }
    
    
}

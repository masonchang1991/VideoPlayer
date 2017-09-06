//
//  ViewController.swift
//  VideoPlayer
//
//  Created by Ｍason Chang on 2017/9/6.
//  Copyright © 2017年 Ｍason Chang iOS#4. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

class VideoViewController: UIViewController {

    
    let searchController = UISearchController(searchResultsController: nil)
    let searchBarView = UIView()
    
    let playerView = UIView()
    var playerLayer:AVPlayerLayer = AVPlayerLayer(player: nil)
    var player = AVPlayer()
    
    var AVisMuted = false
    var AVisStopped = false
    
    
    let client = URLVideoAPIClient()
    var manager: URLVideoAPIManager!
    
    var playButton = UIButton()
    
    var muteButton = UIButton()
    
    
    
    var searchURLText = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        
        
        
        manager = URLVideoAPIManager(client: client)

        self.searchController.searchBar.delegate = self
        
        setupSearchBarView()
        setupPlayerView()
        setupVideoButton()

    }
    
    override func viewDidLayoutSubviews() {
        
        setupPlayerLayer()
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        
        return .lightContent
        
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        if keyPath == "status" {
            
            if player.rate == 0.0 {
                
                print("Pause")
                
            } else if player.rate == 1.0 {
                
                print("Play")
                
            } else {
                
                print("Unknown")
                
            }
            
        }
        
    }
    
    deinit {
        
        self.player.removeObserver(self, forKeyPath: "status")
        
    }
    
    
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
    
    func setupPlayerLayer() {
        
        self.playerView.layer.addSublayer(playerLayer)
        self.playerLayer.frame = self.playerView.bounds
        self.playerLayer.backgroundColor = UIColor.blue.cgColor
        
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
        
        
        self.muteButton.topAnchor.constraint(equalTo: self.playerView.bottomAnchor, constant: 0).isActive = true
        self.muteButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0).isActive = true
        self.muteButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0).isActive = true
        self.muteButton.widthAnchor.constraint(equalToConstant: self.view.frame.width / 6).isActive = true
        self.muteButton.translatesAutoresizingMaskIntoConstraints = false
        self.muteButton.setTitle("Mute", for: .normal)
        self.muteButton.setTitleColor(UIColor.white, for: .normal)
        
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

extension VideoViewController: UISearchBarDelegate {
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {

        // MARK: Call URLVideoManger
        
        let videoURL =  URL(string: self.searchURLText)!
        self.player = AVPlayer(url: videoURL)
        self.playerLayer.player = player
        
        player.addObserver(self, forKeyPath: "status", options: .new, context: nil)
        player.play()
        
        setupPlayerLayer()
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        self.searchURLText = searchText
        
    }
    
    
}


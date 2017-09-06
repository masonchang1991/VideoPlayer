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
    var player: AVPlayer?
    var playerItem: AVPlayerItem?
    
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
        
        addObserver()

    }
    
    override func viewDidLayoutSubviews() {
        
        setupPlayerLayer()
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        
        return .lightContent
        
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        if keyPath == "rate" {
            
            if player?.rate == 0.0 {
                
                self.AVisStopped = true
                
                print("Pause")
                
            } else if player?.rate == 1.0 {
                
                self.AVisStopped = false
                
                print("Play")
                
            } else {
                
                print("Unknown")
                
            }
            
        } else if keyPath == "status" {
            
            if player?.status == .readyToPlay {
                
                player?.play()
                
            } else if player?.status == .failed {
                
                // Todo: Alert
                
            }
            
            
        }
        
    }
   
    func addObserver() {
        
        self.player?.addObserver(self, forKeyPath: "rate", options: .new, context: nil)
        
        self.player?.addObserver(self, forKeyPath: "status", options: .new, context: nil)
        
        
    }
    
    func removeObserver() {
        
        self.player?.removeObserver(self, forKeyPath: "rate")
        
        self.player?.removeObserver(self, forKeyPath: "status")
        
        
    }
    
    
     
    func playVideo() {
        
        if AVisStopped {
            
            self.player?.play()
            self.playButton.setTitle("Pause", for: .normal)
            
        } else {
            
            self.player?.pause()
            self.playButton.setTitle("Play", for: .normal)
        }
        
    }
    
    func muteVideo() {
        
        if AVisMuted {
            
            self.player?.isMuted = false
            self.muteButton.setTitle("Unmute", for: .normal)
            
        } else {
            
            self.player?.isMuted = true
            self.muteButton.setTitle("Mute", for: .normal)
        }
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func addPlayer(videoURL: URL) {
        
        self.player = AVPlayer(url: videoURL)
        self.playerLayer.player = player
//        player?.play()
        
        self.addObserver()
        
        
    }
    


}

extension VideoViewController: UISearchBarDelegate {
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {

        // MARK: Call URLVideoManger
        
        let videoURL =  URL(string: self.searchURLText)!
        
        addPlayer(videoURL: videoURL)
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        self.searchURLText = searchText

        removeObserver()
        
        
    }
    
    
}


//
//  URLVideoAPIManager.swift
//  VideoPlayer
//
//  Created by Ｍason Chang on 2017/9/6.
//  Copyright © 2017年 Ｍason Chang iOS#4. All rights reserved.
//

import Foundation
import AVKit
import AVFoundation

class URLVideoAPIManager: URLVideoManager {
    
    
    weak var delegate: URLVideoManagerDelegate?
    
    var client: URLVideoAPIClient
    
    init(client: URLVideoAPIClient) {
        
        self.client = client
        
    }
    
    
    func checkURLIsRight(searchText: String) -> Bool {
        
        let videoURL =  URL(fileURLWithPath: searchText)
        let player = AVPlayer(url: videoURL)
        
        
        if player.error == nil {
            
            return false
            
        } else {
            
            return true
            
        }
        
        
    }
    
    
    
    
}

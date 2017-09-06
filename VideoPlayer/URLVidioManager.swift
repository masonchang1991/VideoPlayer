//
//  URLVidioManager.swift
//  VideoPlayer
//
//  Created by Ｍason Chang on 2017/9/6.
//  Copyright © 2017年 Ｍason Chang iOS#4. All rights reserved.
//

import Foundation

protocol URLVideoManagerDelegate: class {
    
    func isRightURL()
    
    func isWrongURL(_ error: Error)
    
    
    
}



protocol URLVideoManager {
    
    weak var delegate: URLVideoManagerDelegate? { get set }
    
    var client: URLVideoAPIClient { get set }
    
    
    
    
}

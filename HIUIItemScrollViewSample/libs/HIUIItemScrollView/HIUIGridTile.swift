//
//  HIUIGridTile.swift
//  HIUIItemScrollView
//
//  Created by Sunhong Kim on 2016. 6. 20..
//  Copyright © 2016년 Sunhong Kim. All rights reserved.
//

import UIKit

@objc public protocol HIUIGridTile: NSObjectProtocol {
    
    optional func initiateTile()
    static func reuseIdentifier() -> String
    
}

//
//  HIUIItemScrollViewDelegate.swift
//  HIUIItemScrollView
//
//  Created by Sunhong Kim on 2016. 6. 20..
//  Copyright © 2016년 Sunhong Kim. All rights reserved.
//

import UIKit

@objc public protocol HIUIItemScrollViewDelegate: NSObjectProtocol {
    
    optional func itemScrollView(scrollView: HIUIItemScrollView, didSelectItemAtIndex index: Int)
    
}

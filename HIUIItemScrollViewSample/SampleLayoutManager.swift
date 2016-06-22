//
//  SampleLayoutManager.swift
//  HIUIItemScrollViewSample
//
//  Created by Sunhong Kim on 2016. 6. 23..
//  Copyright © 2016년 Sunhong Kim. All rights reserved.
//

import UIKit

class SampleLayoutManager: NSObject, HIUIGridLayoutManager {
    
    func direction() -> HIUIGridLibraryDirection {
        return .Horizontal
    }
    
    func tileSize() -> CGSize {
        return CGSizeMake(CGRectGetWidth(UIScreen.mainScreen().bounds) - 80, CGRectGetHeight(UIScreen.mainScreen().bounds) - 60)
    }
    
    func itemMargin() -> CGSize {
        return CGSizeZero
    }
    
    func itemPadding() -> CGSize {
        return CGSizeMake(20, 0)
    }
}

//
//  HIUIItemScrollViewDataSource.swift
//  HIUIItemScrollView
//
//  Created by Sunhong Kim on 2016. 6. 20..
//  Copyright © 2016년 Sunhong Kim. All rights reserved.
//

import UIKit

public protocol HIUIItemScrollViewDataSource: NSObjectProtocol {
    
    func numberOfItemsInItemScrollView(scrollView: HIUIItemScrollView) -> Int
    func itemScrollView(scrollView: HIUIItemScrollView, tileForIndex index: NSInteger) -> HIUIGridTile
    
}

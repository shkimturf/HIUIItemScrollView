//
//  HIUIGridLayoutManager.swift
//  HIUIItemScrollView
//
//  Created by Sunhong Kim on 2016. 6. 20..
//  Copyright © 2016년 Sunhong Kim. All rights reserved.
//

import UIKit

public enum HIUIGridLibraryDirection : Int {
    case Vertical, Horizontal
}

public protocol HIUIGridLayoutManager: NSObjectProtocol {

    func direction() -> HIUIGridLibraryDirection
    
    // | margin | padding | tileSize | padding | tileSize | ... | padding | margin |
    func tileSize() -> CGSize
    func itemMargin() -> CGSize
    func itemPadding() -> CGSize
    
}

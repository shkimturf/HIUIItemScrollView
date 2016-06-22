//
//  SampleTile.swift
//  HIUIItemScrollViewSample
//
//  Created by Sunhong Kim on 2016. 6. 23..
//  Copyright © 2016년 Sunhong Kim. All rights reserved.
//

import UIKit

public class SampleTile: UIView, HIUIGridTile {
    
    public var label : UILabel? = nil
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.layer.borderColor = UIColor.darkGrayColor().CGColor
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 8
        self.clipsToBounds = true
        
        self.label = UILabel(frame: self.bounds)
        self.label?.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
        self.label?.textAlignment = .Center
        self.label?.font = UIFont.boldSystemFontOfSize(20)
        self.addSubview(self.label!)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("Not implemented")
    }
    
    public static func reuseIdentifier() -> String {
        return String(SampleTile)
    }
    
}

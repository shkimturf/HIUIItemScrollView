//
//  ViewController.swift
//  HIUIItemScrollViewSample
//
//  Created by Sunhong Kim on 2016. 6. 23..
//  Copyright © 2016년 Sunhong Kim. All rights reserved.
//

import UIKit

class ViewController: UIViewController, HIUIItemScrollViewDataSource, HIUIItemScrollViewDelegate {
    
    var scrollView : HIUIItemScrollView?
    override func loadView() {
        super.loadView()
        
        scrollView = HIUIItemScrollView(frame: CGRectMake(20, CGRectGetMaxY(UIApplication.sharedApplication().statusBarFrame) + 20, CGRectGetWidth(self.view.bounds) - 60, CGRectGetHeight(self.view.bounds) - 60))
        scrollView?.layoutManager = SampleLayoutManager()
        scrollView?.drawingPadding = CGSizeMake(40, 0)
        scrollView?.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
        scrollView?.dataSource = self
        scrollView?.delegate = self
        scrollView?.scrollView.clipsToBounds = false
        scrollView?.scrollView.pagingEnabled = true
        self.view.addSubview(scrollView!)
    }
    
//    MARK: HIUIItemScrollView dataSource
    func numberOfItemsInItemScrollView(scrollView: HIUIItemScrollView) -> Int {
        return 5
    }
    
    func itemScrollView(scrollView: HIUIItemScrollView, tileForIndex index: NSInteger) -> HIUIGridTile {
        var tile : SampleTile? = scrollView.dequeueReusableTileWithIdentifier(SampleTile.reuseIdentifier()) as? SampleTile
        if ( nil == tile ) {
            tile = SampleTile(frame: CGRectZero)
        }
        
        tile!.label?.text = String(index)
        
        return tile!
    }

//    MARK: HIUIItemScrollView delegate
    func itemScrollView(scrollView: HIUIItemScrollView, didSelectItemAtIndex index: Int) {
        
    }
}


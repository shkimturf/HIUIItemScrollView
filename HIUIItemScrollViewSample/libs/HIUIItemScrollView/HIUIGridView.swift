//
//  HIUIGridView.swift
//  HIUIItemScrollView
//
//  Created by Sunhong Kim on 2016. 6. 20..
//  Copyright © 2016년 Sunhong Kim. All rights reserved.
//

import UIKit

public class HIUIGridView: UIView, UIScrollViewDelegate {

//    MARK: consts
    static let unKnownItemTag = -1
    static let defaultSection = 0
    static let reuseQueueCapSize = 10
    
//    MARK: properties
    lazy public private(set) var scrollView : UIScrollView = {
        let scrollView = UIScrollView(frame: self.bounds)
        scrollView.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
        scrollView.delegate = self
        return scrollView
    }()
    
    internal var itemData : Array<HIUIGridItem> = Array<HIUIGridItem>()
    internal var reuseQueue : Dictionary<String, Array<HIUIGridTile>> = Dictionary<String, Array<HIUIGridTile>>()
    internal let reuseQueueCap : Int = HIUIGridView.reuseQueueCapSize
    
    private var shouldConstructItemViews : Bool = false
    private var _layoutManager : HIUIGridLayoutManager?
    public var layoutManager : HIUIGridLayoutManager? {
        get {
            return self._layoutManager
        } set {
            self._layoutManager = newValue
            self.reloadData()
        }
    }
    public var drawingPadding : CGSize = CGSizeZero
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        self.setup()
    }
    
//    MARK: usage
    public func reloadData() {
        self.shouldConstructItemViews = true
        self.setNeedsLayout()
    }
    
    public func reloadItemAtIndexPath(indexPath: NSIndexPath) {
        self.loadItemAtIndexPath(indexPath, reload: true)
    }
    
    public func dequeueReusableTileWithIdentifier(identifier: String) -> HIUIGridTile? {
        var stack : Array<HIUIGridTile>? = self.reuseQueue[identifier]
        if ( nil != stack ) {
            let tile : HIUIGridTile? = stack!.popLast()
            if ( nil != tile ) {
                return tile
            }
        }
        
        return nil
    }
    
//    MARK: layout
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        if ( !self.shouldConstructItemViews ) {
            return
        }
        
        self.relayoutItems()
        self.loadVisibleItems(true)
        
        self.shouldConstructItemViews = false
    }
    
    internal func relayoutItems() {
        for i : Int in 0 ..< self.itemData.count {
            let item : HIUIGridItem = self.itemData[i]
            self.enqueueReusableTile(item.tile)
        }
        
        self.itemData.removeAll()
        
        // relayouts
        // scrollview contentsize
    }
    
//    MARK: UIScrollView delegate
    public func scrollViewDidScroll(scrollView: UIScrollView) {
        self.loadVisibleItems(false)
    }
    
//    MARK: internal functions
    internal func enqueueReusableTile(tile: HIUIGridTile?) {
        if ( nil == tile ) {
            return
        }
        
        if let view : UIView = tile as? UIView {
            view.removeFromSuperview()
            view.tag = HIUIGridView.unKnownItemTag
        }
        
        if ( tile!.respondsToSelector(#selector(HIUIGridTile.initiateTile)) ) {
            tile!.initiateTile!()
        }
        
        var stack : Array<HIUIGridTile>? = self.reuseQueue[tile!.dynamicType.reuseIdentifier()]
        if ( nil == stack ) {
            stack = Array<HIUIGridTile>()
            self.reuseQueue[tile!.dynamicType.reuseIdentifier()] = stack
        }
        
        if ( stack!.count < self.reuseQueueCap ) {
            stack?.append(tile!)
        }
    }
    
    internal func loadItemAtIndexPath(indexPath: NSIndexPath) {
        self.loadItemAtIndexPath(indexPath, reload: false)
    }
    
    internal func loadItemAtIndexPath(indexPath: NSIndexPath, reload: Bool) {
        fatalError("Should override this function.")
    }
    
    internal func tileFrameAtIndexPath(indexPath: NSIndexPath) -> CGRect {
        fatalError("Should override this function.")
    }
    
    internal func layoutItemAtIndexPath(indexPath: NSIndexPath) {
        fatalError("Should override this function.")
    }
    
    internal func loadVisibleItems(reload: Bool) {
        let visibleBounds = CGRectMake(self.scrollView.contentOffset.x - self.drawingPadding.width, self.scrollView.contentOffset.y - self.drawingPadding.height, CGRectGetWidth(self.scrollView.bounds) + self.drawingPadding.width * 2, CGRectGetHeight(self.scrollView.bounds) + self.drawingPadding.height * 2)
        
        for i : Int in 0 ..< self.itemData.count {
            let item : HIUIGridItem = self.itemData[i]
            if ( CGRectContainsRect(visibleBounds, item.frame) || CGRectIntersectsRect(visibleBounds, item.frame) ) {
                self.loadItemAtIndexPath(NSIndexPath(forRow: i, inSection: HIUIGridView.defaultSection))
            } else {
                self.enqueueReusableTile(item.tile)
                item.tile = nil
            }
        }
    }
    
    internal func indexPathAtPoint(point: CGPoint) -> NSIndexPath? {
        var indexPath : NSIndexPath? = nil
        for i : Int in 0 ..< self.itemData.count {
            let item : HIUIGridItem = self.itemData[i]
            if ( CGRectContainsPoint(item.frame, point) ) {
                indexPath = NSIndexPath(forRow: i, inSection: HIUIGridView.defaultSection)
                break
            }
        }
        
        return indexPath
    }

    internal func setup() {
        self.addSubview(self.scrollView)
    }
}

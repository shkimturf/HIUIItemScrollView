//
//  HIUIItemScrollView.swift
//  HIUIItemScrollView
//
//  Created by Sunhong Kim on 2016. 6. 20..
//  Copyright © 2016년 Sunhong Kim. All rights reserved.
//

import UIKit

public class HIUIItemScrollView: HIUIGridView, UIGestureRecognizerDelegate {
    
//    MARK: properties
    public weak var delegate : HIUIItemScrollViewDelegate?
    public weak var dataSource : HIUIItemScrollViewDataSource?
    
//    MARK: initializer
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
    
//    MARK: layouts
    internal override func relayoutItems() {
        super.relayoutItems()
        
        if ( nil == self.layoutManager ) {
            return
        }
        
        if ( nil == self.dataSource ) {
            return
        }
        
        // relayouts
        let numberOfItems = self.dataSource!.numberOfItemsInItemScrollView(self)
        for i : Int in 0 ..< numberOfItems {
            let item : HIUIGridItem = HIUIGridItem()
            item.frame = self.tileFrameAtIndexPath(NSIndexPath(forRow: i, inSection: HIUIGridView.defaultSection))
            self.itemData.append(item)
        }
        
        // scrollview content size
        switch self.layoutManager!.direction() {
        case .Vertical:
            let contentLength : CGFloat = (2 * self.layoutManager!.itemMargin().height) + self.layoutManager!.itemPadding().height + (self.layoutManager!.tileSize().height + self.layoutManager!.itemPadding().height) * CGFloat(numberOfItems)
            
            self.scrollView.contentSize = CGSizeMake(CGRectGetWidth(self.scrollView.bounds), contentLength)
            break
        case .Horizontal:
            let contentLength : CGFloat = (2 * self.layoutManager!.itemMargin().width) + self.layoutManager!.itemPadding().width + (self.layoutManager!.tileSize().width + self.layoutManager!.itemPadding().width) * CGFloat(numberOfItems)
            
            self.scrollView.contentSize = CGSizeMake(contentLength, CGRectGetHeight(self.scrollView.bounds))
            break
        }
    }
    
//    MARK: internal functions
    internal override func loadItemAtIndexPath(indexPath: NSIndexPath, reload: Bool) {
        assert(nil != self.dataSource, "Should set dataSource.")
        
        let item : HIUIGridItem = self.itemData[indexPath.row]
        if ( reload ) {
            self.enqueueReusableTile(item.tile)
            item.tile = nil
        }
        
        if ( nil == item.tile ) {
            item.tile = self.dataSource!.itemScrollView(self, tileForIndex: indexPath.row)
        }
        
        if let view : UIView = item.tile as? UIView {
            view.tag = indexPath.row
            view.frame = item.frame
            self.scrollView.addSubview(view)
        }
    }
    
    internal override func tileFrameAtIndexPath(indexPath: NSIndexPath) -> CGRect {
        if ( nil == self.layoutManager ) {
            return CGRectZero
        }
        
        switch ( self.layoutManager!.direction() ) {
        case .Vertical:
            return CGRectMake(self.layoutManager!.itemMargin().width + self.layoutManager!.itemPadding().width, self.layoutManager!.itemMargin().height + self.layoutManager!.itemPadding().height + (self.layoutManager!.tileSize().height + self.layoutManager!.itemPadding().height) * CGFloat(indexPath.row), self.layoutManager!.tileSize().width, self.layoutManager!.tileSize().height)
        case .Horizontal:
            return CGRectMake(self.layoutManager!.itemMargin().width + self.layoutManager!.itemPadding().width + (self.layoutManager!.tileSize().width + self.layoutManager!.itemPadding().width) * CGFloat(indexPath.row), self.layoutManager!.itemMargin().height + self.layoutManager!.itemPadding().height, self.layoutManager!.tileSize().width, self.layoutManager!.tileSize().height)
        }
    }
    
//    MARK: user interactions
    @objc private func onTappedInView(rec: UIGestureRecognizer) {
        
        switch ( rec.state ) {
        case .Recognized:
            let indexPath : NSIndexPath? = self.indexPathAtPoint(rec.locationInView(self.scrollView))
            if ( nil != indexPath && nil != self.delegate ) {
                if ( self.delegate!.respondsToSelector(#selector(HIUIItemScrollViewDelegate.itemScrollView(_:didSelectItemAtIndex:))) ) {
                    self.delegate!.itemScrollView!(self, didSelectItemAtIndex: indexPath!.row)
                }
            }
        default:
            break
        }
    }
    
    internal override func setup() {
        super.setup()
        let rec : UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(HIUIItemScrollView.onTappedInView))
        rec.delegate = self
        self.addGestureRecognizer(rec)
    }
    
//    MARK: UITapGestureRecognizer delegate
    public func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldReceiveTouch touch: UITouch) -> Bool {
        if ( touch.view is UIButton ) {
            return false
        }
        
        return true
    }
    
    public func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWithGestureRecognizer otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
}

# HIUIItemScrollView

Basic item scroll view supports horizontal and vertical directions

## Screenshot

<img src="https://github.com/shkimturf/HIUIItemScrollView/blob/master/preview_top.gif" width="250" />

## Environments

over iOS 7.0 / Swift 2.x

## Usage

### Setup

Just import **HIUIItemScrollView** source files to your project.

### HIUIScrollView

* HIUIItemScrollView supports to reuse HIUIGridTile. If one of HIUIGridTile scrolls to over displaying screen, it will remove.
* **drawingPadding** means calculated display padding over the view. It uses when reuse HIUIGridTile.

``` objc
    var tile : SampleTile? = scrollView.dequeueReusableTileWithIdentifier(SampleTile.reuseIdentifier()) as? SampleTile
    if ( nil == tile ) {
        tile = SampleTile(frame: CGRectZero)
    }
```

### Layout Manager

* Define direction to scroll.
* Define size to display items
* | margin | padding | tileSize | padding | tileSize | ... | padding | margin |

``` objc
    CGSize cellSize;
    CGSize tileSize;
    NSUInteger initialPanelLevel;
```

### DataSource

It likes **UITableViewDataSource**.
* Tile should conform HIUIGridTile protocol. 

``` swift
    func numberOfItemsInItemScrollView(scrollView: HIUIItemScrollView) -> Int
    func itemScrollView(scrollView: HIUIItemScrollView, tileForIndex index: NSInteger) -> HIUIGridTile
```

### Delegate

Supports delegate function.

``` swift
    optional func itemScrollView(scrollView: HIUIItemScrollView, didSelectItemAtIndex index: Int)
```

## Sample source

**HIUIItemScrollView** implements explained above and shows how to use this library.

## Author

[shkimturf](https://github.com/shkimturf)

## License

HIUIItemScrollView is under MIT License.
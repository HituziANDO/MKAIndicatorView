MKAIndicatorView
===

***MKAIndicatorView makes you to create the powerful indicator view easily.***

## Include in your iOS app

### CocoaPods

MKAIndicatorView is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "MKAIndicatorView"
```

### Manual Installation

1. Download latest [MKAIndicatorView](https://github.com/HituziANDO/MKAIndicatorView/releases)
1. Drag & Drop MKAIndicatorView.framework into your Xcode project


## Usage

1. Import the module
	
	**Objective-C**
	
	```objc
	#import <MKAIndicatorView/MKAIndicatorView.h>
	```

	**Swift**
	
	```swift
	import MKAIndicatorView
	```

2. Show the indicator
	
	**Objective-C**
	
	```objc
	[[MKAIndicator defaultIndicator] showInView:self.view 
                              withTouchDisabled:NO];
	```
	
	**Swift**
	
	```swift
	MKAIndicator.default().show(in: self.view, withTouchDisabled: false)
	```

3. Hide the indicator
	
	**Objective-C**
	
	```objc
	[[MKAIndicator defaultIndicator] hide];
	```
	
	**Swift**
	
	```swift
	MKAIndicator.default().hide()
	```

### Basic Type

**Objective-C**

```objc
// Get a singleton instance.
MKAIndicator *indicator = [MKAIndicator defaultIndicator];

// Setup.
indicator.indicatorType = MKAIndicatorTypeBasic;
[indicator setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleWhiteLarge];
[indicator addBlackBackgroundView];
```

### Custom Type

**Objective-C**

```objc
// Get a singleton instance.
MKAIndicator *indicator = [MKAIndicator defaultIndicator];
    
// Setup.
indicator.indicatorType = MKAIndicatorTypeCustom;
[indicator setCustomIndicatorViewImage:[UIImage imageNamed:@"spinner"]];
```

### Sprite Animation Type

**Objective-C**

```objc
// Get a singleton instance.
MKAIndicator *indicator = [MKAIndicator defaultIndicator];

// Setup.
indicator.indicatorType = MKAIndicatorTypeSpriteAnimation;
[indicator setSpriteAnimationIndicatorViewImagesWithFormat:@"indicator%zd" 
                                                     count:8];
[indicator setAnimationDuration:.5];
```

### Only Status Bar Type

**Objective-C**

```objc
// Get a singleton instance.
MKAIndicator *indicator = [MKAIndicator defaultIndicator];

// Setup.
indicator.indicatorType = MKAIndicatorTypeOnlyStatusBar;
```

More info, see my [sample project](https://github.com/HituziANDO/MKAIndicatorView/tree/master/Sample).

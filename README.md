MKAIndicatorView
===

***MKAIndicatorView makes you to create the powerful indicator view easily.***

<img src="./README/images/basic.gif" width="200">
<img src="./README/images/custom.gif" width="200">
<img src="./README/images/sprite_animation.gif" width="200">

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
	[[MKAIndicator basicIndicatorWithActivityIndicatorViewStyle:UIActivityIndicatorViewStyleGray]
                   showInView:self.view withTouchDisabled:NO];
	```
	
	**Swift**
	
	```swift
	MKAIndicator.basicIndicator(with: .gray).show(in: self.view, withTouchDisabled: false)
	```

3. Hide the indicator
	
	**Objective-C**
	
	```objc
	[[MKAIndicator currentIndicator] hide];
	```
	
	**Swift**
	
	```swift
	MKAIndicator.current().hide()
	```

### Basic Type

**Objective-C**

```objc
// Show basic indicator.
[[[MKAIndicator basicIndicatorWithActivityIndicatorViewStyle:UIActivityIndicatorViewStyleWhiteLarge]
                addBlackBackgroundView]
                showInView:self.view withTouchDisabled:NO];
```

**Swift**

```swift
// Show basic indicator.
MKAIndicator.basicIndicator(with: .whiteLarge)
            .addBlackBackgroundView()
            .show(in: self.view, withTouchDisabled: false)
```

### Custom Type

**Objective-C**

```objc
// Show custom indicator.
[[[MKAIndicator customIndicatorWithIndicatorViewImage:[UIImage imageNamed:@"spinner"]]
                setAnimationDuration:1.0]
                showInView:self.view withTouchDisabled:NO];
```

**Swift**

```swift
// Show custom indicator.
MKAIndicator.customIndicator(withIndicatorViewImage: UIImage(named: "spinner")!)
            .setAnimationDuration(1.0)
            .show(in: self.view, withTouchDisabled: false)
```

### Sprite Animation Type

**Objective-C**

```objc
// Show sprite animation indicator.
[[[MKAIndicator spriteAnimationIndicatorWithIndicatorViewImagesFormat:@"indicator%zd" count:8]
                setAnimationDuration:.5]
                showInView:self.view withTouchDisabled:NO];
```

**Swift**

```swift
// Show sprite animation indicator.
MKAIndicator.spriteAnimationIndicator(withIndicatorViewImagesFormat: "indicator%zd", count: 8)
            .setAnimationDuration(0.5)
            .show(in: self.view, withTouchDisabled: false)
```

### Only Status Bar Type

**Objective-C**

```objc
// Show indicator on the status bar only.
[[MKAIndicator onlyStatusBarIndicator] showInView:self.view withTouchDisabled:NO];
```

**Swift**

```swift
// Show indicator on the status bar only.
MKAIndicator.onlyStatusBarIndicator().show(in: self.view, withTouchDisabled: false)
```

More info, see my [sample project](https://github.com/HituziANDO/MKAIndicatorView/tree/master/Sample).

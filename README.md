MKAIndicatorView
===

MKAIndicatorView makes you to create the powerful indicator view easily. See following samples.

**Basic Type Indicator**

<img src="./README/images/basic.gif" width="200" style="box-shadow: 0 1px 20px #00000022">

**Custom Type Indicator**

<img src="./README/images/custom.gif" width="200" style="box-shadow: 0 1px 20px #00000022">

**Sprite Animation Type Indicator**

<img src="./README/images/sprite_animation.gif" width="200" style="box-shadow: 0 1px 20px #00000022">

## Get Started
### Install Framework to Your iOS App

You have two ways to install this framework.

#### 1. CocoaPods

MKAIndicatorView is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "MKAIndicatorView"
```

#### 2. Manual Installation

1. Download latest [MKAIndicatorView](https://github.com/HituziANDO/MKAIndicatorView/releases)
1. Drag & Drop MKAIndicatorView.framework into your Xcode project


### Quick Usage

1. Import the framework
	
	**Swift**
	
	```swift
	import MKAIndicatorView
	```
	
	**Objective-C**
	
	```objc
	#import <MKAIndicatorView/MKAIndicatorView.h>
	```

2. Show the indicator
	
	**Swift**
	
	```swift
	// Set default indicator.
	let indicator = MKAIndicator.basicIndicator(with: .gray)
	MKAIndicator.setDefault(indicator)
	MKAIndicator.default().show(in: self.view, withTouchDisabled: false)
	```
	
	**Objective-C**
	
	```objc
	// Set default indicator.
	MKAIndicator *indicator = [MKAIndicator basicIndicatorWithActivityIndicatorViewStyle:UIActivityIndicatorViewStyleGray];
   [MKAIndicator setDefaultIndicator:indicator];
	[[MKAIndicator defaultIndicator] showInView:self.view withTouchDisabled:NO];
	```

3. Hide the indicator
	
	**Swift**
	
	```swift
	MKAIndicator.default().hide()
	```
	
	**Objective-C**
	
	```objc
	[[MKAIndicator defaultIndicator] hide];
	```

## Style
### Basic Type Indicator

The basic type indicator is simple using the style prepared by UIKit.

**Swift**

```swift
// Show basic indicator.
let indicator = MKAIndicator.basicIndicator(with: .whiteLarge)
                            .addBlackBackgroundView()
MKAIndicator.setDefault(indicator)
MKAIndicator.default().show(in: self.view, withTouchDisabled: false)
```

**Objective-C**

```objc
// Show basic indicator.
MKAIndicator *indicator = [[MKAIndicator basicIndicatorWithActivityIndicatorViewStyle:UIActivityIndicatorViewStyleWhiteLarge]
                                         addBlackBackgroundView];
[MKAIndicator setDefaultIndicator:indicator];
[[MKAIndicator defaultIndicator] showInView:self.view withTouchDisabled:NO];
```

### Custom Type Indicator

The custom type indicator uses an indicator image you created or prepared. The indicator image automatically rotates at the specified animation interval.

**Swift**

```swift
// Show custom indicator.
let indicator = MKAIndicator.customIndicator(withIndicatorViewImage: UIImage(named: "spinner")!)
                            .setAnimationDuration(1.0)
MKAIndicator.setDefault(indicator)
MKAIndicator.default().show(in: self.view, withTouchDisabled: false)
```

**Objective-C**

```objc
// Show custom indicator.
MKAIndicator *indicator = [[MKAIndicator customIndicatorWithIndicatorViewImage:[UIImage imageNamed:@"spinner"]]
                                         setAnimationDuration:1.0];
[MKAIndicator setDefaultIndicator:indicator];
[[MKAIndicator defaultIndicator] showInView:self.view withTouchDisabled:NO];
```

### Sprite Animation Type Indicator

The sprite animation type indicator uses indicator images you created or prepared. Images are composed of the keyframe animation at the specified animation interval.

**Swift**

```swift
// Show sprite animation indicator.
let indicator = MKAIndicator.spriteAnimationIndicator(withIndicatorViewImagesFormat: "indicator%zd", count: 8)
                            .setAnimationDuration(0.5)
MKAIndicator.setDefault(indicator)
MKAIndicator.default().show(in: self.view, withTouchDisabled: false)
```

**Objective-C**

```objc
// Show sprite animation indicator.
MKAIndicator *indicator = [[MKAIndicator spriteAnimationIndicatorWithIndicatorViewImagesFormat:@"indicator%zd" count:8]
                                         setAnimationDuration:.5];
[MKAIndicator setDefaultIndicator:indicator];
[[MKAIndicator defaultIndicator] showInView:self.view withTouchDisabled:NO];
```

### Only Status Bar Type Indicator

**Swift**

```swift
// Show indicator on the status bar only.
let indicator = MKAIndicator.onlyStatusBarIndicator()
MKAIndicator.setDefault(indicator)
MKAIndicator.default().show(in: self.view, withTouchDisabled: false)
```

**Objective-C**

```objc
// Show indicator on the status bar only.
MKAIndicator *indicator = [MKAIndicator onlyStatusBarIndicator];
[MKAIndicator setDefaultIndicator:indicator];
[[MKAIndicator defaultIndicator] showInView:self.view withTouchDisabled:NO];
```

**[KNOWN ISSUE]** The onlyStatusBarIndicator is not working for iPhone X series.

----

More info, see my [sample project](https://github.com/HituziANDO/MKAIndicatorView/tree/master/Sample).

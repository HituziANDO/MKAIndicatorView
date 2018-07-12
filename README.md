MKAIndicator
===

MKAIndicator makes you to create an indicator view easily.

# Usage

```ObjC
#import "MKAIndicator.h"

...ObjC

// Show.
[[MKAIndicator defaultIndicator] showInView:self.view 
                          withTouchDisabled:NO];

...ObjC

// Hide.
[[MKAIndicator defaultIndicator] hide];
```

### Basic Type

```ObjC
// Get a singleton instance.
MKAIndicator *indicator = [MKAIndicator defaultIndicator];

// Setup.
indicator.indicatorType = MKAIndicatorTypeBasic;
[indicator setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleWhiteLarge];
[indicator addBlackBackgroundView];
```

### Custom Type

```ObjC
// Get a singleton instance.
MKAIndicator *indicator = [MKAIndicator defaultIndicator];
    
// Setup.
indicator.indicatorType = MKAIndicatorTypeCustom;
[indicator setCustomIndicatorViewImage:[UIImage imageNamed:@"spinner"]];
```

### Sprite Animation Type

```ObjC
// Get a singleton instance.
MKAIndicator *indicator = [MKAIndicator defaultIndicator];

// Setup.
indicator.indicatorType = MKAIndicatorTypeSpriteAnimation;
[indicator setSpriteAnimationIndicatorViewImagesWithFormat:@"indicator%zd" 
                                                     count:8];
[indicator setAnimationDuration:.5];
```

### Only Status Bar Type

```ObjC
// Get a singleton instance.
MKAIndicator *indicator = [MKAIndicator defaultIndicator];

// Setup.
indicator.indicatorType = MKAIndicatorTypeOnlyStatusBar;
```

# License
MIT License

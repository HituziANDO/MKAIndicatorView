MKAIndicator
===

MKAIndicator makes you to create an indicator view easily.

# Usage

```
#import "MKAIndicator.h"

...

// Show.
[[MKAIndicator defaultIndicator] showInView:self.view 
                          withTouchDisabled:NO];

...

// Hide.
[[MKAIndicator defaultIndicator] hide];
```

### Basic Type

```
// Get a singleton instance.
MKAIndicator *indicator = [MKAIndicator defaultIndicator];

// Setup.
indicator.indicatorType = MKAIndicatorTypeBasic;
[indicator setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleWhiteLarge];
[indicator addBlackBackgroundView];
```

### Custom Type

```
// Get a singleton instance.
MKAIndicator *indicator = [MKAIndicator defaultIndicator];
    
// Setup.
indicator.indicatorType = MKAIndicatorTypeCustom;
[indicator setCustomIndicatorViewImage:[UIImage imageNamed:@"spinner"]];
```

### Sprite Animation Type

```
// Get a singleton instance.
MKAIndicator *indicator = [MKAIndicator defaultIndicator];

// Setup.
indicator.indicatorType = MKAIndicatorTypeSpriteAnimation;
[indicator setSpriteAnimationIndicatorViewImagesWithFormat:@"indicator%zd" 
                                                     count:8];
[indicator setAnimationDuration:.5];
```

### Only Status Bar Type

```
// Get a singleton instance.
MKAIndicator *indicator = [MKAIndicator defaultIndicator];

// Setup.
indicator.indicatorType = MKAIndicatorTypeOnlyStatusBar;
```

# License
MIT License

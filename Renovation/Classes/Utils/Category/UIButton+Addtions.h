
#import <UIKit/UIKit.h>

typedef void(^ButtonBlock)(UIButton* btn);

@interface UIButton (Addtions)

- (void)addAction:(ButtonBlock)block;


- (void)addAction:(ButtonBlock)block forControlEvents:(UIControlEvents)controlEvents;

- (void) setEnlargeEdge:(CGFloat) edge;

- (void) setEnlargeEdgeWithTop:(CGFloat) top right:(CGFloat) right bottom:(CGFloat) bottom left:(CGFloat) left;

@end

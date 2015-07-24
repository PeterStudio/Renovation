
#import <UIKit/UIKit.h>

@interface UIView (Additions)



@property(assign) CGFloat frameX;


@property(assign) CGFloat frameY;


@property(assign) CGFloat frameWidth;
@property(assign) CGFloat frameHeight;


@property(assign) CGSize frameSize;


@property(assign) CGPoint frameOrigin;

- (UIViewController *)viewController;
@end



@interface UIView(Constraints)


- (NSLayoutConstraint *)findConstraintForAttribute:(NSLayoutAttribute)attribute;


- (NSLayoutConstraint *)findOwnConstraintForAttribute:(NSLayoutAttribute)attribute;
@end




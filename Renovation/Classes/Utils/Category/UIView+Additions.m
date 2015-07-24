
#import "UIView+Additions.h"

@implementation UIView (Additions)

- (CGFloat)frameX {
	return self.frame.origin.x;
}

- (void)setFrameX:(CGFloat)value {
    CGRect frame = self.frame;
	frame.origin.x = value;
	self.frame = frame;
}

- (CGFloat)frameY {
	return self.frame.origin.y;
}

- (void)setFrameY:(CGFloat)value {
    CGRect frame = self.frame;
	frame.origin.y = value;
	self.frame = frame;
}

- (CGFloat) frameWidth{
	return self.frame.size.width;
}

- (void) setFrameWidth:(CGFloat)value {
    CGRect frame = self.frame;
	frame.size.width = value;
	self.frame = frame;
}

- (CGFloat) frameHeight{
	return self.frame.size.height;
}

- (void) setFrameHeight:(CGFloat)value {
    CGRect frame = self.frame;
	frame.size.height = value;
	self.frame = frame;
}

- (CGSize) frameSize{
	return self.frame.size;
}

- (void) setFrameSize:(CGSize)aSize {
    CGRect frame = self.frame;
	frame.size = aSize;
	self.frame = frame;
}

- (CGPoint) frameOrigin{
	return self.frame.origin;
}

- (void) setFrameOrigin:(CGPoint)aOrigin {
    CGRect frame = self.frame;
	frame.origin = aOrigin;
	self.frame = frame;
}



- (UIViewController*)viewController
{
    for (UIView* next = [self superview]; next; next = next.superview)
    {
        UIResponder* nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]])
        {
            return (UIViewController*)nextResponder;
        }
    }
    return nil;
}
@end


@implementation UIView(Constraints)


- (NSLayoutConstraint *)findConstraintForAttribute:(NSLayoutAttribute)attribute
{
    for (NSLayoutConstraint *constraint in self.superview.constraints)
        
    {
        
 
        
        if (constraint.firstItem == self && constraint.firstAttribute == attribute)
            
            return constraint;
        
  
        
        if (constraint.secondItem == self && constraint.secondAttribute == attribute)
            
            return constraint;
        
    }
    
    
    
    return nil;
    


}


- (NSLayoutConstraint *)findOwnConstraintForAttribute:(NSLayoutAttribute)attribute
{
    for (NSLayoutConstraint *constraint in self.constraints)
        
    {
        

        if (constraint.firstItem == self && constraint.firstAttribute == attribute)
            
            return constraint;
        
        

        
        if (constraint.secondItem == self && constraint.secondAttribute == attribute)
            
            return constraint;
        
    }
    
    
    
    return nil;

}

@end

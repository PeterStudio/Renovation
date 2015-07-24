
#import <UIKit/UIKit.h>

@interface PhotoView : UIView
@property (nonatomic,copy)void (^singleRecognizerTapBlock)();

@property(nonatomic)float maxScale;


- (void)resetScale;




- (void)initWithUrl:(NSString *)url  placeholderImage:(UIImage *)image;




- (void)initWithImage:(UIImage *)image;
@end

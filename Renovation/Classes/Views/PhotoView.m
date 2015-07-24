
#import "PhotoView.h"
#import "UIView+Additions.h"
#import "UIImageView+WebCache.h"
#import "PTDefine.h"
@interface PhotoView()<UIScrollViewDelegate>
{
    UIImageView  *_imageView;
    UIScrollView *_scrollView;
    CGFloat currentScale;
    
    CGFloat minScale;
}


- (void)setup;
@end

@implementation PhotoView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self setup];
    }
    return self;
}


- (void)setup
{
    _maxScale=2.0;

    minScale=1.0;

    currentScale=1.0;
    
    _scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
    _scrollView.backgroundColor = [UIColor clearColor];
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.center = self.center;
    _scrollView.userInteractionEnabled=YES;
    _scrollView.maximumZoomScale=2.0;
    _scrollView.minimumZoomScale=1.0;
    _scrollView.decelerationRate=1.0;
    _scrollView.delegate=self;
    [self addSubview:_scrollView];
    
    _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, UIScreenWidth, UIScreenWidth)];
    _imageView.center = self.center;
    _imageView.contentMode = UIViewContentModeScaleAspectFit;
    _imageView.backgroundColor = UIColorFromRGB(0xeeeeee);
    [_scrollView addSubview:_imageView];
    
    UITapGestureRecognizer *doubelGesture=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleGesture:)];
    doubelGesture.numberOfTapsRequired=2;
    [_scrollView addGestureRecognizer:doubelGesture];
    
    
    UITapGestureRecognizer *singlelGesture=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleGesture:)];
    singlelGesture.numberOfTapsRequired=1;
    [_scrollView addGestureRecognizer:singlelGesture];
    
    [singlelGesture requireGestureRecognizerToFail:doubelGesture];
    
    
}



- (void)initWithUrl:(NSString *)url  placeholderImage:(UIImage *)image
{
    __weak typeof(PhotoView *)bself = self;
    [_imageView sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:image options:SDWebImageRetryFailed completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
         [bself adjustFrame];
    }];

}


- (void)initWithImage:(UIImage *)image
{

    if (image)
    {
        [_imageView setImage:image];
        
        [self adjustFrame];
    }
}



- (void)adjustFrame
{

    if (_imageView.image)
    {

        CGSize boundsSize = self.bounds.size;
        CGFloat boundsWidth = boundsSize.width;

        
        CGSize imageSize = _imageView.image.size;
        CGFloat imageWidth = imageSize.width;
        CGFloat imageHeight = imageSize.height;

        
        CGRect imageFrame = CGRectMake(0, 0, boundsWidth, imageHeight * boundsWidth / imageWidth);

        _scrollView.contentSize = CGSizeMake(0, imageFrame.size.height);
    
        _imageView.frame = imageFrame;
        _imageView.center = _scrollView.center;
        
    }

}


- (void)resetScale
{

      [_scrollView setZoomScale:_scrollView.minimumZoomScale    animated:YES];

}


#pragma mark -DoubleGesture Action
-(void)doubleGesture:(UIGestureRecognizer *)sender
{
    

    if (currentScale==_maxScale)
    {
        currentScale=minScale;
        [_scrollView setZoomScale:currentScale animated:YES];
        return;
    }

    if (currentScale==minScale)
    {
        currentScale=_maxScale;
        [_scrollView setZoomScale:currentScale animated:YES];
        return;
    }
    
    CGFloat aveScale =minScale+(_maxScale-minScale)/2.0;
    if (currentScale>=aveScale)
    {
        currentScale=_maxScale;
        [_scrollView setZoomScale:currentScale animated:YES];
        return;
    }
    
    if (currentScale<aveScale)
    {
        currentScale=minScale;
        [_scrollView setZoomScale:currentScale animated:YES];
        return;
    }
}


- (void)singleGesture:(UIGestureRecognizer *)sender
{
    if (self.singleRecognizerTapBlock)
    {
        self.singleRecognizerTapBlock();
    }

}

#pragma mark -UIScrollView delegate
-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return _imageView;
}


- (void)scrollViewDidZoom:(UIScrollView *)aScrollView
{

    CGFloat offsetX = (_scrollView.bounds.size.width > _scrollView.contentSize.width)?
    (_scrollView.bounds.size.width - _scrollView.contentSize.width) * 0.5 : 0.0;
    
    CGFloat offsetY = (_scrollView.bounds.size.height > _scrollView.contentSize.height)?
    (_scrollView.bounds.size.height - _scrollView.contentSize.height) * 0.5 : 0.0;
    
    _imageView.center = CGPointMake(_scrollView.contentSize.width * 0.5 + offsetX,
                                 _scrollView.contentSize.height * 0.5 + offsetY);
}




- (void)dealloc
{
    _scrollView = nil;
    
    _imageView = nil;
    
    
    
}
@end
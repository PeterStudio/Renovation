
#import "PhotosViewController.h"
#import "UIView+Additions.h"
#import "UIButton+Addtions.h"
#import "PhotoView.h"
#import "PageNumView.h"
#import "PTDefine.h"
#import "PTViewController.h"
@interface PhotosViewController ()<UIScrollViewDelegate>
{
    UIScrollView  *_scrollView;
    NSMutableArray  *_photoArray;
    PageNumView  *_pageNumView;
}


- (void)setup;


- (void)initWithDataSource;
@end

@implementation PhotosViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
      
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"图片详情";
    if (CURRENT_VERSION>7) {
        self.automaticallyAdjustsScrollViewInsets = NO;

    }
    [self setup];
    [self initWithDataSource];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}



-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[self navigationController] setNavigationBarHidden:NO animated:YES];
}

- (void)popView
{
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(photosViewBackAtIndex:)])
    {
        [self.delegate photosViewBackAtIndex:self.currentPage];
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}




- (void)setup
{
    
    self.view.backgroundColor = [UIColor blackColor];
    _photoArray = [[NSMutableArray alloc] init];
    
    _scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    _scrollView.backgroundColor = [UIColor clearColor];
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.center = self.view.center;
    _scrollView.pagingEnabled = YES;
    _scrollView.userInteractionEnabled=YES;
    _scrollView.delegate=self;
    [self.view addSubview:_scrollView];
    

    
    _pageNumView = [[PageNumView alloc] initWithFrame:CGRectMake(270, 45, 28, 28)];
    _pageNumView.blackGroundFlag = YES;
    [self.view addSubview:_pageNumView];
    

}





- (void)initWithDataSource
{

    if (!self.datasource) return;
    
    NSInteger count = [self.datasource photosViewNumberOfCount];
    for (int i = 0; i<count; i ++)
    {
        PhotoView     *picView = [[PhotoView alloc] initWithFrame:_scrollView.bounds];
        picView.frameX = i *UIScreenWidth;
        
        if ([self.datasource respondsToSelector:@selector(photosViewUrlAtIndex:)])
        {
            NSString *url = [self.datasource photosViewUrlAtIndex:i];
            
            NSString *temp = @"local";
            if ([url rangeOfString:temp].location != NSNotFound)
            {
                url = [url substringFromIndex:temp.length];
                UIImage *tempImage = [[UIImage   alloc] initWithContentsOfFile:url];
                [picView initWithImage:tempImage];
            }else
            {
                
                [picView initWithUrl:url placeholderImage:[UIImage imageNamed:@"community_default"]];
            }
        }
    
        if ([self.datasource respondsToSelector:@selector(photosViewImageAtIndex:)])
        {
            UIImage *image = [self.datasource photosViewImageAtIndex:i];
            [picView initWithImage:image];
        }
        
        __weak  typeof(PhotosViewController *)bself = self;
        picView.singleRecognizerTapBlock = ^{
            [bself popView];
        };
        [_scrollView addSubview:picView];
        
        [_photoArray addObject:picView];
    }
     [_scrollView setContentSize:CGSizeMake(UIScreenWidth*count, _scrollView.frameHeight)];
    [_scrollView scrollRectToVisible:CGRectMake(UIScreenWidth * self.currentPage, 0, UIScreenWidth, _scrollView.frameHeight) animated:YES];
    
    _pageNumView.countNum =(int) count;
    
    _pageNumView.currentPage = self.currentPage;

}

#pragma mark -
#pragma mark - 滚动视图代理方法

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    
    self.currentPage = floorf(scrollView.contentOffset.x/scrollView.bounds.size.width);
    
    _pageNumView.currentPage = self.currentPage ;
    for (PhotoView *view in _photoArray)
    {
        [view resetScale];
    }
}




- (void)dealloc
{
    
    _scrollView = nil;
    
    _photoArray = nil;
    
    _pageNumView = nil;
    
}

@end

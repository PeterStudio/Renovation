
#import "PTViewController.h"

@protocol PhotosViewDelegate <NSObject>
@optional
- (void)photosViewBackAtIndex:(NSInteger)index;
@end
@protocol PhotosViewDatasource <NSObject>
@optional
- (UIImage *)photosViewImageAtIndex:(NSInteger)index;
- (NSString *)photosViewUrlAtIndex:(NSInteger)index;
@required
- (NSInteger)photosViewNumberOfCount;
@end
@interface PhotosViewController : PTViewControllerWithBack
@property (nonatomic,weak) id <PhotosViewDelegate>   delegate;
@property (nonatomic,weak) id <PhotosViewDatasource>  datasource;
@property (nonatomic,assign)  int currentPage;
@end

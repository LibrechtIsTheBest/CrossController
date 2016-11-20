#import <UIKit/UIKit.h>

@interface PageViewController : UIPageViewController

@property (nonatomic) void(^onDidVerticalScroll)(UIScrollView *scrollView);

@end

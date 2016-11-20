#import <UIKit/UIKit.h>
#import "Index.h"

@interface ViewController : UIViewController <Index>

+ (instancetype)instance;

@property (copy, nonatomic) NSString *text;
@property (nonatomic) CGPoint tableViewContentOffset;
@property (nonatomic) void(^onScrollViewDidScroll)(UIScrollView *scrollView);

@end


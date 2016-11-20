#import "PageViewController.h"
#import "ViewController.h"

@interface PageViewController () <UIPageViewControllerDataSource, UIPageViewControllerDelegate>

@property (nonatomic) NSMutableDictionary <NSNumber *, ViewController *> *vcs;

@end

@implementation PageViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.dataSource = self;
    self.delegate = self;
    ViewController *firstVC = [self viewControllerForIndex:0];
    firstVC.text = @"123456";
    [self setViewControllers:@[firstVC] direction:UIPageViewControllerNavigationDirectionForward
        animated:NO completion:nil];
}

- (ViewController *)viewControllerForIndex:(NSInteger)index
{
    ViewController *vc = self.vcs[@(index)];
    if (vc == nil) {
        vc = [ViewController instance];
        vc.index = index;
        vc.onScrollViewDidScroll = self.onDidVerticalScroll;
        self.vcs[@(vc.index + 1)] = vc;
    }
    return vc;
}

#pragma mark - <UIPageViewControllerDataSource>

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    if ([viewController isKindOfClass:[ViewController class]]) {
        ViewController *vc = (ViewController *)viewController;
        if (vc.index == 0) {
            ViewController *nextVC = [self viewControllerForIndex:(vc.index + 1)];
            nextVC.text = @"qwerty";
            return nextVC;
        }
        else if (vc.index == 1) {
            ViewController *nextVC = [self viewControllerForIndex:(vc.index + 1)];
            nextVC.text = @"asdfghj";
            return nextVC;
        }
        else if (vc.index == 2) {
            ViewController *nextVC = [self viewControllerForIndex:(vc.index + 1)];
            nextVC.text = @"zxcvbnm";
            return nextVC;
        }
        return nil;
    }
    return nil;
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    if ([viewController isKindOfClass:[ViewController class]]) {
        ViewController *vc = (ViewController *)viewController;
        if (vc.index == 1) {
            ViewController *nextVC = [self viewControllerForIndex:(vc.index - 1)];
            nextVC.text = @"123456";
            return nextVC;
        }
        else if (vc.index == 2) {
            ViewController *nextVC = [self viewControllerForIndex:(vc.index - 1)];
            nextVC.text = @"qwerty";
            return nextVC;
        }
        else if (vc.index == 3) {
            ViewController *nextVC = [self viewControllerForIndex:(vc.index - 1)];
            nextVC.text = @"asdfghj";
            return nextVC;
        }
        return nil;
    }
    return nil;
}

- (void)pageViewController:(UIPageViewController *)pageViewController willTransitionToViewControllers:(NSArray<UIViewController *> *)pendingViewControllers
{
    ViewController *currentVC = (ViewController *)pageViewController.viewControllers.firstObject;
    ViewController *nextVC = (ViewController *)pendingViewControllers.firstObject;
    nextVC.tableViewContentOffset = currentVC.tableViewContentOffset;
}

@end

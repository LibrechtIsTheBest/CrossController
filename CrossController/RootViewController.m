#import "RootViewController.h"
#import "PageViewController.h"

static NSString *const PageVCEmbedSegue = @"PageVCEmbedSegue";

@interface RootViewController ()

@property (nonatomic) PageViewController *pageViewController;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *headerTopContstraint;

@end

@implementation RootViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:PageVCEmbedSegue]) {
        self.pageViewController = segue.destinationViewController;
        __weak RootViewController *weakSelf = self;
        self.pageViewController.onDidVerticalScroll = ^(UIScrollView *scrollView) {
            weakSelf.headerTopContstraint.constant = -scrollView.contentOffset.y;
        };
    }
}

@end

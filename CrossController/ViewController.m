#import "ViewController.h"

static NSString *const StoryboardName = @"Main";
static NSString *const StoryboardID = @"ViewController";

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ViewController

@synthesize index, tableViewContentOffset = _tableViewContentOffset;

+ (instancetype)instance
{
    ViewController *vc = [[UIStoryboard storyboardWithName:StoryboardName
        bundle:nil] instantiateViewControllerWithIdentifier:StoryboardID];
    return vc;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.contentOffset = _tableViewContentOffset;
    // can't use tableView.contentInset, because then sectionHeader will use it too
    // so useing trasnparent headerView
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
}

#pragma mark - <UITableViewDataSource>

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TableViewCell" forIndexPath:indexPath];
    cell.textLabel.text = self.text;
    return cell;
}

#pragma mark - <UITableViewDelegate>

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 18)];
    /* Create custom view to display section header... */
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, tableView.frame.size.width, 18)];
    [label setFont:[UIFont boldSystemFontOfSize:12]];
    NSString *string = @"Section Header";
    /* Section header is in 0th index... */
    [label setText:string];
    [view addSubview:label];
    [view setBackgroundColor:[UIColor colorWithRed:166/255.0 green:177/255.0 blue:186/255.0 alpha:1.0]]; //your background color...
    return view;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSLog(@"%f", scrollView.contentOffset.y);
//    self.headerTopContstraint.constant = -scrollView.contentOffset.y;
    if (self.onScrollViewDidScroll) {
        self.onScrollViewDidScroll(scrollView);
    }
}

//- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
//{
//    NSLog(@"%f", fabs(self.view.center.y - scrollView.contentOffset.y - 436*0.5));
////    NSLog(@"%f", self.view.center.y);
////    NSLog(@"%f", scrollView.contentOffset.y);
//    if (fabs(self.view.center.y - scrollView.contentOffset.y - 436*0.5) < 100) {
//        [UIView animateWithDuration:0.2 animations:^{
//            CGPoint offset = scrollView.contentOffset;
//            offset.y = self.view.center.y - 436*0.5;
//            scrollView.contentOffset = offset;
//        }];
//    }
//}

#pragma mark - Setters & Getters

- (CGPoint)tableViewContentOffset
{
    return self.tableView.contentOffset;
}

- (void)setTableViewContentOffset:(CGPoint)tableViewContentOffset
{
    _tableViewContentOffset = tableViewContentOffset;
    self.tableView.contentOffset = tableViewContentOffset;
}

@end

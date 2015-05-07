


#import <UIKit/UIKit.h>
#import "PageContentViewController.h"

@interface Tutorial_setting : UIViewController <UIPageViewControllerDataSource>

- (IBAction)startWalkthrough:(id)sender;
@property (strong, nonatomic) UIPageViewController *pageViewController2;
@property (strong, nonatomic) NSArray *pageTitles2;
@property (strong, nonatomic) NSArray *pageImages2;

@end

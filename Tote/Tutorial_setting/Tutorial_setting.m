//
//  ViewController.m
//  PageViewDemo
//
//  Created by Simon on 24/11/13.
//  Copyright (c) 2013 Appcoda. All rights reserved.
//

#import "Tutorial_setting.h"

@interface Tutorial_setting ()

@end

@implementation Tutorial_setting

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Create the data model
    _pageTitles2 = @[@"", @"", @"", @"", @"", @""];
    _pageImages2 = @[@"title1.png", @"title2.png", @"title3.png", @"title4.png", @"title5.png", @"title6.png"];
    
    // Create page view controller
    self.pageViewController2 = [self.storyboard instantiateViewControllerWithIdentifier:@"PageViewController"];
    self.pageViewController2.dataSource = self;
    
    PageContentViewController *startingViewController = [self viewControllerAtIndex:0];
    NSArray *viewControllers = @[startingViewController];
    [self.pageViewController2 setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    
    // Change the size of page view controller
    self.pageViewController2.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 90);
    
    [self addChildViewController:_pageViewController2];
    [self.view addSubview:_pageViewController2.view];
    [self.pageViewController2 didMoveToParentViewController:self];
    
    
    
    /* UIPageControl *pageControl = [UIPageControl appearance];
     pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
     pageControl.currentPageIndicatorTintColor = [UIColor blackColor];
     pageControl.backgroundColor = [UIColor whiteColor];
     */
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (PageContentViewController *)viewControllerAtIndex:(NSUInteger)index
{
    if (([self.pageTitles2 count] == 0) || (index >= [self.pageTitles2 count])) {
        return nil;
    }
    
    // Create a new view controller and pass suitable data.
    PageContentViewController *pageContentViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"PageContentViewController"];
    pageContentViewController.imageFile = self.pageImages2[index];
    pageContentViewController.titleText = self.pageTitles2[index];
    pageContentViewController.pageIndex = index;
    
    return pageContentViewController;
}

#pragma mark - Page View Controller Data Source

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    NSUInteger index = ((PageContentViewController*) viewController).pageIndex;
    
    if ((index == 0) || (index == NSNotFound)) {
        return nil;
    }
    
    index--;
    return [self viewControllerAtIndex:index];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    NSUInteger index = ((PageContentViewController*) viewController).pageIndex;
    
    if (index == NSNotFound) {
        return nil;
    }
    
    index++;
    if (index == [self.pageTitles2 count]) {
        return nil;
    }
    return [self viewControllerAtIndex:index];
}

- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController
{
    return [self.pageTitles2 count];
}

- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController
{
    return 0;
}

-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

@end

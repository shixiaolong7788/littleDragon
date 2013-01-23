//
//  GHRootViewController.m
//  GHSidebarNav
//
//  Created by Greg Haines on 11/20/11.
//

#import "GHRootViewController.h"
#import "GHPushedViewController.h"


#pragma mark -
#pragma mark Private Interface
@interface GHRootViewController ()
- (void)pushViewController;
- (void)revealSidebar;
@end


#pragma mark -
#pragma mark Implementation
@implementation GHRootViewController

#pragma mark Memory Management
- (id)initWithTitle:(NSString *)title withRevealBlock:(RevealBlock)revealBlock {
    if (self = [super initWithNibName:nil bundle:nil]) {
		self.title = title;
		_revealBlock = [revealBlock copy];
        
        UIButton *leftButton = [[UIButton alloc]init];
        leftButton.frame = CGRectMake(0, 0, 60, 30);
        [leftButton setBackgroundImage:[UIImage imageNamed:@"back_bar_item_bg.png"] forState:UIControlStateNormal];
        [leftButton setTitle:@"  返回" forState:UIControlStateNormal];
        leftButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [leftButton addTarget:self action:@selector(revealSidebar) forControlEvents:UIControlEventTouchUpInside];
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftButton];
        
	}
	return self;
}

#pragma mark UIViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navigationBar_bg.png"] forBarMetrics:UIBarMetricsDefault];
	self.view.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
	self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"imageListBgView.png"]];
	UIButton *pushButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
	[pushButton setTitle:@"Push" forState:UIControlStateNormal];
	[pushButton addTarget:self action:@selector(pushViewController) forControlEvents:UIControlEventTouchUpInside];
	[pushButton sizeToFit];
	[self.view addSubview:pushButton];
}

#pragma mark Private Methods
- (void)pushViewController {
	NSString *vcTitle = [self.title stringByAppendingString:@" - Pushed"];
	UIViewController *vc = [[GHPushedViewController alloc] initWithTitle:vcTitle];
	[self.navigationController pushViewController:vc animated:YES];
}

- (void)revealSidebar {
	_revealBlock();
}

@end

//
//  DetailViewController.m
//  IXiuTu
//
//  Created by shixiaolong on 13-1-22.
//  Copyright (c) 2013年 shixiaolong. All rights reserved.
//

#import "DetailViewController.h"
#import "MDCParallaxView.h"
#import "ICommentView.h"

@interface DetailViewController () <UIScrollViewDelegate>

@end

@implementation DetailViewController


@synthesize photoTypeArray = _photoTypeArray;
@synthesize thumbnailPicArray = _thumbnailPicArray;
@synthesize middlePicArray = _middlePicArray;
@synthesize photoTextArray = _photoTextArray;
@synthesize profilePicArray = _profilePicArray;
@synthesize profileNameArray = _profileNameArray;

static DetailViewController *sharedInstance;
+ (id) sharedInstance
{
    @synchronized([DetailViewController class])
    {
        if (sharedInstance == nil) {
            sharedInstance = [[DetailViewController alloc]init];
        }
    }
    return sharedInstance;
}

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
   
    self.navigationItem.title = @"详情页面";
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"imageListBgView.png"]];
    UIButton *leftButton = [[UIButton alloc]init];
    leftButton.frame = CGRectMake(0, 0, 60, 30);
    [leftButton setBackgroundImage:[UIImage imageNamed:@"back_bar_item_bg.png"] forState:UIControlStateNormal];
    [leftButton setTitle:@"  返回" forState:UIControlStateNormal];
    leftButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [leftButton addTarget:self action:@selector(onReturn) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftButton];
    
    middlePicArray = [[NSMutableArray alloc]init];
    middlePicArray = [[NSUserDefaults standardUserDefaults]objectForKey:@"middlePicArray"];
    photoTextArray = [[NSMutableArray alloc] init];
    photoTextArray = [[NSUserDefaults standardUserDefaults]objectForKey:@"photoTextArray"];
    profilePicArray = [[NSMutableArray alloc] init];
    profilePicArray = [[NSUserDefaults standardUserDefaults] objectForKey:@"profilePicArray"];
    profileNameArray = [[NSUserDefaults standardUserDefaults] objectForKey:@"profileNameArray"];
    
}

- (void)onReturn
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)viewWillAppear:(BOOL)animated
{
//    [[self.activityDelegate passActivity] stopAnimating];
    NSString *urlString = [middlePicArray objectAtIndex:[[NSUserDefaults standardUserDefaults]integerForKey:@"cellTag"]-100];
    NSURL *url = [NSURL URLWithString:urlString];
    NSLog(@"我拿到了 %@",url);
    NSData *data = [NSData dataWithContentsOfURL:url];
    UIImage *backgroundImage = [UIImage imageWithData:data];
	//UIImage *backgroundImage = [UIImage imageNamed:@"background.png"];
//    self.view.backgroundColor = [UIColor colorWithPatternImage:backgroundImage];
    CGRect backgroundRect = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.width/backgroundImage.size.width*backgroundImage.size.height);
    UIImageView *backgroundImageView = [[UIImageView alloc] initWithFrame:backgroundRect];
    backgroundImageView.image = backgroundImage;
    backgroundImageView.contentMode = UIViewContentModeScaleAspectFill;
    [self.view addSubview:backgroundImageView];
    
    ICommentView *icv = [[[NSBundle mainBundle]loadNibNamed:@"ICommentView" owner:self options:nil] objectAtIndex:0];
    icv.sName = [profileNameArray objectAtIndex:[[NSUserDefaults standardUserDefaults]integerForKey:@"cellTag"]-100];
    icv.sImgUrl = [profilePicArray objectAtIndex:[[NSUserDefaults standardUserDefaults]integerForKey:@"cellTag"]-100];
    icv.sComment = [photoTextArray objectAtIndex:[[NSUserDefaults standardUserDefaults]integerForKey:@"cellTag"]-100];
    CGRect textRect = CGRectMake(0, 0, self.view.frame.size.width, 380.0f);
    icv.frame = textRect;
    //[self.view addSubview:icv];
    
    /*
    textRect = CGRectMake(0, 0, self.view.frame.size.width, 200.0f);
    UITextView *textView = [[UITextView alloc] initWithFrame:textRect];
    NSString *text = [photoTextArray objectAtIndex:[[NSUserDefaults standardUserDefaults]integerForKey:@"cellTag"]-100];
    textView.text = text;
    textView.textAlignment = NSTextAlignmentCenter;
    textView.font = [UIFont systemFontOfSize:14.0f];
    textView.textColor = [UIColor darkTextColor];
    textView.editable = NO;
    */
        
    
    MDCParallaxView *parallaxView = [[MDCParallaxView alloc] initWithBackgroundView:nil
                                                                     foregroundView:icv];
    parallaxView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    parallaxView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    NSLog(@"----height = %f",backgroundImage.size.height);
    if (backgroundImage.size.height>400) {
        parallaxView.backgroundHeight = 220.0f;
    }else if (backgroundImage.size.height>200&&backgroundImage.size.height<=400)
    {
        parallaxView.backgroundHeight=backgroundImage.size.height-85;
    }else if(backgroundImage.size.height<=200)
    {
        parallaxView.backgroundHeight = backgroundImage.size.height;
    }

    parallaxView.scrollViewDelegate = self;
    [self.view addSubview:parallaxView];
	
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UIScrollViewDelegate Protocol Methods

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSLog(@"%@:%@", [self class], NSStringFromSelector(_cmd));
}

@end

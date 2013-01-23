//
//  MainViewController.m
//  IXiuTu
//
//  Created by shixiaolong on 13-1-15.
//  Copyright (c) 2013年 shixiaolong. All rights reserved.
//

#import "MainViewController.h"
#import "WaterFlowViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

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
//    self.navigationController.navigationBarHidden = YES;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navigationBar_bg.png"]  forBarMetrics:UIBarMetricsDefault];
    waterFlow = [[WaterFlowViewController alloc]init];
    waterFlow.tagDelegate = self;
    self.navigationItem.title = @"爱秀图";

    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"imageListBgView.png"]];
    
    UIButton *sportsButton = [UIButton buttonWithType:UIButtonTypeCustom];
    sportsButton.frame = CGRectMake(0, 0, 70, 25);
    sportsButton.center = CGPointMake(self.view.center.x-100, self.view.center.y-150);
    [sportsButton setBackgroundImage:[UIImage imageNamed:@"button_follow.png"] forState:UIControlStateNormal];
    [sportsButton setTitle:@"体育" forState:UIControlStateNormal];
    [sportsButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    sportsButton.titleLabel.font = [UIFont systemFontOfSize:13];
    sportsButton.tag = 100;
    [sportsButton addTarget:self action:@selector(buttonEvent:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:sportsButton];
    
    UIButton *eaterButton = [UIButton buttonWithType:UIButtonTypeCustom];
    eaterButton.frame = CGRectMake(0, 0, 70, 25);
    eaterButton.center = CGPointMake(self.view.center.x, self.view.center.y-150);
    [eaterButton setBackgroundImage:[UIImage imageNamed:@"button_follow.png"] forState:UIControlStateNormal];
    [eaterButton setTitle:@"吃货" forState:UIControlStateNormal];
    [eaterButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    eaterButton.titleLabel.font = [UIFont systemFontOfSize:13];
    eaterButton.tag = 101;
    [eaterButton addTarget:self action:@selector(buttonEvent:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:eaterButton];
    
    UIButton *carButton = [UIButton buttonWithType:UIButtonTypeCustom];
    carButton.frame = CGRectMake(0, 0, 70, 25);
    carButton.center = CGPointMake(self.view.center.x+100, self.view.center.y-150);
    [carButton setBackgroundImage:[UIImage imageNamed:@"button_follow.png"] forState:UIControlStateNormal];
    [carButton setTitle:@"名车" forState:UIControlStateNormal];
    [carButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    carButton.titleLabel.font = [UIFont systemFontOfSize:13];
    carButton.tag = 102;
    [carButton addTarget:self action:@selector(buttonEvent:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:carButton];
    
    UIButton *humorButton = [UIButton buttonWithType:UIButtonTypeCustom];
    humorButton.frame = CGRectMake(0, 0, 70, 25);
    humorButton.center = CGPointMake(self.view.center.x-100, self.view.center.y-100);
    [humorButton setBackgroundImage:[UIImage imageNamed:@"button_follow.png"] forState:UIControlStateNormal];
    [humorButton setTitle:@"幽默搞笑" forState:UIControlStateNormal];
    [humorButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    humorButton.titleLabel.font = [UIFont systemFontOfSize:13];
    humorButton.tag = 103;
    [humorButton addTarget:self action:@selector(buttonEvent:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:humorButton];
    
    UIButton *filmButton = [UIButton buttonWithType:UIButtonTypeCustom];
    filmButton.frame = CGRectMake(0, 0, 70, 25);
    filmButton.center = CGPointMake(self.view.center.x, self.view.center.y-100);
    [filmButton setBackgroundImage:[UIImage imageNamed:@"button_follow.png"] forState:UIControlStateNormal];
    [filmButton setTitle:@"影视" forState:UIControlStateNormal];
    [filmButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    filmButton.titleLabel.font = [UIFont systemFontOfSize:13];
    filmButton.tag = 104;
    [filmButton addTarget:self action:@selector(buttonEvent:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:filmButton];
    
    UIButton *shootButton = [UIButton buttonWithType:UIButtonTypeCustom];
    shootButton.frame = CGRectMake(0, 0, 70, 25);
    shootButton.center = CGPointMake(self.view.center.x+100, self.view.center.y-100);
    [shootButton setBackgroundImage:[UIImage imageNamed:@"button_follow.png"] forState:UIControlStateNormal];
    [shootButton setTitle:@"摄影" forState:UIControlStateNormal];
    [shootButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    shootButton.titleLabel.font = [UIFont systemFontOfSize:13];
    shootButton.tag = 105;
    [shootButton addTarget:self action:@selector(buttonEvent:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:shootButton];
    
    UIButton *fashionButton = [UIButton buttonWithType:UIButtonTypeCustom];
    fashionButton.frame = CGRectMake(0, 0, 70, 25);
    fashionButton.center = CGPointMake(self.view.center.x-100, self.view.center.y-50);
    [fashionButton setBackgroundImage:[UIImage imageNamed:@"button_follow.png"] forState:UIControlStateNormal];
    [fashionButton setTitle:@"时尚" forState:UIControlStateNormal];
    [fashionButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    fashionButton.titleLabel.font = [UIFont systemFontOfSize:13];
    fashionButton.tag = 106;
    [fashionButton addTarget:self action:@selector(buttonEvent:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:fashionButton];
    
    UIButton *starButton = [UIButton buttonWithType:UIButtonTypeCustom];
    starButton.frame = CGRectMake(0, 0, 70, 25);
    starButton.center = CGPointMake(self.view.center.x, self.view.center.y-50);
    [starButton setBackgroundImage:[UIImage imageNamed:@"button_follow.png"] forState:UIControlStateNormal];
    [starButton setTitle:@"明星" forState:UIControlStateNormal];
    [starButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    starButton.titleLabel.font = [UIFont systemFontOfSize:13];
    starButton.tag = 107;
    [starButton addTarget:self action:@selector(buttonEvent:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:starButton];
    
    UIButton *gamesButton = [UIButton buttonWithType:UIButtonTypeCustom];
    gamesButton.frame = CGRectMake(0, 0, 70, 25);
    gamesButton.center = CGPointMake(self.view.center.x+100, self.view.center.y-50);
    [gamesButton setBackgroundImage:[UIImage imageNamed:@"button_follow.png"] forState:UIControlStateNormal];
    [gamesButton setTitle:@"游戏" forState:UIControlStateNormal];
    [gamesButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    gamesButton.titleLabel.font = [UIFont systemFontOfSize:13];
    gamesButton.tag = 108;
    [gamesButton addTarget:self action:@selector(buttonEvent:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:gamesButton];
    
    UIButton *tecnologyButton = [UIButton buttonWithType:UIButtonTypeCustom];
    tecnologyButton.frame = CGRectMake(0, 0, 70, 25);
    tecnologyButton.center = CGPointMake(self.view.center.x-100, self.view.center.y);
    [tecnologyButton setBackgroundImage:[UIImage imageNamed:@"button_follow.png"] forState:UIControlStateNormal];
    [tecnologyButton setTitle:@"科技" forState:UIControlStateNormal];
    [tecnologyButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    tecnologyButton.titleLabel.font = [UIFont systemFontOfSize:13];
    tecnologyButton.tag = 109;
    [tecnologyButton addTarget:self action:@selector(buttonEvent:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:tecnologyButton];
    
    UIButton *beautyButton = [UIButton buttonWithType:UIButtonTypeCustom];
    beautyButton.frame = CGRectMake(0, 0, 70, 25);
    beautyButton.center = CGPointMake(self.view.center.x, self.view.center.y);
    [beautyButton setBackgroundImage:[UIImage imageNamed:@"button_follow.png"] forState:UIControlStateNormal];
    [beautyButton setTitle:@"美女" forState:UIControlStateNormal];
    [beautyButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    beautyButton.titleLabel.font = [UIFont systemFontOfSize:13];
    beautyButton.tag = 110;
    [beautyButton addTarget:self action:@selector(buttonEvent:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:beautyButton];
    
    UIButton *financeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    financeButton.frame = CGRectMake(0, 0, 70, 25);
    financeButton.center = CGPointMake(self.view.center.x+100, self.view.center.y);
    [financeButton setBackgroundImage:[UIImage imageNamed:@"button_follow.png"] forState:UIControlStateNormal];
    [financeButton setTitle:@"财经" forState:UIControlStateNormal];
    [financeButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    financeButton.titleLabel.font = [UIFont systemFontOfSize:13];
    financeButton.tag = 111;
    [financeButton addTarget:self action:@selector(buttonEvent:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:financeButton];
}

- (void)buttonEvent:(id)sender
{
    typeButton = (UIButton *)sender;
    [self.navigationController pushViewController:waterFlow animated:YES];
}

- (NSInteger)returnButtonTag
{
    return typeButton.tag;
}

- (NSString *)returnButtonTitle
{
    return typeButton.titleLabel.text;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

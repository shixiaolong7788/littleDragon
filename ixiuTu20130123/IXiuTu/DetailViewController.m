//
//  DetailViewController.m
//  IXiuTu
//
//  Created by shixiaolong on 13-1-22.
//  Copyright (c) 2013年 shixiaolong. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

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
    NSLog(@"middleArray = %@",middlePicArray);
    
    middleImageview = [[UIImageView alloc]initWithFrame:CGRectMake(20, 20, 260, 180)];
//    [middlePicArray release];
    
}

- (void)onReturn
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)viewWillAppear:(BOOL)animated
{
    NSString *urlString = [middlePicArray objectAtIndex:[[NSUserDefaults standardUserDefaults]integerForKey:@"cellTag"]-100];
    NSURL *url = [NSURL URLWithString:urlString];
    NSData *data = [NSData dataWithContentsOfURL:url];
    [middleImageview setImage:[UIImage imageWithData:data]];
    [self.view addSubview:middleImageview];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

//
//  WaterFlowViewController.m
//  IXiuTu
//
//  Created by shixiaolong on 13-1-16.
//  Copyright (c) 2013年 shixiaolong. All rights reserved.
//

#import "WaterFlowViewController.h"
#import "PhotoInfoPaser.h"
#import "SDWebImageManager.h"
#import "GHPushedViewController.h"

#pragma mark -
#pragma mark Private Interface
@interface WaterFlowViewController ()
- (void)pushViewController;
- (void)revealSidebar;
@end

@implementation WaterFlowViewController
@synthesize tagDelegate, photoTypeArray, thumbnailPicArray, middlePicArray, photoInfoResponse;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //self.title = [tagDelegate returnButtonTitle];
    //self.title = @"你们好";
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"imageListBgView.png"]];
    
    //UIButton *leftButton = [[UIButton alloc]init];
    //leftButton.frame = CGRectMake(0, 0, 60, 30);
    //[leftButton setBackgroundImage:[UIImage imageNamed:@"back_bar_item_bg.png"] forState:UIControlStateNormal];
//    NSString *titleStr = @"返回";
    //[leftButton setTitle:@"  返回" forState:UIControlStateNormal];
    //leftButton.titleLabel.font = [UIFont systemFontOfSize:14];
    //[leftButton addTarget:self action:@selector(onLeftButton) forControlEvents:UIControlEventTouchUpInside];
    //self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftButton];
    
    self.photoTypeArray = [[NSMutableArray alloc]init];
    self.thumbnailPicArray = [[NSMutableArray alloc]init];
    self.middlePicArray = [[NSMutableArray alloc]init];
    
    [self getPhotoClasstype:self.title page:@"1"];
    
    [self.photoTypeArray release];
    [self.thumbnailPicArray release];
    [self.middlePicArray release];
}

- (void)onLeftButton
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)getPhotoType
{
    NSString *str = @"http://joyer.sinaapp.com/api/type";
    NSURL *url = [NSURL URLWithString:str];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    
    [request setCompletionBlock:^{
        NSLog(@"responstring string = %@",[request responseString]);
        photoTypeResponsingString  = [request responseString];
        
        SBJSON *jsonParser = [[SBJSON alloc]init];
        NSMutableDictionary *rootString = [jsonParser objectWithString:photoTypeResponsingString error:nil];
        NSMutableArray *dataString = [rootString objectForKey:@"data"];
        
        for (photoTypeIndex=0; photoTypeIndex<[dataString count]; photoTypeIndex++) {
            NSDictionary *valueDic = [dataString objectAtIndex:photoTypeIndex];
            NSString *valueString = [valueDic objectForKey:@"value"];
            [self.photoTypeArray addObject:valueString];
        }
        NSLog(@"photoTypeArray = %@",self.photoTypeArray);
    }];
    
    [request setFailedBlock:^{
        NSLog(@"请求失败！");
    }];
    
    [request startAsynchronous];
}

- (void)getPhotoClasstype:(NSString *)classType page:(NSString *)page;
{
    NSLog(@"photoType -- Array = %@",self.photoTypeArray);
    NSLog(@"classtype = %@",classType);
    NSLog(@"page = %@",page);
    
    //    -------------------------表单提交-----------------------------------
    NSString *str = [NSString stringWithFormat:@"http://joyer.sinaapp.com/api/photo"];
    NSURL *url = [NSURL URLWithString:str];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    
    [request setPostValue:classType forKey:@"classtype"];
    [request setPostValue:page forKey:@"page"];
    
    [request setCompletionBlock:^{
        //        NSLog(@"responstring string = %@",[request responseString]);
        self.photoInfoResponse = [request responseString];
        NSError *error = [[NSError alloc]init];
        SBJSON *jsonParser = [[SBJSON alloc]init];
        NSMutableDictionary *rootString = [jsonParser objectWithString:self.photoInfoResponse error:&error];
        NSMutableArray *dataArray = [rootString objectForKey:@"data"];
        for (photoIndex = 0; photoIndex <[dataArray count]; photoIndex++) {
            
            NSDictionary *dataDic = [dataArray objectAtIndex:photoIndex];
            NSString *thumbnailPicString = [dataDic objectForKey:@"thumbnail_pic"];
            NSString *middlePicString = [dataDic objectForKey:@"bmiddle_pic"];
            
            [self.thumbnailPicArray addObject:thumbnailPicString];
            [self.middlePicArray addObject:middlePicString];
        }
//        NSLog(@"thumbNailPicArray = %@",self.thumbnailPicArray);
        //    NSLog(@"middlePicArray = %@",self.middlePicArray);
        
        [self photoFlowClass];
        
    }];
    [request setFailedBlock:^{
        NSLog(@"请求失败");
    }];
    [request startAsynchronous];
}

- (void)photoFlowClass
{
    PhotoFlowView *photoWall = [[PhotoFlowView alloc] initWithFrame:CGRectMake(0, 0, 320, 436) target:nil action:nil];
    [self.view addSubview:photoWall];
    [photoWall setContentInset:UIEdgeInsetsMake(0, 0, 40, 0)];
    NSLog(@"thumbNailPicArray = %@",self.thumbnailPicArray);
    NSMutableArray *arr = [NSMutableArray array];
    for (photoIndex=0; photoIndex<[self.thumbnailPicArray count]; photoIndex++) {
        
        NSURL *url = [NSURL URLWithString:[self.thumbnailPicArray objectAtIndex:photoIndex]];
        NSData *data = [NSData dataWithContentsOfURL:url];//载入数据
        UIImage *img = [UIImage imageWithData:data];

        [arr addObject:[NSArray arrayWithObjects:[NSNumber numberWithInt:img.size.height],[self.thumbnailPicArray objectAtIndex:photoIndex],nil]];
    }
    
    //模拟数据-----
    [photoWall setImages:arr];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}

#pragma mark Memory Management
- (id)initWithTitle:(NSString *)title withRevealBlock:(RevealBlock)revealBlock {
    if (self = [super initWithNibName:nil bundle:nil]) {
		self.title = title;
		_revealBlock = [revealBlock copy];
		self.navigationItem.leftBarButtonItem =
        [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction
                                                      target:self
                                                      action:@selector(revealSidebar)];
	}
	return self;
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

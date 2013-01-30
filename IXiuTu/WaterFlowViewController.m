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
@synthesize tagDelegate;
@synthesize photoTypeArray;
@synthesize thumbnailPicArray;
@synthesize middlePicArray;
@synthesize photoInfoResponse;
@synthesize profilePicArray;
@synthesize photoTextArray;
@synthesize profileNameArray;

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
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navigationBar_bg.png"] forBarMetrics:UIBarMetricsDefault];
    [self getPhotoClasstype:self.title page:@"1"];
    
    self.photoTypeArray = [[NSMutableArray alloc]init];
    self.thumbnailPicArray = [[NSMutableArray alloc]init];
    self.middlePicArray = [[NSMutableArray alloc]init];
    self.photoTextArray = [[NSMutableArray alloc]init];
    self.middlePicArrayImg = [[NSMutableArray alloc]init];
    self.profilePicArray = [[NSMutableArray alloc]init];
    self.profileNameArray = [[NSMutableArray alloc]init];
    
    [self.photoTypeArray release];
    [self.thumbnailPicArray release];
    [self.middlePicArray release];
    [self.photoTextArray release];
    [self.middlePicArrayImg release];
    [self.profilePicArray release];
    [self.profileNameArray release];
    
    
    detailVC = [[DetailViewController alloc]init];
    detailVC.arrayDelegate = self;
//    [detailVC release];
    
}

- (void)onLeftButton
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

//- (void)getPhotoType
//{
//    NSString *str = @"http://joyer.sinaapp.com/api/type";
//    NSURL *url = [NSURL URLWithString:str];
//    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
//    
//    [request setCompletionBlock:^{
//        NSLog(@"responstring string = %@",[request responseString]);
//        photoTypeResponsingString  = [request responseString];
//        
//        SBJSON *jsonParser = [[SBJSON alloc]init];
//        NSMutableDictionary *rootString = [jsonParser objectWithString:photoTypeResponsingString error:nil];
//        NSMutableArray *dataString = [rootString objectForKey:@"data"];
//        
//        for (photoTypeIndex=0; photoTypeIndex<[dataString count]; photoTypeIndex++) {
//            NSDictionary *valueDic = [dataString objectAtIndex:photoTypeIndex];
//            NSString *valueString = [valueDic objectForKey:@"value"];
//            [self.photoTypeArray addObject:valueString];
//        }
//        NSLog(@"photoTypeArray = %@",self.photoTypeArray);
//    }];
//    
//    [request setFailedBlock:^{
//        NSLog(@"请求失败！");
//    }];
//    
//    [request startAsynchronous];
//}

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
        self.photoInfoResponse = [request responseString];
        NSError *error = [[NSError alloc]init];
        SBJSON *jsonParser = [[SBJSON alloc]init];
        NSMutableDictionary *rootString = [jsonParser objectWithString:self.photoInfoResponse error:&error];
        NSMutableArray *dataArray = [rootString objectForKey:@"data"];
        for (photoIndex = 0; photoIndex <[dataArray count]; photoIndex++) {
            NSDictionary *dataDic = [dataArray objectAtIndex:photoIndex];
            NSString *thumbnailPicString = [dataDic objectForKey:@"thumbnail_pic"];
            NSString *middlePicString = [dataDic objectForKey:@"bmiddle_pic"];
            NSString *photoText = [dataDic objectForKey:@"text"];
            NSString *profilePicString = [dataDic objectForKey:@"profile_image_url"];
            NSString *profileNameString = [dataDic objectForKey:@"user_name"];
            [self.thumbnailPicArray addObject:thumbnailPicString];
            [self.middlePicArray addObject:middlePicString];
            [self.photoTextArray addObject:photoText];
            [self.profilePicArray addObject:profilePicString];
            [self.profileNameArray addObject:profileNameString];
            
        }
        NSUserDefaults *userDefault =  [NSUserDefaults standardUserDefaults];
        [userDefault setObject:self.thumbnailPicArray forKey:@"thumbnailPicArray"]; //缩略图
        [userDefault setObject:self.middlePicArray forKey:@"middlePicArray"];  //中型图片
        [userDefault setObject:self.photoTextArray forKey:@"photoTextArray"]; //图片文字
        [userDefault setObject:self.profilePicArray forKey:@"profilePicArray"]; //头像
        [userDefault setObject:self.profileNameArray forKey:@"profileNameArray"]; //头像
        [self photoFlowClass];
    }];
    
    [request setFailedBlock:^{
        NSLog(@"请求失败");
    }];
    
    [request startAsynchronous];
}

- (NSMutableArray *)returnMiddlepicarray
{
    NSLog(@"self.middlePicAeeay = %@",self.middlePicArray);
    return self.middlePicArray;
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
    photoWall.flowdelegate = self;
}

- (NSInteger)flowView:(PhotoFlowView *)flowView numberOfRowsInColumn:(NSInteger)column
{
    int i = self.thumbnailPicArray.count%3;
    int count = self.thumbnailPicArray.count/3;
    if(i!=0){
        if(i==1){
            if(column==0) count = count+1;
        }else {
            if(column==0||column==1) return count = count+1;
        }
    }else {
        return  count;
    }
    return count;
    
}

- (void)flowView:(PhotoFlowView *)flowView didSelectAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"BEI DIAN JI LA ");
    NSLog(@"indexpath.row = %d",indexPath.row);
    
    [self.navigationController pushViewController:detailVC animated:YES];
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
        
        UIButton *leftButton = [[UIButton alloc]init];
        leftButton.frame = CGRectMake(0, 0, 60, 30);
        [leftButton setBackgroundImage:[UIImage imageNamed:@"back_bar_item_bg.png"] forState:UIControlStateNormal];
        [leftButton setTitle:@"  返回" forState:UIControlStateNormal];
        leftButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [leftButton addTarget:self action:@selector(revealSidebar) forControlEvents:UIControlEventTouchUpInside];
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftButton];
        
//		self.navigationItem.leftBarButtonItem =
//        [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
//                                                      target:self
//                                                      action:@selector(revealSidebar)];
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

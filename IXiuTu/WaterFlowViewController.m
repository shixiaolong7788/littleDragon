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

@interface WaterFlowViewController ()

@end

@implementation WaterFlowViewController
@synthesize tagDelegate;

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
    self.title = [tagDelegate returnButtonTitle];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"imageListBgView.png"]];
    
    UIButton *leftButton = [[UIButton alloc]init];
    leftButton.frame = CGRectMake(0, 0, 60, 30);
    [leftButton setBackgroundImage:[UIImage imageNamed:@"back_bar_item_bg.png"] forState:UIControlStateNormal];
//    NSString *titleStr = @"返回";
    [leftButton setTitle:@"  返回" forState:UIControlStateNormal];
    leftButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [leftButton addTarget:self action:@selector(onLeftButton) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftButton];
    
    self.photoTypeArray = [[NSMutableArray alloc]init];
    self.thumbnailPicArray = [[NSMutableArray alloc]init];
    self.middlePicArray = [[NSMutableArray alloc]init];
    
    switch ([tagDelegate returnButtonTag]) {
        case 100:
            [self getPhotoClasstype:@"体育" page:@"1"];
            break;
        case 101:
            [self getPhotoClasstype:@"吃货" page:@"1"];
            break;
        case 102:
            [self getPhotoClasstype:@"名车" page:@"1"];
            break;
        case 103:
            [self getPhotoClasstype:@"幽默搞笑" page:@"1"];
            break;
        case 104:
            [self getPhotoClasstype:@"影视" page:@"1"];
            break;
        case 105:
            [self getPhotoClasstype:@"摄影" page:@"1"];
            break;
        case 106:
            [self getPhotoClasstype:@"时尚" page:@"1"];
            break;
        case 107:
            [self getPhotoClasstype:@"明星" page:@"1"];
            break;
        case 108:
            [self getPhotoClasstype:@"游戏" page:@"1"];
            break;
        case 109:
            [self getPhotoClasstype:@"科技" page:@"1"];
            break;
        case 110:
            [self getPhotoClasstype:@"美女" page:@"1"];
            break;
        case 111:
            [self getPhotoClasstype:@"财经" page:@"1"];
            break;
            
        default:
            break;
    }
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

@end

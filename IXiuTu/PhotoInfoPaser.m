//
//  PhotoInfoPaser.m
//  IXiuTu
//
//  Created by shixiaolong on 13-1-14.
//  Copyright (c) 2013年 shixiaolong. All rights reserved.
//

#import "PhotoInfoPaser.h"

@interface PhotoInfoPaser ()

@end

@implementation PhotoInfoPaser
@synthesize photoInfoResponse,photoTypeArray,thumbnailPicArray,middlePicArray;


static PhotoInfoPaser *phototInstance;
+ (id) sharedInstance
{
    @synchronized([PhotoInfoPaser class])
    {
        if (phototInstance == nil) {
            phototInstance = [[PhotoInfoPaser alloc]init];
        }
    }
    return phototInstance;
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
    
    
    self.photoTypeArray = [[NSMutableArray alloc]init];
    self.thumbnailPicArray = [[NSMutableArray alloc]init];
    self.middlePicArray = [[NSMutableArray alloc]init];
    [self getPhotoType];
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
            [self getPhotoClasstype:[self.photoTypeArray objectAtIndex:photoTypeIndex] page:@"1"];
            NSLog(@"photoTypeIndex = %d",photoTypeIndex);
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
        [self photoInfoParser];
    }];
    [request setFailedBlock:^{
        NSLog(@"请求失败");
    }];
    [request startAsynchronous];
}

- (void)photoInfoParser
{
//    NSLog(@"photoInfoResponse = %@",self.photoInfoResponse);
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
    NSLog(@"thumbNailPicArray = %@",self.thumbnailPicArray);
    NSLog(@"middlePicArray = %@",self.middlePicArray);
}

- (NSArray *)getPhotoArrayClasstype:(NSString *)classTypeNew page:(NSString *)pageNew;
{
    [self getPhotoClasstype:classTypeNew page:pageNew];
    return self.thumbnailPicArray;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

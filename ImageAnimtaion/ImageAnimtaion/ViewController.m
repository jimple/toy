//
//  ViewController.m
//  ImageAnimtaion
//
//  Created by jimple on 14/11/21.
//  Copyright (c) 2014年 JimpleChen. All rights reserved.
//

#import "ViewController.h"
#import "ImageViewAnimationHelper.h"

@interface ViewController ()


@property (nonatomic, strong) UIImageView *imgView;
@property (nonatomic, strong) UIImageView *imgView2;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    _imgView = [ImageViewAnimationHelper showAnimationImgInView:self.view withFrame:CGRectMake(100.0f, 100.0f, 91.0f, 73.0f) imgType:kEImgAnimationTypeNoBirth];
    
    double delay = 1;
    for (int i = kEImgAnimationTypeNoBirth; i <= kEImgAnimationType24Month5Start; i++)
    {
        dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC));
        dispatch_after(delayTime, dispatch_get_main_queue(), ^(void){
            [self showByType:i];
        });
        
        delay += 3;
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)showByType:(EImgAnimationType)type
{
    if (_imgView2)
    {
        [_imgView2 removeFromSuperview];
        _imgView2 = nil;
    }else{}
    
    _imgView2 = [ImageViewAnimationHelper showAnimationImgInView:self.view withFrame:CGRectMake(100.0f, 300.0f, 91.0f, 73.0f) imgType:type];
}




@end

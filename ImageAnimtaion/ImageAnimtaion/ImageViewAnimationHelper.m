//
//  ImageViewAnimationHelper.m
//  ImageAnimtaion
//
//  Created by jimple on 14/11/21.
//  Copyright (c) 2014年 JimpleChen. All rights reserved.
//

#import "ImageViewAnimationHelper.h"

@implementation ImageViewAnimationHelper


+ (UIImageView *)showAnimationImgInView:(UIView *)parentView
                              withFrame:(CGRect)imgViewFrame
                                imgType:(EImgAnimationType)imgType
{
    NSArray *imgArr = [self.class imgArrayByType:imgType];
    UIImageView *imgView;
    
    if (imgArr && (imgArr.count > 0))
    {
        imgView = [[UIImageView alloc] initWithImage:imgArr[0]];
        
        imgView.animationImages = imgArr;
        imgView.animationDuration = 0.8;
        imgView.animationRepeatCount = 0;
        [imgView startAnimating];
        
        imgView.frame = imgViewFrame;
        
        if (parentView)
        {
            [parentView addSubview:imgView];
        }else{}
    }else{/* ! Assert */}
    
    return imgView;
}

+ (NSArray *)imgArrayByType:(EImgAnimationType)imgType
{
    NSArray *imgArr;
    switch (imgType)
    {
        case kEImgAnimationTypeNoBirth:
        {
            imgArr = @[[UIImage imageNamed:@"还没有出世表情1"], [UIImage imageNamed:@"还没有出世表情2"]];
        }
            break;
            
        case kEImgAnimationType0Month0Start:
        {
            imgArr = @[[UIImage imageNamed:@"0-6月零星表情1"], [UIImage imageNamed:@"0-6月零星表情2"]];
        }
            break;
        case kEImgAnimationType0Month3Start:
        {
            imgArr = @[[UIImage imageNamed:@"0-6月平时表情"], [UIImage imageNamed:@"0-6月三星-三星半表情"]];
        }
            break;
        case kEImgAnimationType0Month4Start:
        {
            imgArr = @[[UIImage imageNamed:@"0-6月平时表情"], [UIImage imageNamed:@"0-6月四星-四星半表情"]];
        }
            break;
        case kEImgAnimationType0Month5Start:
        {
            imgArr = @[[UIImage imageNamed:@"0-6月平时表情"], [UIImage imageNamed:@"0-6月五星-五星半表情"]];
        }
            break;
        case kEImgAnimationType6Month0Start:
        {
            imgArr = @[[UIImage imageNamed:@"6-12月零星表情1"], [UIImage imageNamed:@"6-12月零星表情2"]];
        }
            break;
        case kEImgAnimationType6Month3Start:
        {
            imgArr = @[[UIImage imageNamed:@"6-12月平时表情"], [UIImage imageNamed:@"6-12月三星-三星半表情"]];
        }
            break;
        case kEImgAnimationType6Month4Start:
        {
            imgArr = @[[UIImage imageNamed:@"6-12月平时表情"], [UIImage imageNamed:@"6-12月四星-四星半表情"]];
        }
            break;
        case kEImgAnimationType6Month5Start:
        {
            imgArr = @[[UIImage imageNamed:@"6-12月平时表情"], [UIImage imageNamed:@"6-12月五星-五星半表情"]];
        }
            break;
        case kEImgAnimationType12Month0Start:
        {
            imgArr = @[[UIImage imageNamed:@"12-18月零星表情1"], [UIImage imageNamed:@"12-18月零星表情2"]];
        }
            break;
        case kEImgAnimationType12Month3Start:
        {
            imgArr = @[[UIImage imageNamed:@"12-18月平时表情"], [UIImage imageNamed:@"12-18月三星-三星半表情"]];
        }
            break;
        case kEImgAnimationType12Month4Start:
        {
            imgArr = @[[UIImage imageNamed:@"12-18月平时表情"], [UIImage imageNamed:@"12-18月四星-四星半表情"]];
        }
            break;
        case kEImgAnimationType12Month5Start:
        {
            imgArr = @[[UIImage imageNamed:@"12-18月平时表情"], [UIImage imageNamed:@"12-18月五星-五星半表情"]];
        }
            break;
        case kEImgAnimationType18Month0Start:
        {
            imgArr = @[[UIImage imageNamed:@"18-24月零星表情1"], [UIImage imageNamed:@"18-24月零星表情2"]];
        }
            break;
        case kEImgAnimationType18Month3Start:
        {
            imgArr = @[[UIImage imageNamed:@"18-24月平时表情"], [UIImage imageNamed:@"18-24月三星-三星半表情"]];
        }
            break;
        case kEImgAnimationType18Month4Start:
        {
            imgArr = @[[UIImage imageNamed:@"18-24月平时表情"], [UIImage imageNamed:@"18-24月四星-四星半表情"]];
        }
            break;
        case kEImgAnimationType18Month5Start:
        {
            imgArr = @[[UIImage imageNamed:@"18-24月平时表情"], [UIImage imageNamed:@"18-24月五星-五星半表情"]];
        }
            break;  
        case kEImgAnimationType24Month0Start:
        {
            imgArr = @[[UIImage imageNamed:@"24月零星表情1"], [UIImage imageNamed:@"24月零星表情2"]];
        }
            break;
        case kEImgAnimationType24Month3Start:
        {
            imgArr = @[[UIImage imageNamed:@"24月平时表情"], [UIImage imageNamed:@"24月三星-三星半表情"]];
        }
            break;
        case kEImgAnimationType24Month4Start:
        {
            imgArr = @[[UIImage imageNamed:@"24月平时表情"], [UIImage imageNamed:@"24月四星-四星半表情"]];
        }
            break;
        case kEImgAnimationType24Month5Start:
        {
            imgArr = @[[UIImage imageNamed:@"24月平时表情"], [UIImage imageNamed:@"24月五星-五星半表情"]];
        }
            break;    
        default:
            break;
    }
    return imgArr;
}






@end

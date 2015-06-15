//
//  ImageViewAnimationHelper.h
//  ImageAnimtaion
//
//  Created by jimple on 14/11/21.
//  Copyright (c) 2014年 JimpleChen. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, EImgAnimationType)
{
    // 未出生
    kEImgAnimationTypeNoBirth = 1,
    
    // 0-6
    kEImgAnimationType0Month0Start,
    kEImgAnimationType0Month3Start,
    kEImgAnimationType0Month4Start,
    kEImgAnimationType0Month5Start,
    
    // 6-12
    kEImgAnimationType6Month0Start,
    kEImgAnimationType6Month3Start,
    kEImgAnimationType6Month4Start,
    kEImgAnimationType6Month5Start,
    
    // 12-18
    kEImgAnimationType12Month0Start,
    kEImgAnimationType12Month3Start,
    kEImgAnimationType12Month4Start,
    kEImgAnimationType12Month5Start,
    
    // 18-24
    kEImgAnimationType18Month0Start,
    kEImgAnimationType18Month3Start,
    kEImgAnimationType18Month4Start,
    kEImgAnimationType18Month5Start,
    
    // 24+
    kEImgAnimationType24Month0Start,
    kEImgAnimationType24Month3Start,
    kEImgAnimationType24Month4Start,
    kEImgAnimationType24Month5Start,
};


@interface ImageViewAnimationHelper : NSObject

+ (UIImageView *)showAnimationImgInView:(UIView *)parentView
                              withFrame:(CGRect)imgViewFrame
                                imgType:(EImgAnimationType)imgType;




@end

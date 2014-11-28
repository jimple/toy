//
//  JCAdsorbScrollViewHelper.m
//  JCAdsorbScrollView
//
//  Created by jimple on 14/11/17.
//  Copyright (c) 2014年 JimpleChen. All rights reserved.
//

#import "JCAdsorbScrollViewHelper.h"

typedef NS_ENUM(NSInteger, EJCAbsorbType)
{
    kEJCAbsorbTypeNearbyPoint               = 0,
    kEJCAbsorbTypePointInDirectionOfMotion,
};


@interface JCAdsorbScrollViewHelper ()

@property (nonatomic, strong) NSArray *xValueArray;
@property (nonatomic, assign) BOOL scrlToOriginPoint;
@property (nonatomic, assign) CGFloat lastXOffset;
@property (nonatomic, assign) EJCAbsorbType absorbToPointType;
@property (nonatomic, assign) BOOL isAdsorbAnimation;
@property (nonatomic, assign) BOOL canScrlAwayBorder;       // 滚动超过边界后是否可继续向前进方向滚动
@property (nonatomic, assign) CGFloat deltaDistanceToAdsorbForScrlAwayBorder;

@end

@implementation JCAdsorbScrollViewHelper

- (instancetype)initWithXValues:(NSArray *)xValueArray
    isAdsorbToDirectionOfMotion:(BOOL)adsorbToDirecOfMotion
              isAdsorbAnimation:(BOOL)isAdsorbAnimation
{
    self = [super init];
    if (self)
    {
        _xValueArray = [NSArray arrayWithArray:xValueArray];
        _isAdsorbAnimation = isAdsorbAnimation;
        
        _scrlToOriginPoint = YES;
        _lastXOffset = 0.0f;
        _canScrlAwayBorder = YES;
        _deltaDistanceToAdsorbForScrlAwayBorder = 20.0f;
        
        _absorbToPointType = adsorbToDirecOfMotion ? kEJCAbsorbTypePointInDirectionOfMotion : kEJCAbsorbTypeNearbyPoint;
    }else{}
    return self;
}

- (void)dealloc
{
    
}

- (void)changeDeltaDistanceToAdsorbForScrlAwayBorder:(CGFloat)delta
{
    _deltaDistanceToAdsorbForScrlAwayBorder = fabsf(delta);
}

- (void)changeCanScrlAwayBorderState:(BOOL)canScrlAway
{
    _canScrlAwayBorder = canScrlAway;
}

#pragma mark - UIScrollView
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    _scrlToOriginPoint = ((scrollView.contentOffset.x -_lastXOffset) <= 0.0f);
    _lastXOffset = scrollView.contentOffset.x;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    _lastXOffset = scrollView.contentOffset.x;
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (!decelerate)
    {
        [self scrollView:scrollView adsorbToPointForDirectionOfMotion:_scrlToOriginPoint];
    }else{}
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self scrollView:scrollView adsorbToPointForDirectionOfMotion:_scrlToOriginPoint];
}

#pragma mark -

- (void)scrollView:(UIScrollView *)scrollView adsorbToPointForDirectionOfMotion:(BOOL)scrlToOriginPoint
{
    dispatch_async(dispatch_get_main_queue(), ^{
        CGPoint pt = scrollView.contentOffset;
        NSInteger indexOfXValueArray = -1;
        CGFloat adsorbPointX = -1;
        
        CGFloat cursorXOffset = 0.0f;
        if (self.getCursorXOffsetHandler)
        {
            cursorXOffset = self.getCursorXOffsetHandler();
        }else{}
        
        NSArray *retArr;
        switch (_absorbToPointType)
        {
            case kEJCAbsorbTypeNearbyPoint:
            {
                retArr = [self nearbyXValueWithSrcX:(scrollView.contentOffset.x + cursorXOffset)];
            }
                break;
            case kEJCAbsorbTypePointInDirectionOfMotion:
            {
                retArr = [self nearbyXValueWithSrcX:(scrollView.contentOffset.x + cursorXOffset)
                                 directionOfMontion:scrlToOriginPoint];
            }
                break;
            default:
                break;
        }
        
        if (retArr && (retArr.count >= 2))
        {
            adsorbPointX = ((NSNumber *)retArr[0]).floatValue;
            indexOfXValueArray = ((NSNumber *)retArr[1]).integerValue;
            
            if (indexOfXValueArray >= 0)
            {
                pt.x = adsorbPointX - cursorXOffset;
                BOOL isScrlToOffset = NO;
                if (pt.x >= 0)  // < 0 的不移动
                {
                    [scrollView setContentOffset:pt animated:_isAdsorbAnimation];
                    isScrlToOffset = YES;
                }else{}
                
                if (self.adsorbToPointHandler)
                {
                    self.adsorbToPointHandler(indexOfXValueArray, pt.x, adsorbPointX, isScrlToOffset);
                }else{}
            }else{}
        }else{/* ! assert */}
    });
}

// 吸附到当前点前后最近的一个点
// 返回数组 [0]＝吸附到x轴位置，[1]＝吸附位置对应的xValueArray的数组下标（<0表示吸附点不在数组上）
- (NSArray *)nearbyXValueWithSrcX:(CGFloat)srcX
{
    CGFloat retX = srcX;
    NSInteger retIndex = -1;
    if (_xValueArray && (_xValueArray.count > 0))
    {
        retIndex = 0;
        CGFloat lastX = ((NSNumber *)_xValueArray[retIndex]).doubleValue;
        
        for (int i = 0; i < _xValueArray.count; i++)
        {
            CGFloat x = ((NSNumber *)_xValueArray[i]).doubleValue;
            if (srcX < x)
            {
                break;
            }else{}
            lastX = x;
            retIndex = i;
        }
        
        if (retIndex == 0)
        {
            retX = lastX;
        }
        else if (retIndex == (_xValueArray.count - 1))
        {
            retX = lastX;
        }
        else
        {
            CGFloat preX = lastX;
            CGFloat nextX = ((NSNumber *)_xValueArray[retIndex+1]).doubleValue;
            CGFloat preXDelta = fabs(srcX - preX);
            CGFloat nextXDelta = fabs(nextX - srcX);
            
            if (preXDelta > nextXDelta)
            {
                retX = nextX;
                retIndex += 1;
            }
            else
            {
                retX = preX;
            }
        }
        
    }else{}
    
    return @[@(retX), @(retIndex)];
}


// 吸附到运动方向上的下一个点
// 返回数组 [0]＝吸附到x轴位置，[1]＝吸附位置对应的xValueArray的数组下标（<0表示吸附点不在数组上）
- (NSArray *)nearbyXValueWithSrcX:(CGFloat)srcX directionOfMontion:(BOOL)scrlToOriginPoint
{
    CGFloat retX = srcX;
    NSInteger retIndex = -1;
    if (_xValueArray && (_xValueArray.count > 0))
    {
        retIndex = (_scrlToOriginPoint ? 0 : (_xValueArray.count-1));
        CGFloat lastX = ((NSNumber *)_xValueArray[retIndex]).doubleValue;
        
        if (scrlToOriginPoint)
        {
            for (int i = 0; i < _xValueArray.count; i++)
            {
                CGFloat x = ((NSNumber *)_xValueArray[i]).doubleValue;
                if (srcX < x)
                {
                    break;
                }else{}
                lastX = x;
                retIndex = i;
            }
        }
        else
        {
            for (long i = (_xValueArray.count - 1); i >= 0; i--)
            {
                CGFloat x = ((NSNumber *)_xValueArray[i]).doubleValue;
                if (srcX >= x)
                {
                    break;
                }else{}
                lastX = x;
                retIndex = i;
            }
        }
        
        retX = lastX;
        
        if (_canScrlAwayBorder)
        {
            // 超过边界一定距离后不自动吸附
            if (retIndex == 0)
            {
                if ((retX - srcX) > _deltaDistanceToAdsorbForScrlAwayBorder)
                {
                    retX = srcX;
                    retIndex = -1;
                }else{}
            }
            else if (retIndex == (_xValueArray.count - 1))
            {
                if ((srcX - retX) > _deltaDistanceToAdsorbForScrlAwayBorder)
                {
                    retX = srcX;
                    retIndex = -1;
                }else{}
            }else{}
        }else{}
    }else{}
    
    return @[@(retX), @(retIndex)];
}








































@end
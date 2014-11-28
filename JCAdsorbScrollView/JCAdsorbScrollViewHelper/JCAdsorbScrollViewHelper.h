//
//  JCAdsorbScrollViewHelper.h
//  JCAdsorbScrollView
//
//  Created by jimple on 14/11/17.
//  Copyright (c) 2014年 JimpleChen. All rights reserved.
//

#import <Foundation/Foundation.h>

// 输出吸附到的目标点在数组中的序号、滚动位置x坐标值、吸附点位置
typedef void(^JCAdsorbScrollViewHelperAdsorbToPoint) (NSInteger indexOfXValueArray, CGFloat scrolContentOffsetX, CGFloat adsorbPointX, BOOL isScrlToOffsetX);
typedef CGFloat(^JCAdsorbScrollViewHelperGetCursorXOffset) ();

@interface JCAdsorbScrollViewHelper : NSObject

@property (nonatomic, copy) JCAdsorbScrollViewHelperAdsorbToPoint adsorbToPointHandler;
@property (nonatomic, copy) JCAdsorbScrollViewHelperGetCursorXOffset getCursorXOffsetHandler;

// ! 适用范围：现在默认输入的xValueArray是按顺序，从小到大排序的。

// 输入：
// 1、可吸附点的x坐标数组。
// 2、吸附位置（刻度线）相对于scroll view左侧的位置。
// 3、吸附方式：YES吸附到滚动方向的下一个点，NO吸附到当前位置前后最近的点
- (instancetype)initWithXValues:(NSArray *)xValueArray
    isAdsorbToDirectionOfMotion:(BOOL)adsorbToDirecOfMotion
              isAdsorbAnimation:(BOOL)isAdsorbAnimation;

- (void)changeDeltaDistanceToAdsorbForScrlAwayBorder:(CGFloat)delta;
- (void)changeCanScrlAwayBorderState:(BOOL)canScrlAway;


// scroll view需在delegate里调用这些接口
- (void)scrollViewDidScroll:(UIScrollView *)scrollView;
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView;
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate;
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView;









@end

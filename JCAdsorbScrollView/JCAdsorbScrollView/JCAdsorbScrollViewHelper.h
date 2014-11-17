//
//  JCAdsorbScrollViewHelper.h
//  JCAdsorbScrollView
//
//  Created by jimple on 14/11/17.
//  Copyright (c) 2014年 JimpleChen. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface JCAdsorbScrollViewHelper : NSObject

// 输入：1、可吸附点的x坐标数组。2、吸附位置（刻度线）相对于scroll view左侧的位置。
// 吸附方式不是按刻度线左右两点最近的吸附，而是按滚动方向吸附到滚动方向的下一个点。
- (instancetype)initWithXValues:(NSArray *)xValueArray cursorXOffset:(CGFloat)cursorXOffset;

// scroll view需在delegate里调用这些接口
- (void)scrollViewDidScroll:(UIScrollView *)scrollView;
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView;
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate;
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView;









@end

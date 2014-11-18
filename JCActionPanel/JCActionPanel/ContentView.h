//
//  ContentView.h
//  JCActionPanel
//
//  Created by jimple on 14/11/18.
//  Copyright (c) 2014年 JimpleChen. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void(^ContentViewCancel)();
typedef void(^ContentViewSelectedBtn)(NSString *btnName);


@interface ContentView : UIView

@property (nonatomic, copy) ContentViewCancel cancelHandler;
@property (nonatomic, copy) ContentViewSelectedBtn selectedBtnHandler;


+ (instancetype)createViewFromXIB;




@end

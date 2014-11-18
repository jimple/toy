//
//  JCActionPanel.h
//  JCActionPanel
//
//  Created by jimple on 14/11/18.
//  Copyright (c) 2014年 JimpleChen. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^JCActionPanelClosed)();

@interface JCActionPanel : UIView

+ (JCActionPanel *)createPanelWithContentView:(UIView *)contentView
                                 closeHandler:(JCActionPanelClosed)closeHandler;

- (void)dismissActionPanel;



@end

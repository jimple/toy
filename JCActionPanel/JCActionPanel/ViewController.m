//
//  ViewController.m
//  JCActionPanel
//
//  Created by jimple on 14/11/18.
//  Copyright (c) 2014年 JimpleChen. All rights reserved.
//

#import "ViewController.h"
#import "JCActionPanel.h"
#import "ContentView.h"

@interface ViewController ()

@property (nonatomic, strong) JCActionPanel *actionPanel;
@property (nonatomic, strong) ContentView *contentView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)showBtn:(id)sender
{
    __weak typeof(self)weakSelf = self;
    
    _contentView = [ContentView createViewFromXIB];
    _contentView.cancelHandler = ^()    // 点取消按钮
    {
        __strong typeof(weakSelf)strongSelf = weakSelf;
        [strongSelf.actionPanel dismissActionPanel];
        strongSelf.actionPanel = nil;
    };
    _contentView.selectedBtnHandler = ^(NSString *btnName)  // 点上部的四个按钮
    {
        NSLog(@" ==== btn pressed [%@]", btnName);
        
        __strong typeof(weakSelf)strongSelf = weakSelf;
        [strongSelf.actionPanel dismissActionPanel];
        strongSelf.actionPanel = nil;
    };
    
    _actionPanel = [JCActionPanel createPanelWithContentView:_contentView closeHandler:^{
        __strong typeof(weakSelf)strongSelf = weakSelf;
        strongSelf.actionPanel = nil;
    }];
    
}































@end

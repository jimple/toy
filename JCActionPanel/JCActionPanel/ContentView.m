//
//  ContentView.m
//  JCActionPanel
//
//  Created by jimple on 14/11/18.
//  Copyright (c) 2014年 JimpleChen. All rights reserved.
//

#import "ContentView.h"

@implementation ContentView

+ (instancetype)createViewFromXIB
{
    id view;
    NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"ContentView" owner:self options:nil];
    NSAssert((nib && (nib.count > 0)), @" ! can not find nib file.\n\nxib file name is not the same as class name?\n");
    view = [nib objectAtIndex:0];
    
    return view;
}

- (IBAction)cancelBtn:(id)sender
{
    if (self.cancelHandler)
    {
        self.cancelHandler();
    }else{}
}

- (IBAction)ABtn:(id)sender
{
    if (self.selectedBtnHandler)
    {
        self.selectedBtnHandler(@"A");
    }else{}
}
- (IBAction)BBtn:(id)sender
{
    if (self.selectedBtnHandler)
    {
        self.selectedBtnHandler(@"B");
    }else{}
}
- (IBAction)CBtn:(id)sender
{
    if (self.selectedBtnHandler)
    {
        self.selectedBtnHandler(@"C");
    }else{}
}
- (IBAction)DBtn:(id)sender
{
    if (self.selectedBtnHandler)
    {
        self.selectedBtnHandler(@"D");
    }else{}
}
















@end

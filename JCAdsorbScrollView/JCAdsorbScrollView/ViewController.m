//
//  ViewController.m
//  JCAdsorbScrollView
//
//  Created by jimple on 14/11/17.
//  Copyright (c) 2014年 JimpleChen. All rights reserved.
//

#import "ViewController.h"
#import "JCLineChartView.h"
#import "JCLineData.h"
#import "JCAdsorbScrollViewHelper.h"


@interface ViewController ()
<UIScrollViewDelegate>


@property (nonatomic, weak) IBOutlet UIScrollView *scrlView;
@property (nonatomic, strong) JCLineChartView *chartView;
//@property (nonatomic, strong) NSArray *xValue;
//@property (nonatomic, assign) BOOL scrlToOrigin;
//@property (nonatomic, assign) CGPoint lastContentOffset;
@property (nonatomic, strong) JCAdsorbScrollViewHelper *adsorbScrlViewHelper;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self commonInit];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)commonInit
{
    self.scrlView.delegate = self;
    
    CGRect rcChartView = self.scrlView.bounds;
    rcChartView.size.width = 900.0f;
    _chartView = [[JCLineChartView alloc] initWithFrame:rcChartView];
    _chartView.backgroundColor = [UIColor colorWithWhite:0.95f alpha:1.0f];
    [self.scrlView addSubview:_chartView];
    
    self.scrlView.contentSize = _chartView.bounds.size;
    
    NSArray *xValue = @[@(210.0f), @(230.0f), @(240.0f), @(270.0f), @(290.0f), @(310.0f), @(320.0f), @(360.0f), @(380.0f), @(385.0f), @(390.0f), @(400.0f), @(420.0f), @(430.0f), @(450.0f), @(460.0f), @(480.0f), @(485.0f), @(490.0f), @(500.0f), @(520.0f), @(530.0f), @(550.0f), @(560.0f), @(580.0f), @(585.0f), @(600.0f), @(630.0f), @(650.0f), @(660.0f), @(690.0f), @(700.0f)];
    NSArray *yValue = @[@(40.0f), @(30.0f), @(35.0f), @(50.0f), @(55.0f), @(55.0f), @(70.0f), @(100.0f), @(110.0f), @(110.0f), @(120.0f), @(150.0f), @(130.0f), @(125.0f), @(130.0f), @(100.0f), @(110.0f), @(110.0f), @(120.0f), @(150.0f), @(130.0f), @(125.0f), @(130.0f), @(100.0f), @(110.0f), @(110.0f), @(120.0f), @(150.0f), @(130.0f), @(125.0f), @(130.0f), @(100.0f)];
    
    JCLineData *lineData = [[JCLineData alloc] init];
    lineData.lineColor = [UIColor blueColor];
    lineData.lineWidth = 1.0f;
    lineData.cyclePointWidth = 4.0f;
    lineData.pointStyle = kEJCLinePointStyleCycle;
    lineData.pointCount = xValue.count;
    lineData.getPointValue = ^CGPoint(NSUInteger index)
    {
        return CGPointMake([xValue[index] doubleValue], [yValue[index] doubleValue]);
    };
    
    [_chartView showLines:@[lineData] withChartBound:_chartView.bounds];

    
//    // autolayout
//    _chartView.translatesAutoresizingMaskIntoConstraints = NO;
//    
//    [self.scrlView addConstraints:@[
//                                [NSLayoutConstraint constraintWithItem:_chartView
//                                                             attribute:NSLayoutAttributeLeft
//                                                             relatedBy:NSLayoutRelationEqual
//                                                                toItem:self.scrlView
//                                                             attribute:NSLayoutAttributeLeft
//                                                            multiplier:1.0
//                                                              constant:0],
//                                
//                                [NSLayoutConstraint constraintWithItem:_chartView
//                                                             attribute:NSLayoutAttributeTop
//                                                             relatedBy:NSLayoutRelationEqual
//                                                                toItem:self.scrlView
//                                                             attribute:NSLayoutAttributeTop
//                                                            multiplier:1
//                                                              constant:0],
//                                ]];
//    [_chartView addConstraints:@[
//                                 [NSLayoutConstraint constraintWithItem:_chartView
//                                                              attribute:NSLayoutAttributeHeight
//                                                              relatedBy:NSLayoutRelationEqual
//                                                                 toItem:nil
//                                                              attribute:NSLayoutAttributeNotAnAttribute
//                                                             multiplier:1
//                                                               constant:_chartView.bounds.size.height],
//                                 
//                                 [NSLayoutConstraint constraintWithItem:_chartView
//                                                              attribute:NSLayoutAttributeWidth
//                                                              relatedBy:NSLayoutRelationEqual
//                                                                 toItem:nil
//                                                              attribute:NSLayoutAttributeNotAnAttribute
//                                                             multiplier:1
//                                                               constant:_chartView.bounds.size.width],
//                                 ]];
    
    
    
    
    // 创建helper。输入曲线x坐标数组，刻度线相对于scroll view左侧的位置。
    // scroll view的委托里调用helper的接口即可。
    self.scrlView.decelerationRate = 0.0f;
    _adsorbScrlViewHelper = [[JCAdsorbScrollViewHelper alloc] initWithXValues:xValue
                                                                cursorXOffset:[[UIScreen mainScreen] bounds].size.width/2.0f
                                                  isAdsorbToDirectionOfMotion:YES];
    _adsorbScrlViewHelper.adsorbToPointHandler = ^(NSInteger indexOfXValueArray, CGFloat scrolContentOffsetX, CGFloat adsorbPointX)
    {
        NSLog(@"\n\n=======\n吸附点在数组中的序号：%ld  滚动x轴位移：%f  吸附位置：%f\n\n", (long)indexOfXValueArray, scrolContentOffsetX, adsorbPointX);
    };

}

#pragma mark - UIScrollView
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [_adsorbScrlViewHelper scrollViewDidScroll:scrollView];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [_adsorbScrlViewHelper scrollViewWillBeginDragging:scrollView];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [_adsorbScrlViewHelper scrollViewDidEndDragging:scrollView willDecelerate:decelerate];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [_adsorbScrlViewHelper scrollViewDidEndDecelerating:scrollView];
}











































@end

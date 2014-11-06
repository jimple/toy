//
//  ViewController.m
//  JCComplexTableHeader
//
//  Created by jimple on 14/11/4.
//  Copyright (c) 2014年 JimpleChen. All rights reserved.
//

#import "ViewController.h"




@interface ViewController ()
<
    UITableViewDataSource,
    UITableViewDelegate
>

#pragma mark - table view header panel
@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, weak) IBOutlet UIView *headerPanel;
@property (nonatomic, weak) IBOutlet UIView *headerTopPanel;
@property (nonatomic, weak) IBOutlet UIView *headerBottomPanel;
@property (nonatomic, weak) IBOutlet UIButton *leftBtn;
@property (nonatomic, weak) IBOutlet NSLayoutConstraint *headerPanelHeightConstraint;
@property (nonatomic, weak) IBOutlet NSLayoutConstraint *headerTopPanelTopConstraint;

@property (nonatomic, assign) CGFloat topOriginal;
@property (nonatomic, assign) CGFloat topMin;
@property (nonatomic, assign) CGFloat headerTopPanelHeight;
@property (nonatomic, assign) CGFloat headerBottomPanelHeight;
@property (nonatomic, assign) CGFloat headerPanelHeightOrigin;
@property (nonatomic, assign) CGFloat headerPanelHeightMin;
@property (nonatomic, assign) CGFloat headerPanelHeightDelta;
@property (nonatomic, assign) CGFloat talbeViewContentOffsetYOrigin;


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
    [self initTabelHeaderPanel];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
}

- (void)initTabelHeaderPanel
{
    _headerTopPanelHeight = self.headerTopPanel.bounds.size.height;
    _headerBottomPanelHeight = self.headerBottomPanel.bounds.size.height;
    
    _topOriginal = self.headerTopPanelTopConstraint.constant;
    _topMin = _topOriginal - _headerTopPanelHeight;
    
    _headerPanelHeightOrigin = _headerTopPanelHeight;
    _headerPanelHeightMin = _headerBottomPanelHeight;
    _headerPanelHeightDelta = fabs(_headerTopPanelHeight - _headerBottomPanelHeight);
    
    UIEdgeInsets inset = self.tableView.contentInset;
    UIEdgeInsets insetIndicator = self.tableView.scrollIndicatorInsets;
    CGFloat fTopInset = _headerTopPanelHeight;
    CGFloat fTopIndicatorInset = _headerTopPanelHeight;
    insetIndicator.top = fTopIndicatorInset;
    [self.tableView setScrollIndicatorInsets:insetIndicator];
    inset.top = fTopInset;
    [self.tableView setContentInset:inset];
    _talbeViewContentOffsetYOrigin = -1 * inset.top;
    
    self.headerTopPanel.translatesAutoresizingMaskIntoConstraints = NO;
    self.headerPanel.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.headerPanel setNeedsLayout];
    self.headerPanelHeightConstraint.constant = _headerPanelHeightOrigin;
    [self.headerPanel layoutIfNeeded];
    
    [self.headerTopPanel setNeedsLayout];
    self.headerTopPanelTopConstraint.constant = _topOriginal;
    [self.headerTopPanel layoutIfNeeded];
}

#pragma mark - TableView
#pragma mark ScrolView

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView == self.tableView)
    {
        [self updateHeaderLayoutWithTableContentOffset:scrollView.contentOffset];
    }else{}
}

- (void)updateHeaderLayoutWithTableContentOffset:(CGPoint)contentOffset
{
    CGFloat y = contentOffset.y;
    
    // header里的top面板和bottom面板整天上下移动
    CGFloat newTop = 0.0f;
    if (y <= _talbeViewContentOffsetYOrigin)
    {
        newTop = _topOriginal;
    }
    else if (y >= 0.0f)
    {
        newTop = _topMin;
    }
    else
    {
        newTop = _topOriginal - (y + _headerTopPanelHeight);
    }
    
    if (self.headerTopPanelTopConstraint.constant != newTop)
    {
        [self.headerTopPanel setNeedsLayout];
        self.headerTopPanelTopConstraint.constant = newTop;
        [self.headerTopPanel layoutIfNeeded];
    }else{}
    
    // header的高度变化
    CGFloat newHeight = 0.0f;
    if (y >= (_talbeViewContentOffsetYOrigin + _headerPanelHeightDelta))
    {
        newHeight = _headerPanelHeightMin;
    }
    else if (y <= _talbeViewContentOffsetYOrigin)
    {
        newHeight = _headerPanelHeightOrigin;
    }
    else
    {
        newHeight = _headerTopPanelHeight - (y + _headerTopPanelHeight);
    }

    if (self.headerPanelHeightConstraint.constant != newHeight)
    {
        [self.headerPanel setNeedsLayout];
        self.headerPanelHeightConstraint.constant = newHeight;
        [self.headerPanel layoutIfNeeded];
    }else{}
}

#pragma mark UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

#pragma mark UITableViewDatasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 80;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"Cell"];

    
    return cell;
}



































@end

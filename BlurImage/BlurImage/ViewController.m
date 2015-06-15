//
//  ViewController.m
//  BlurImage
//
//  Created by jimple on 15/6/15.
//  Copyright (c) 2015年 JimpleChen. All rights reserved.
//

#import "ViewController.h"

NSString * const kImgName = @"icon_graduate";


@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (assign, nonatomic) BOOL blured;
@property (strong, nonatomic) NSMutableArray *frameArray;


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

- (void)commonInit {
    _frameArray = @[].mutableCopy;
    
    self.imgView.contentMode = UIViewContentModeCenter;
    self.imgView.image = [UIImage imageNamed:kImgName];
    self.imgView.animationDuration = 0.1f;
    self.imgView.animationRepeatCount = 1;
    
    self.blured = NO;
}

- (IBAction)blurBtn:(id)sender {
    if (self.blured) {
        [self unblurImg];
    } else {
        [self blurImg];
    }
}

- (void)blurImg {
    if (_frameArray.count <= 0) {
        CIContext *context = [CIContext contextWithOptions:nil];
        UIImage *srcImg = [UIImage imageWithCGImage:[UIImage imageNamed:kImgName].CGImage scale:2.0f orientation:UIImageOrientationUp];
        CIImage *image = [CIImage imageWithCGImage:srcImg.CGImage];
        CIFilter *filter = [CIFilter filterWithName:@"CIGaussianBlur"];
        [filter setValue:image forKey:kCIInputImageKey];
        
        for (int i = 1; i <= 3; i++) {
            CGFloat radio = 1.5f * i;
            
            [filter setValue:@(radio) forKey: @"inputRadius"];
            CIImage *result = [filter valueForKey:kCIOutputImageKey];
            CGImageRef outImage = [context createCGImage: result fromRect:[result extent]];
            UIImage * blurImage = [UIImage imageWithCGImage:outImage scale:2.0f orientation:UIImageOrientationUp];
            
            [_frameArray addObject:blurImage];
        }
        
        self.imgView.animationDuration = 0.3f;
        self.imgView.animationImages = _frameArray;
    } else {}
    
    [self.imgView setImage:[_frameArray lastObject]];
    [self.imgView startAnimating];
    self.blured = YES;
}

- (void)unblurImg {
    self.imgView.image = [UIImage imageNamed:kImgName];
    self.blured = NO;
}













@end

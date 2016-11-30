//
//  ViewController.m
//  RadarAnimation
//
//  Created by 储诚鹏 on 16/11/30.
//  Copyright © 2016年 RUIYI. All rights reserved.
//

#import "ViewController.h"
#import "RadarView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}
- (IBAction)startSearch:(UIButton *)sender {
    sender.enabled = NO;
    CGFloat sw = [UIScreen mainScreen].bounds.size.width;
    CGFloat sh = [UIScreen mainScreen].bounds.size.height;
    dispatch_source_t disTimer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_main_queue());
     __block int i = 10;
     dispatch_source_set_timer(disTimer, dispatch_walltime(NULL, 0), 1ull * NSEC_PER_SEC, 0ull * NSEC_PER_SEC);
     dispatch_source_set_event_handler(disTimer, ^{
         RadarView *rv = [[RadarView alloc] initWithFrame:CGRectMake(0 , 0, sw / 2, sw / 2)];
     if (--i > 0) {
     [sender setTitle:[NSString stringWithFormat:@"WC在%d秒后出现",i] forState:UIControlStateNormal];
         [rv animationWithDuraton:4.0];
         rv.center = CGPointMake(sw / 2, sh / 2);
         [self.view addSubview:rv];
     }
     else {
         dispatch_source_cancel(disTimer);
     }
     });
     dispatch_source_set_cancel_handler(disTimer, ^{
     NSLog(@"timer cancle");
     sender.enabled = YES;
     [sender setTitle:@"前方500米处有厕所" forState:UIControlStateNormal];
     });
     dispatch_resume(disTimer);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

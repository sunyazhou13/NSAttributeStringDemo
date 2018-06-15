//
//  ViewController.m
//  NSAttributeStringDemo
//
//  Created by sunyazhou on 2018/6/15.
//  Copyright © 2018年 Kwai Co., Ltd. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *label;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
 
    NSAttributedString *resultTime = [self formattedCurrentTime:133];
    self.label.attributedText = resultTime;
}

/**
 返回当前时间格式
 @return 返回组装好的字符串
 */
- (NSAttributedString *)formattedCurrentTime:(NSTimeInterval)timeInterval {
    
    NSUInteger time = (NSUInteger)timeInterval;
    NSInteger minutes = (time / 60) % 60;
    NSInteger seconds = time % 60;
    NSString *minStr = [NSString stringWithFormat:@" %zd ",minutes];
    NSString *secStr = [NSString stringWithFormat:@" %zd ",seconds];
    //假设这就是我们国际化后的字符串
    NSString *localizedFormatString = [NSString stringWithFormat:@"%@分%@秒",minStr,secStr];
    NSMutableAttributedString *attributeStr = [[NSMutableAttributedString alloc] initWithString:localizedFormatString];
    NSDictionary *timeAttrs = @{ NSForegroundColorAttributeName : [UIColor redColor],
                                 NSFontAttributeName : [UIFont systemFontOfSize:40.0f]};
    /** 方案2 **/
    NSError *error = nil;
    NSRegularExpression *reg = [NSRegularExpression regularExpressionWithPattern:@"[0-9]+" options:NSRegularExpressionCaseInsensitive error:&error];
    if (error == nil) {
        NSArray *matches = [reg matchesInString:localizedFormatString options:NSMatchingReportCompletion range:NSMakeRange(0, localizedFormatString.length)];
        for (NSTextCheckingResult *match in matches) {
            for (NSUInteger i = 0; i < match.numberOfRanges; i++) {
                NSRange range = [match rangeAtIndex:i];
                if (range.location != NSNotFound) {
                    [attributeStr addAttributes:timeAttrs range:range];
                }
            }
        }
    }
    return [[NSAttributedString alloc] initWithAttributedString:attributeStr];;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

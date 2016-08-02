//
//  VerticalBanner.m
//  口袋ATM
//
//  Created by 赵奎博 on 16/3/17.
//  Copyright © 2016年 赵奎博. All rights reserved.
//

#import "VerticalBanner.h"
//#import "UIImageView+WebCache.h"
#import "Eleven_Header.h"
#import <CoreText/CoreText.h>
@implementation VerticalBanner

-(void)Zkb_AdverScroll_hight:(CGFloat)hight width:(CGFloat)width Source:(NSArray *)array time_space:(NSInteger)time placeholderImageStr:(NSString *)placeImageStr
{
    widdddd = width;
    hei = hight;
    
    self.pagingEnabled = YES;
    self.contentSize = CGSizeMake(width, hight * (array.count + 2));
    self.delegate = self;
    self.showsHorizontalScrollIndicator = NO;
    self.showsVerticalScrollIndicator = NO;
    self.userInteractionEnabled = NO;
    self.contentOffset = CGPointMake(0, hight * array.count);
    NSMutableArray * array_ima = [NSMutableArray arrayWithArray:array];
    [array_ima addObject:array_ima[array_ima.count - 1]];
    [array_ima addObject:array_ima[array_ima.count - 1]];
    
    for (int i=0; i< array_ima.count; i++)
    {
        UIView * view_banner = [[UIView alloc]initWithFrame:CGRectMake(0,i * hei, width, hight)];
        [self addSubview:view_banner];
        [self view_view:view_banner];
    }
    
    [NSTimer scheduledTimerWithTimeInterval:time target:self selector:@selector(chge) userInfo:nil repeats:YES];
}

-(void)view_view:(UIView *)view
{
    UILabel * label_text = [[UILabel alloc]initWithFrame:CGRectMake(10, 5, DEF_WIDTH(view) / 2 - 20, DEF_HEIGHT(view) - 10)];
    label_text.numberOfLines = 0;
    label_text.textColor = DEF_RGB_COLOR(130, 130, 130);
    label_text.text = @"10592102 20秒前 \n微信支付 [1.00元] 已到账";
    label_text.font = [UIFont boldSystemFontOfSize:14];
    [view addSubview:label_text];
    
    NSMutableAttributedString * attrituteString = [[NSMutableAttributedString alloc] initWithString:label_text.text];
    
    //调整字间距
    long number = 1.0f;
    CFNumberRef num = CFNumberCreate(kCFAllocatorDefault,kCFNumberSInt8Type,&number);
    [attrituteString addAttribute:(id)kCTKernAttributeName value:(__bridge id)num range:NSMakeRange(0,[attrituteString length])];
    CFRelease(num);
    // 获取标红的位置和长度
    NSRange range = [label_text.text rangeOfString:@"20秒前"];
    // 设置标签文字的属性
    [attrituteString setAttributes:@{NSForegroundColorAttributeName : DEF_RGB_COLOR(155, 199, 228), NSFontAttributeName : [UIFont boldSystemFontOfSize:13]} range:range];
    
    // 获取标红的位置和长度
    NSRange range_2 = [label_text.text rangeOfString:@"1.00元"];
    // 设置标签文字的属性
    [attrituteString setAttributes:@{NSForegroundColorAttributeName : DEF_RGB_COLOR(235, 7, 57), NSFontAttributeName : [UIFont boldSystemFontOfSize:13]} range:range_2];
    
    // 显示在Label上
    label_text.attributedText = attrituteString;
    
    
    UILabel * label_text_2 = [[UILabel alloc]initWithFrame:CGRectMake(DEF_WIDTH(view) / 2 + 20, 5, DEF_WIDTH(view) / 2 - 20, DEF_HEIGHT(view) - 10)];
    label_text_2.textColor = DEF_RGB_COLOR(130, 130, 130);
    label_text_2.numberOfLines = 0;
    label_text_2.text = @"10592102 26秒前 \n赚取0.76元\n完成: [搜应] 美团团购";
    label_text_2.font = [UIFont boldSystemFontOfSize:14];
    [view addSubview:label_text_2];
    
    NSMutableAttributedString * attrituteString_2 = [[NSMutableAttributedString alloc] initWithString:label_text_2.text];
    //long number = 1.0f;
    //CFNumberRef num = CFNumberCreate(kCFAllocatorDefault,kCFNumberSInt8Type,&number);
    [attrituteString_2 addAttribute:(id)kCTKernAttributeName value:(__bridge id)num range:NSMakeRange(0,[attrituteString_2 length])];
    CFRelease(num);
    // 获取标红的位置和长度
    NSRange range_3 = [label_text_2.text rangeOfString:@"26秒前"];
    // 设置标签文字的属性
    [attrituteString_2 setAttributes:@{NSForegroundColorAttributeName : DEF_RGB_COLOR(155, 199, 228), NSFontAttributeName : [UIFont boldSystemFontOfSize:13]} range:range_3];
    
    // 获取标红的位置和长度
    NSRange range_4 = [label_text_2.text rangeOfString:@"0.76元"];
    // 设置标签文字的属性
    [attrituteString_2 setAttributes:@{NSForegroundColorAttributeName : DEF_RGB_COLOR(235, 7, 57), NSFontAttributeName : [UIFont boldSystemFontOfSize:13]} range:range_4];
    // 显示在Label上
    label_text_2.attributedText = attrituteString_2;
}


-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    NSLog(@"%f---------------%f",self.contentOffset.y,hei);
    if(self.contentOffset.y < hei)
    {
        [self setContentOffset:CGPointMake(0, hei * 3) animated:NO];
    }
}

-(void)chge
{
    [self setContentOffset:CGPointMake( 0,self.contentOffset.y - hei) animated:YES];
}

@end

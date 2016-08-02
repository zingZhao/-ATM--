//
//  VerticalBanner.h
//  口袋ATM
//
//  Created by 赵奎博 on 16/3/17.
//  Copyright © 2016年 赵奎博. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface VerticalBanner : UIScrollView<UIScrollViewDelegate>
{
    UIPageControl * page;
    CGFloat widdddd;
    CGFloat hei;
}
-(void)Zkb_AdverScroll_hight:(CGFloat)hight width:(CGFloat)width Source:(NSArray *)array time_space:(NSInteger)time placeholderImageStr:(NSString *)placeImageStr;
@end

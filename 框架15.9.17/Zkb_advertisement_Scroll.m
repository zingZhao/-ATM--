//
//  Zkb_advertisement_Scroll.m
//  me
//
//  Created by 赵奎博 on 16/1/14.
//  Copyright © 2016年 赵奎博. All rights reserved.
//

#import "Zkb_advertisement_Scroll.h"
//#import "UIImageView+WebCache.h"
#define DEF_SCREEN_WIDTH [[UIScreen mainScreen] bounds].size.width - 20

@implementation Zkb_advertisement_Scroll

-(void)Zkb_AdverScroll_hight:(CGFloat)hight width:(CGFloat)width Source:(NSArray *)array time_space:(NSInteger)time placeholderImageStr:(NSString *)placeImageStr
{
    wid = width;
    
    self.contentSize = CGSizeMake(width * (array.count + 2), hight);
    self.delegate = self;
    self.showsHorizontalScrollIndicator = NO;
    self.showsVerticalScrollIndicator = NO;
    self.pagingEnabled = YES;
    self.contentOffset = CGPointMake(width, 0);
    NSMutableArray * array_ima = [NSMutableArray arrayWithArray:array];
    [array_ima addObject:array_ima[array_ima.count - 2]];
    [array_ima addObject:array_ima[array_ima.count - 2]];
    
    for (int i=0; i< array_ima.count; i++)
    {
        UIImageView * image = [[UIImageView alloc]initWithFrame:CGRectMake(width * i, 0, width, hight)];
        image.userInteractionEnabled = YES;
        NSString * path = [[NSBundle mainBundle]pathForResource:array_ima[i] ofType:nil];
        image.image = [UIImage imageWithContentsOfFile:path];
        [self addSubview:image];
    }
    
    page = [[UIPageControl alloc]initWithFrame:CGRectMake(width / 2 - 20, hight - 25, 40, 20)];
    page.numberOfPages = 2;
    page.currentPage = 0;
//    [page addTarget:self action:@selector(page:) forControlEvents:UIControlEventTouchUpInside];
    [self.superview addSubview:page];
    
    [NSTimer scheduledTimerWithTimeInterval:time target:self selector:@selector(chge) userInfo:nil repeats:YES];
}

//-(void)page:(UIPageControl *)pager
//{
//    [self setContentOffset:CGPointMake(pager.currentPage * DEF_SCREEN_WIDTH, 0) animated:YES];
//}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSLog(@"%f-----%f-------%f",self.contentOffset.x,DEF_SCREEN_WIDTH,wid);
    page.currentPage = scrollView.contentOffset.x / wid - 1;
    if(self.contentOffset.x / wid >= 3 )
    {
        [self setContentOffset:CGPointMake(wid, 0) animated:NO];
    }
    
    if(self.contentOffset.x <= 0)
    {
        [self setContentOffset:CGPointMake(wid * 2, 0) animated:NO];
    }
}

-(void)chge
{
    [self setContentOffset:CGPointMake(self.contentOffset.x + wid, 0) animated:YES];
}

@end

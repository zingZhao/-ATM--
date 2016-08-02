//
//  abTableViewCell.m
//  口袋ATM
//
//  Created by 赵奎博 on 16/3/22.
//  Copyright © 2016年 赵奎博. All rights reserved.
//

#import "abTableViewCell.h"
#import "Eleven_Header.h"
@implementation abTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.backgroundColor = DEF_RGB_COLOR(240, 240, 240);
        
        UIView * view_back = [[UIView alloc]initWithFrame:CGRectMake(10, 5, DEF_SCREEN_WIDTH - 20, 80)];
        view_back.backgroundColor = [UIColor whiteColor];
        view_back.layer.masksToBounds = YES;
        view_back.layer.cornerRadius = 5.0;
        [self addSubview:view_back];
        
        UIImageView * image_left = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 60, 60)];
        image_left.image = [UIImage imageNamed:@"fang.png"];
        [view_back addSubview:image_left];
        
        UILabel * label_price = [[UILabel alloc]initWithFrame:CGRectMake(DEF_SCREEN_WIDTH - 90, 22.5, 60, 35)];
        label_price.backgroundColor = DEF_RGB_COLOR(231, 77, 79);
        label_price.text = @"0.05元";
        label_price.layer.masksToBounds = YES;
        label_price.layer.cornerRadius = 5.0;
        label_price.textAlignment = NSTextAlignmentCenter;
        label_price.textColor = [UIColor whiteColor];
        label_price.font = [UIFont systemFontOfSize:12];
        [view_back addSubview:label_price];
        
        UILabel * label_zhong_1 = [[UILabel alloc]initWithFrame:CGRectMake(DEF_RIGHT(image_left) + 10, 10, DEF_WIDTH(self) - 165, 20)];
        label_zhong_1.text = @"搜房网";
        label_zhong_1.font = [UIFont systemFontOfSize:15];
        [view_back addSubview:label_zhong_1];
        
        UILabel * label_zhong_2 = [[UILabel alloc]initWithFrame:CGRectMake(DEF_RIGHT(image_left) + 10, 30, DEF_WIDTH(self) - 165, 16)];
        label_zhong_2.text = @"上搜房领红包买新房";
        label_zhong_2.font = [UIFont systemFontOfSize:12];
        label_zhong_2.textColor = DEF_RGB_COLOR(111, 113, 121);
        [view_back addSubview:label_zhong_2];
        
        
        CGSize size = [self sizeOfStr:@"首次下载最新版本试用3分钟获奖，可以获取0.5元" andFont:[UIFont systemFontOfSize:12] andMaxSize:CGSizeMake(DEF_WIDTH(self) - 170, 2000)];
        UILabel * label_zhong_3 = [[UILabel alloc]initWithFrame:CGRectMake(DEF_RIGHT(image_left) + 10, 48, DEF_SCREEN_WIDTH - 170, size.height)];
        label_zhong_3.numberOfLines = 0;
        label_zhong_3.text = @"首次下载最新版本可以获取0.5元";
        label_zhong_3.textColor = DEF_RGB_COLOR(239, 67, 72);
        label_zhong_3.font = [UIFont systemFontOfSize:12];
        [view_back addSubview:label_zhong_3];
        
    }
    return self;
}

- (CGSize)sizeOfStr:(NSString *)str
            andFont:(UIFont *)font
         andMaxSize:(CGSize)size
{
    CGSize s;
    if ([[[UIDevice currentDevice]systemVersion]doubleValue]>=7.0) {
        NSDictionary *dic=@{NSFontAttributeName:font};
        s = [str boundingRectWithSize:size options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                           attributes:dic context:nil].size;
    }
    else
    {
        s=[str sizeWithFont:font constrainedToSize:size lineBreakMode:NSLineBreakByCharWrapping];
    }
    return s;
}

//- (void)awakeFromNib {
//    // Initialization code
//}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

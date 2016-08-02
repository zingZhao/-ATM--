//
//  ShareDetailViewController.m
//  口袋ATM
//
//  Created by 赵奎博 on 16/3/22.
//  Copyright © 2016年 赵奎博. All rights reserved.
//

#import "ShareDetailViewController.h"

@interface ShareDetailViewController ()
{
    UIView * view_back;
    UIView * shareView;
}
@end

@implementation ShareDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self addNavgationTitle:@"分享收徒"];
    [self addNavgationLeftButton:@"toolbar_arrow"];
    
    [self initUI];


}

-(void)initUI
{
    self.view.backgroundColor = DEF_RGB_COLOR(245, 245, 249);
    self.contentView.backgroundColor = DEF_RGB_COLOR(245, 245, 249);
    
    UIImageView * image_quare = [[UIImageView alloc]initWithFrame:CGRectMake(50, 30, DEF_SCREEN_WIDTH - 100, DEF_SCREEN_WIDTH - 100)];
    image_quare.image = [UIImage imageNamed:@"squre"];
    image_quare.contentMode = UIViewContentModeScaleAspectFill;
    [self.contentView addSubview:image_quare];
    
    CGSize size = [self sizeOfStr:@"活动内容\n收IOS徒弟送红包再升级，徒弟激活后做一个快速任务(经典任务除外)师傅得1元，每个徒弟贡献封顶30元。(1、激活指徒弟完成绑定微信实名认证，奖励到账。2、有效徒弟注册时间必须在2015-11-16 12:00:00以后。)\n\n活动时间\n2016-3-1开始" andFont:[UIFont systemFontOfSize:13] andMaxSize:CGSizeMake(DEF_SCREEN_WIDTH - 100, 200000) andLineBreakMode:NSLineBreakByCharWrapping];
    
    UILabel * label_label = [[UILabel alloc]initWithFrame:CGRectMake(50, DEF_BOTTOM(image_quare) + 20, DEF_SCREEN_WIDTH - 100, size.height + 20)];
    [self Eleven_Set_label:label_label text:@"活动内容\n收IOS徒弟送红包再升级，徒弟激活后做一个快速任务(经典任务除外)师傅得1元，每个徒弟贡献封顶30元。(1、激活指徒弟完成绑定微信实名认证，奖励到账。2、有效徒弟注册时间必须在2015-11-16 12:00:00以后。)\n\n活动时间\n2016-3-1开始" textColor:[UIColor grayColor] fontSize:13 fontAlpha:1 textAlignment:1];
    
    NSMutableAttributedString * attString = [[NSMutableAttributedString alloc]initWithString:label_label.text];
    NSRange range = [label_label.text rangeOfString:@"活动内容"];
    NSRange range2 = [label_label.text rangeOfString:@"活动时间"];
    
    [attString setAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15],NSForegroundColorAttributeName:[UIColor blackColor]} range:range];
    [attString setAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15],NSForegroundColorAttributeName:[UIColor blackColor]} range:range2];
    label_label.attributedText = attString;
    [self.contentView addSubview:label_label];
    
    UIButton * btn_begin = [UIButton buttonWithType:0];
    btn_begin.frame = CGRectMake(50, DEF_BOTTOM(label_label) + 20 , DEF_SCREEN_WIDTH - 100, 35);
    [self Eleven_Set_Button:btn_begin setBackgroundColor:DEF_RGB_COLOR(231, 77, 79) setBackgroundImageNormal:nil setBackgroundImageHighlighted:nil setTitle:@"立即邀请好友" setTitleFont:14 buttonTag:1 titleColor:[UIColor whiteColor]];
    [btn_begin addTarget:self action:@selector(yaoqing) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:btn_begin];

    
    self.contentView.contentSize = CGSizeMake(DEF_SCREEN_WIDTH, DEF_BOTTOM(btn_begin) + 40);
}

-(void)yaoqing
{
    view_back = [[UIView alloc]initWithFrame:CGRectMake(0, 0, DEF_SCREEN_WIDTH, DEF_SCREEN_HEIGHT)];
    view_back.backgroundColor = DEF_RGBA_COLOR(0, 0, 0, 0.3);
    [self.view addSubview:view_back];
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(removeViewBack)];
    [view_back addGestureRecognizer:tap];
    
    shareView = [[UIView alloc]initWithFrame:CGRectMake(0, DEF_SCREEN_HEIGHT, DEF_SCREEN_WIDTH, 80)];
    shareView.backgroundColor = [UIColor whiteColor];
    NSArray * array_share = @[@"01",@"02",@"03",@"04"];
    NSArray * array_title = @[@"朋友圈",@"QQ空间",@"微信好友",@"QQ"];
    
    for(int i=0;i < 4; i++)
    {
        UIImageView * image_icon = [[UIImageView alloc]initWithFrame:CGRectMake(DEF_SCREEN_WIDTH / 8 - 15 + DEF_SCREEN_WIDTH / 4 * i, 15, 30, 30)];
        if(i == 2)
        {
            image_icon.frame = CGRectMake(DEF_SCREEN_WIDTH / 8 - 18 + DEF_SCREEN_WIDTH / 4 * i, 15, 36, 30);
        }
        image_icon.image = [UIImage imageNamed:array_share[i]];
        [shareView addSubview:image_icon];
        
        UILabel * label_iocn = [[UILabel alloc]initWithFrame:CGRectMake(DEF_SCREEN_WIDTH / 4 * i, DEF_BOTTOM(image_icon)+ 5, DEF_SCREEN_WIDTH / 4, 20)];
        [self Eleven_Set_label:label_iocn text:array_title[i] textColor:[UIColor blackColor] fontSize:12 fontAlpha:1 textAlignment:3];
        [shareView addSubview:label_iocn];
        
        if(i == 3)
        {
            break;
        }
        UILabel * label_line = [[UILabel alloc]initWithFrame:CGRectMake(DEF_SCREEN_WIDTH / 4 * (i + 1), 0, 1, DEF_HEIGHT(shareView))];
        label_line.backgroundColor = DEF_RGB_COLOR(250, 250, 250);
        [shareView addSubview:label_line];
    }
    [self.view addSubview:shareView];
    
    [UIView animateWithDuration:0.5 animations:^{
        
        shareView.frame = CGRectMake(0, DEF_SCREEN_HEIGHT - 80, DEF_SCREEN_WIDTH, 80);
    } completion:^(BOOL finished) {
        
    }];
}

-(void)removeViewBack
{
    [UIView animateWithDuration:0.5 animations:^{
        
        shareView.frame = CGRectMake(0, DEF_SCREEN_HEIGHT + 100, DEF_SCREEN_WIDTH, 80);
        
    } completion:^(BOOL finished) {
        
        [shareView removeFromSuperview];
        [view_back removeFromSuperview];
        shareView = nil;
        view_back = nil;
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

//
//  HelpViewController.m
//  口袋ATM
//
//  Created by 赵奎博 on 16/3/23.
//  Copyright © 2016年 赵奎博. All rights reserved.
//

#import "HelpViewController.h"

@interface HelpViewController ()

@end

@implementation HelpViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self addNavgationTitle:@"帮助"];
    [self addNavgationLeftButton:@"toolbar_arrow"];
    
    [self initUI];

}

-(void)initUI
{
    self.contentView.backgroundColor = DEF_RGB_COLOR(245, 245, 249);
    
    [self addWebView:@"help" and:CGRectMake(0, topHight, DEF_SCREEN_WIDTH, DEF_HEIGHT(self.contentView))];
    return; 
    
    
    NSString * str = @"问：推荐新用户注册怎么成为他的师父？\n新用户只需要在微信中打开师父发送的链接或扫师父的二维码，通过浏览器下载安装口袋ATM，并关注微信公众号：kdatm123，系统会默认建立师徒关系。\n\n问：同一个号码能在其他手机上使用吗？\n如果您换了一台新手机，可以在新手机上用原来的手机号登陆口袋ATM，但苹果id只能在苹果设备登陆，安卓id只能在安卓设备登陆\n\n问：如何保证我的账号安全？\n口袋采用注册手机验证码+微信绑定手机验证码+手机设备号的保险机制\n（友情提醒：不要把手机号或验证码交给陌生人）\n\n问：为什么不能实时到账？\n注册完口袋ID关注微信公众号kdatm123，点击我要绑定 绑定信息，确认微信有没有绑定银行卡(没有绑定的话必须要绑定银行卡才能到账，当天绑定的要第二天才能到账)，做完任务到口袋首页下拉刷新 余额就会到账微信钱包\n\n问：为什么我下载任务了没有奖励？\n请检查是否按要求完成了任务，如：\n1、必须首次安装，以前安装过，删除再安装是无法获得奖励\n2、必须按任务要求完成，比如注册、体验等\n3、不同联盟任务里的相同任务，只能做一次，重复无奖励\n4、联盟任务不受口袋公司控制，不能保证100%返分，按照要求做任务基本上会返分的。\n\n问：作弊行为的判断\n1、付费人物，一个苹果id只能获得一次奖励，共享id将无法获得奖励。\n2、一个id只能绑定一个设备，刷机或还原手机均视为作弊用户\n\n问：如何做到月入数千？\n每天先把快速任务做了，然后去联盟任务区选择高收益的任务，所有任务都是限时限量，任务不定时更新，下午任务最多，所以多多关注。";
    
    CGSize size = [self sizeOfStr:str andFont:[UIFont systemFontOfSize:16] andMaxSize:CGSizeMake(DEF_SCREEN_WIDTH - 60, 2000000) andLineBreakMode:NSLineBreakByCharWrapping];
    
    UILabel * label_help = [[UILabel alloc]initWithFrame:CGRectMake(30,20, DEF_SCREEN_WIDTH - 60, size.height + 20)];
    [self Eleven_Set_label:label_help text:str textColor:[UIColor blackColor] fontSize:16 fontAlpha:1 textAlignment:1];
    [self.contentView addSubview:label_help];
    label_help.backgroundColor = DEF_RGB_COLOR(245, 245, 249);
    NSMutableAttributedString * att = [[NSMutableAttributedString alloc]initWithString:str];
    /*
    NSCaseInsensitiveSearch
    NSLiteralSearch
    NSBackwardsSearch     NSAnchoredSearch = 8,		    NSNumericSearch = 64,	    NSDiacriticInsensitiveSearch     NSWidthInsensitiveSearch     NSForcedOrderingSearch     NSRegularExpressionSearch
     */
    for(int i=0; i< str.length; i = i + 20)
    {
        NSRange range111;
        range111.length = 20;
        range111.location = i;
        if(i + 20 > str.length)
        {
            break;
        }
        NSRange range11 = [str rangeOfString:@"问：" options:NSRegularExpressionSearch range:range111];
        [att setAttributes:@{NSForegroundColorAttributeName:DEF_RGB_COLOR(251, 17, 63)} range:range11];
    }
    
    
    NSRange range2 = [str rangeOfString:@"推荐新用户注册怎么成为他的师父？"];
    [att setAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:16]} range:range2];
    NSRange range3 = [str rangeOfString:@"同一个号码能在其他手机上使用吗？"];
    [att setAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:16]} range:range3];
    NSRange range4 = [str rangeOfString:@"如何保证我的账号安全？"];
    [att setAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:16]} range:range4];
    NSRange range5= [str rangeOfString:@"为什么不能实时到账？"];
    [att setAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:16]} range:range5];
    NSRange range6 = [str rangeOfString:@"为什么我下载任务了没有奖励？"];
    [att setAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:16]} range:range6];
    NSRange range7 = [str rangeOfString:@"作弊行为的判断"];
    [att setAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:16]} range:range7];
    NSRange range8 = [str rangeOfString:@"如何做到月入数千？"];
    [att setAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:16]} range:range8];
    label_help.attributedText = att;
    
    self.contentView.contentSize = CGSizeMake(DEF_SCREEN_WIDTH, DEF_BOTTOM(label_help) + 20);
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

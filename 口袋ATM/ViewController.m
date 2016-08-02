//
//  ViewController.m
//  口袋ATM
//
//  Created by 赵奎博 on 16/3/17.
//  Copyright © 2016年 赵奎博. All rights reserved.
//

#import "ViewController.h"
#import "Eleven_Header.h"
#import "Zkb_advertisement_Scroll.h"
#import "VerticalBanner.h"
#import "FastListViewController.h"
#import "UnionViewController.h"
#import "ShareViewController.h"
#import "UserViewController.h"
@interface ViewController ()<UITextFieldDelegate>
{
    UIImageView * image_top;
    UIView * view_top;
    UIImageView * view_hint;
    UIView * view_vercital_banner;
    
    
    UIImageView * image_laba;
    UIScrollView * scroll_hint;
    
    NSInteger num;
    
    CABasicAnimation *rotation;
    UILabel * label_hint;
    
    UIView * back_view;
    UIView * view_user;
    UIView * view_top_2;
    UITextField * text_phone;
    UITextField * text_token;
    
    UIView * view_one;
    UIView * view_two;
    UILabel * label_hint_2;
    
    NSArray * array_img;
    NSInteger num_page;
    
    UIScrollView * scrol;
    
    BOOL isone;
}
@property (nonatomic,strong) UIImageView * iconView;
@end

@implementation ViewController

- (void)viewDidLoad {
    
    self.navigationController.navigationBarHidden = YES;
    
    [super viewDidLoad];
    
    num_page = 0;
    array_img = @[@"guidePage-2208-1",@"guidePage-2208-2",@"guidePage-2208-3",@"guidePage-2208-4"];
    
    if([[[NSUserDefaults standardUserDefaults]objectForKey:@"isone"] isEqualToString:@"no"])
    {
        [self initUI];
    }
    else
    {
        [[NSUserDefaults standardUserDefaults]setObject:@"no" forKey:@"isone"];
        [self transformImage];
    }
    
    
}

-(void)viewDidAppear:(BOOL)animated
{
    if(isone == YES)
    {
        [scrol headerBeginRefreshing];
    }
    isone = YES;
}

-(void)transformImage
{
    self.iconView = [[UIImageView alloc]initWithFrame:self.view.bounds];
    self.iconView.image = [UIImage imageNamed:@"guidePage-960-1"];
    self.iconView.userInteractionEnabled = YES;
    [self.view addSubview:self.iconView];
    
    UISwipeGestureRecognizer * swipe = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(pre)];
    swipe.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.iconView addGestureRecognizer:swipe];
    
    UIButton * btn_pre = [UIButton buttonWithType:0];
    btn_pre.frame = CGRectMake(DEF_SCREEN_WIDTH - 100, DEF_SCREEN_HEIGHT - 100, 100, 100);
    [btn_pre addTarget:self action:@selector(pre) forControlEvents:UIControlEventTouchUpInside];
    [btn_pre setTitle:@"next" forState:0];
    [self.view addSubview:btn_pre];
    
//    UIButton * btn_next = [UIButton buttonWithType:0];
//    btn_next.frame = CGRectMake(350, 500, 50, 50);
//    [btn_next addTarget:self action:@selector(next) forControlEvents:UIControlEventTouchUpInside];
//    btn_next.backgroundColor = [UIColor yellowColor];
//    [self.view addSubview:btn_next];
}

-(void)pre
{
    if(num_page == 3)
    {
        [self initUI];
        scrol.contentOffset = CGPointMake(0, DEF_SCREEN_HEIGHT);
        scrol.alpha = 0.0;
        [UIView animateWithDuration:0.5 animations:^{
            self.iconView.alpha = 0.0;
            scrol.alpha = 1.0;
            scrol.contentOffset = CGPointMake(0, 0);

        } completion:^(BOOL finished) {
            [self.iconView removeFromSuperview];
            
            
//            [UIView animateWithDuration:0.5 animations:^{
//                
//                
//            } completion:^(BOOL finished) {
//                
//            }];
        }];
        
        return;
    }
    num_page++;
    self.iconView.image = [UIImage imageNamed:array_img[num_page]];
    
    //创建核心动画
    CATransition * ca = [CATransition animation];
    
    //动画效果
    //过度效果
    ca.type = @"cube";
    //设置动画的过度方向
    ca.subtype = kCATransitionFromRight;
    
    ca.duration = 0.5;
    
    [self.iconView.layer addAnimation:ca forKey:nil];
}

-(void)initUI
{
    self.view.backgroundColor = DEF_RGB_COLOR(245, 245, 249);
    scrol = [[UIScrollView alloc]initWithFrame:CGRectMake(0, -20, DEF_SCREEN_WIDTH, DEF_SCREEN_HEIGHT + 20)];
    if([[[NSUserDefaults standardUserDefaults]objectForKey:@"hei"] isEqualToString:@"1"])
    {
        //scrol.frame = CGRectMake(0,0, DEF_SCREEN_WIDTH, DEF_SCREEN_HEIGHT);
    }
    else
    {
        [[NSUserDefaults standardUserDefaults]setObject:@"1" forKey:@"hei"];
        scrol.frame = CGRectMake(0,0, DEF_SCREEN_WIDTH, DEF_SCREEN_HEIGHT);
    }
    scrol.backgroundColor = DEF_RGB_COLOR(245, 245, 249);
    scrol.showsHorizontalScrollIndicator = NO;
    scrol.showsVerticalScrollIndicator = NO;
    [self.view addSubview:scrol];
    
    [self setupRefresh];
    
    image_top = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, DEF_SCREEN_WIDTH, DEF_SCREEN_HEIGHT * 0.16)];
    NSString * path = [[NSBundle mainBundle]pathForResource:@"main_head1.png" ofType:nil];
    image_top.image = [UIImage imageWithContentsOfFile:path];
    [scrol addSubview:image_top];
    
    CGFloat heigjy = DEF_BOTTOM(image_top) + 10;
    
    CGFloat space = DEF_SCREEN_WIDTH / 32;
    
    CGFloat hig = 1.45 * DEF_SCREEN_WIDTH / 7;
    //上部
    view_top = [[UIView alloc]initWithFrame:CGRectMake(0, 0, DEF_SCREEN_WIDTH,hig * 2)];
    view_top.userInteractionEnabled = YES;
    view_top.alpha = 0.0;
    [scrol addSubview:view_top];
    
    NSArray * array_image = @[@"main_kuaisu.png",@"main_lianmeng.png",@"main_huodong.png",@"main_geren.png"];
    NSArray * array_title = @[@"快速任务",@"联盟任务",@"分享收徒",@"个人中心"];
    
    for(int i=0; i< array_image.count; i++)
    {
        NSString * path = [[NSBundle mainBundle]pathForResource:array_image[i] ofType:nil];
        
        UIView * view = [[UIView alloc]initWithFrame:CGRectMake(i % 3 * (DEF_SCREEN_WIDTH / 7) + DEF_SCREEN_WIDTH / 7 * (i % 3 + 1), i / 3 * hig, DEF_SCREEN_WIDTH / 7, hig * 0.9)];
        [self view_image:path title:array_title[i] view:view];
        view.tag = i;
        [view_top addSubview:view];
        
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
        [view addGestureRecognizer:tap];
    }
    
    //提示
    view_hint = [[UIImageView alloc]initWithFrame:CGRectMake(10, heigjy / 2, DEF_SCREEN_WIDTH - 20, 25)];
    NSString * path_hint = [[NSBundle mainBundle]pathForResource:@"hint.png" ofType:nil];
    view_hint.image = [UIImage imageWithContentsOfFile:path_hint];
    view_hint.alpha = 0.0;
    [self hintView:view_hint];
    [scrol addSubview:view_hint];
    
    //竖向banner
    view_vercital_banner = [[UIView alloc]initWithFrame:CGRectMake(10, DEF_BOTTOM(view_hint) + 10, DEF_SCREEN_WIDTH - 20, DEF_SCREEN_WIDTH / 4)];
    view_vercital_banner.backgroundColor = DEF_RGB_COLOR(250, 250, 250);
    view_vercital_banner.layer.masksToBounds = YES;
    view_vercital_banner.layer.cornerRadius = 10.0;
    view_vercital_banner.alpha  = 0.0;
    [scrol addSubview:view_vercital_banner];
    
    [self vertical_banner:view_vercital_banner];
    
    //横向banner
    UIView * view_ba = [[UIView alloc]initWithFrame:CGRectMake(10, DEF_BOTTOM(view_vercital_banner) + 10, DEF_SCREEN_WIDTH - 20, DEF_SCREEN_WIDTH / 2.7)];
    view_ba.alpha = 0.0;
    [scrol addSubview:view_ba];
    [self banner:view_ba];
    
    
    //底部个人信息
    UIImageView * image_bottom = [[UIImageView alloc]initWithFrame:CGRectMake(10, DEF_BOTTOM(view_ba) + 10, DEF_SCREEN_WIDTH - 20, DEF_SCREEN_HEIGHT / 8)];
    image_bottom.userInteractionEnabled = YES;
    NSString * path_user = [[NSBundle mainBundle]pathForResource:@"personalbg@2x.png" ofType:nil];
    image_bottom.image = [UIImage imageWithContentsOfFile:path_user];
    image_bottom.alpha  = 0.0;
    [scrol addSubview:image_bottom];
    
    UITapGestureRecognizer * tap_bo = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(login)];
    [image_bottom addGestureRecognizer:tap_bo];
    
    [self user:image_bottom];
    
    
    [UIView animateWithDuration:0.5 animations:^{
        
        view_top.frame = CGRectMake(0, DEF_BOTTOM(image_top), DEF_SCREEN_WIDTH,hig * 2);
        view_top.alpha = 1.0;
        
    } completion:^(BOOL finished) {
        
        [self view:view_top];

        [UIView animateWithDuration:0.5 animations:^{
            
            view_hint.frame = CGRectMake(10, DEF_BOTTOM(view_top) + space, DEF_SCREEN_WIDTH - 20, 30);
            view_hint.alpha = 1.0;
            
        } completion:^(BOOL finished) {
            
            [self view:view_hint];
            
            [UIView animateWithDuration:0.5 animations:^{
                
                view_vercital_banner.frame = CGRectMake(10, DEF_BOTTOM(view_hint) + space, DEF_SCREEN_WIDTH - 20, DEF_SCREEN_WIDTH / 4);
                view_vercital_banner.alpha = 1.0;
                
            } completion:^(BOOL finished) {
                
                [self view:view_vercital_banner];
                
                [UIView animateWithDuration:0.5 animations:^{
                    view_ba.frame = CGRectMake(10, DEF_BOTTOM(view_vercital_banner) + space, DEF_SCREEN_WIDTH - 20, DEF_HEIGHT(view_ba));
                    view_ba.alpha = 1.0;
                    
                } completion:^(BOOL finished) {
                    
                    [self view:view_ba];
                    
                    [UIView animateWithDuration:0.5 animations:^{
                        
                        image_bottom.frame = CGRectMake(10, DEF_BOTTOM(view_ba) + space, DEF_SCREEN_WIDTH - 20, DEF_HEIGHT(image_bottom));
                        image_bottom.alpha = 1.0;
                        
                    } completion:^(BOOL finished) {
                        
                        [self view:image_bottom];
                        scrol.contentSize = CGSizeMake(DEF_SCREEN_WIDTH, DEF_BOTTOM(image_bottom) + 10);
                        if(scrol.contentSize.height < DEF_SCREEN_HEIGHT)
                        {
                            scrol.contentSize = CGSizeMake(DEF_SCREEN_WIDTH, DEF_SCREEN_HEIGHT + 1);
                        }
                        
                    }];
                    
                }];
                
            }];

            
        }];

    }];
}

-(void)view:(UIView *)view
{
    
    //view.transform = CGAffineTransformMakeScale(0.90, 0.90);
    [UIView animateWithDuration:0.1
                     animations:^{
                         view.transform = CGAffineTransformMakeScale(1.02, 1.02);
                     }completion:^(BOOL finish){
                         [UIView animateWithDuration:0.1
                                          animations:^{
                                              view.transform = CGAffineTransformMakeScale(0.98, 0.98);
                                          }completion:^(BOOL finish){
                                              [UIView animateWithDuration:0.1
                                                               animations:^{
                                                                   view.transform = CGAffineTransformMakeScale(1.01, 1.01);
                                                               }completion:^(BOOL finish){
                                                                   
                                                                   [UIView animateWithDuration:0.1
                                                                                    animations:^{
                                                                                        view.transform = CGAffineTransformMakeScale(1, 1);
                                                                                    }completion:^(BOOL finish){
                                                                                        
                                                                                    }];
                                                                   
                                                               }];
                                          }];
                     }];
    
}

-(void)tapAction:(UITapGestureRecognizer *)tap
{
    switch (tap.view.tag) {
        case 0:
        {
            FastListViewController * fvc =[[FastListViewController alloc]init];
            [self.navigationController pushViewController:fvc animated:YES];
        }
            break;
            
        case 1:
        {
            UnionViewController * uvc = [[UnionViewController alloc]init];
            [self.navigationController pushViewController:uvc animated:YES];
        }
            break;
            
        case 2:
        {
            ShareViewController * svc = [[ShareViewController alloc]init];
            [self.navigationController pushViewController:svc animated:YES];
        }
            break;
            
        case 3:
        {
            UserViewController * uvc = [[UserViewController alloc]init];
            [self.navigationController pushViewController:uvc animated:YES];
        }
            break;
            
        default:
            break;
    }
}

-(void)user:(UIView *)view
{
    UILabel * label_user_name = [[UILabel alloc]initWithFrame:CGRectMake(DEF_WIDTH(view) / 5, 0, DEF_WIDTH(view) - DEF_WIDTH(view) / 5, DEF_HEIGHT(view) / 2.5)];
    label_user_name.font = [UIFont systemFontOfSize:16];
    label_user_name.text = @"这盐有点甜 10612456";
    NSMutableAttributedString * attrituteString = [[NSMutableAttributedString alloc] initWithString:label_user_name.text];
    // 获取标红的位置和长度
    NSRange range = [label_user_name.text rangeOfString:@"10612456"];
    // 设置标签文字的属性
    [attrituteString setAttributes:@{NSFontAttributeName : [UIFont boldSystemFontOfSize:13]} range:range];
    label_user_name.attributedText = attrituteString;
    [view addSubview:label_user_name];
    
    UILabel * label_lj = [[UILabel alloc]initWithFrame:CGRectMake(DEF_X(label_user_name), DEF_BOTTOM(label_user_name), 80, DEF_HEIGHT(view) / 4)];
    label_lj.font = [UIFont systemFontOfSize:13];
    label_lj.textColor = [UIColor redColor];
    label_lj.text = @"累计收益";
    [view addSubview:label_lj];
    
    UILabel * label_lj_1 = [[UILabel alloc]initWithFrame:CGRectMake(DEF_X(label_user_name), DEF_BOTTOM(label_lj), 80, DEF_HEIGHT(label_lj))];
    label_lj_1.font = [UIFont systemFontOfSize:13];
    label_lj_1.text = @"1.0";
    [view addSubview:label_lj_1];
    
    UILabel * label_ye = [[UILabel alloc]initWithFrame:CGRectMake(DEF_X(label_user_name) + DEF_WIDTH(view) / 3.5, DEF_BOTTOM(label_user_name), 80, DEF_HEIGHT(label_lj))];
    label_ye.textColor = [UIColor redColor];
    label_ye.font = [UIFont systemFontOfSize:13];
    label_ye.text = @"账户余额";
    [view addSubview:label_ye];
    
    UILabel * label_ye_1 = [[UILabel alloc]initWithFrame:CGRectMake(DEF_X(label_user_name) + DEF_WIDTH(view) / 3.5, DEF_BOTTOM(label_ye), 80, DEF_HEIGHT(label_lj))];
    label_ye_1.font = [UIFont systemFontOfSize:13];
    label_ye_1.text = @"1.0";
    [view addSubview:label_ye_1];
    
    UIImageView * image_user = [[UIImageView alloc]initWithFrame:CGRectMake(DEF_WIDTH(view) - DEF_HEIGHT(view) + 10, 10, DEF_HEIGHT(view) - 20, DEF_HEIGHT(view) - 20)];
    image_user.image = [UIImage imageNamed:@"99.jpg"];
    image_user.layer.masksToBounds = YES;
    image_user.layer.cornerRadius = DEF_WIDTH(image_user) / 2;
    [view addSubview:image_user];
}

-(void)vertical_banner:(UIView *)view
{
    VerticalBanner * veb = [[VerticalBanner alloc]initWithFrame:view.bounds];
    [veb Zkb_AdverScroll_hight:DEF_HEIGHT(view) width:DEF_WIDTH(view) Source:@[@"qq.png",@"qq.png"] time_space:3 placeholderImageStr:@""];
    [view addSubview:veb];
    
    UILabel * label_line = [[UILabel alloc]initWithFrame:CGRectMake(DEF_SCREEN_WIDTH / 2 - 0.5, DEF_X(view), 1, DEF_HEIGHT(view) - 2 * DEF_X(view))];
    label_line.backgroundColor = DEF_RGB_COLOR(240, 240, 240);
    [view addSubview:label_line];
}

-(void)banner:(UIView *)view
{
    Zkb_advertisement_Scroll * zkb = [[Zkb_advertisement_Scroll alloc]initWithFrame:view.bounds];
    [view addSubview:zkb];
    [zkb Zkb_AdverScroll_hight:DEF_HEIGHT(view) width:DEF_WIDTH(view) Source:@[@"48Q58PICcvn_1024.jpg",@"banner.png"] time_space:4.0 placeholderImageStr:@""];
}

//滚动条
-(void)hintView:(UIView *)view
{
    image_laba = [[UIImageView alloc]initWithFrame:CGRectMake(10, 7, 22, 16)];
    NSString * path = [[NSBundle mainBundle]pathForResource:@"main_laba@2x.png" ofType:nil];
    image_laba.image = [UIImage imageWithContentsOfFile:path];
    [view addSubview:image_laba];
    
    
    CGSize size = [self sizeOfStr:@"每天分享微信朋友圈并且分享QQ空间即可获得一次免费的抢红包机会哦!!!" andFont:[UIFont systemFontOfSize:13] andMaxSize:CGSizeMake(100000000000, 30) andLineBreakMode:NSLineBreakByCharWrapping];
    scroll_hint = [[UIScrollView alloc]initWithFrame:CGRectMake(40, 0, DEF_WIDTH(view) - 60, DEF_HEIGHT(view))];
    scroll_hint.contentSize = CGSizeMake(size.width * 1.8, DEF_HEIGHT(view));
    [view addSubview:scroll_hint];
    
    label_hint = [[UILabel alloc]initWithFrame:CGRectMake(size.width * 0.8, 0, size.width, DEF_HEIGHT(view))];
    label_hint.text = @"每天分享微信朋友圈并且分享QQ空间即可获得一次免费的抢红包机会哦!!!";
    label_hint.font = [UIFont systemFontOfSize:13];
    [scroll_hint addSubview:label_hint];
    
   rotation  = [CABasicAnimation animationWithKeyPath:@"position"];
    //kCAMediaTimingFunctionLinear 表示时间方法为线性，使得足球匀速转动
    rotation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    rotation.toValue = [NSValue valueWithCGPoint:CGPointMake(-DEF_SCREEN_WIDTH / 1.8, label_hint.center.y)];
    rotation.duration = 8;
    rotation.repeatCount = MAXFLOAT;
    //rotation.autoreverses = YES;
    
    [label_hint.layer addAnimation:rotation forKey:@"rotation"];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [label_hint.layer removeAnimationForKey:@"rotation"];
}

-(void)viewWillAppear:(BOOL)animated
{
    if(label_hint)
    {
        [label_hint.layer addAnimation:rotation forKey:@"rotation"];
    }
}

//图片加数字
-(void)view_image:(NSString *)path title:(NSString *)title view:(UIView *)view
{
    UIImageView * image = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, DEF_SCREEN_WIDTH / 7, DEF_SCREEN_WIDTH / 7)];
    image.image = [UIImage imageWithContentsOfFile:path];
    [view addSubview:image];
    
    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(- DEF_SCREEN_WIDTH / 80, DEF_SCREEN_WIDTH / 7, DEF_SCREEN_WIDTH / 6, DEF_SCREEN_WIDTH / 7 * 0.6)];
    label.text = title;
    label.font = [UIFont systemFontOfSize:13];
    label.textAlignment = NSTextAlignmentCenter;
    label.center = CGPointMake(label.center.x, label.center.y * 0.9);
    [view addSubview:label];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark ---  电源条变色
-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

#pragma amrk - 获取字符串自适应后所占高度
- (CGSize)sizeOfStr:(NSString *)str
            andFont:(UIFont *)font
         andMaxSize:(CGSize)size
   andLineBreakMode:(NSLineBreakMode)mode
{
    CGSize s;
    if ([[[UIDevice currentDevice]systemVersion]doubleValue]>=7.0) {
        NSDictionary *dic=@{NSFontAttributeName:font};
        s = [str boundingRectWithSize:size options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                           attributes:dic context:nil].size;
    }
    else
    {
        s=[str sizeWithFont:font constrainedToSize:size lineBreakMode:mode];
    }
    return s;
}

-(void)login
{
    NSLog(@"login");
    
    back_view  = [[UIView alloc]initWithFrame:CGRectMake(0, 0, DEF_SCREEN_WIDTH, DEF_SCREEN_HEIGHT)];
    back_view.backgroundColor = DEF_RGBA_COLOR(0, 0, 0, 0.0);
    [self.view addSubview:back_view];
    
    view_user = [[UIView alloc]initWithFrame:CGRectMake(50, DEF_SCREEN_HEIGHT / 10 - DEF_SCREEN_HEIGHT, DEF_SCREEN_WIDTH - 100, 250)];
    view_user.backgroundColor = [UIColor clearColor];
    [back_view addSubview:view_user];
    
    
    view_top_2 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, DEF_WIDTH(view_user), 150)];
    
    view_one = [[UIView alloc]initWithFrame:CGRectMake(0, DEF_BOTTOM(view_top_2) - 90, DEF_WIDTH(view_top_2)  / 2 + 10, 90)];
    view_one.backgroundColor = DEF_RGB_COLOR(245, 245, 249);
    view_one.layer.masksToBounds = YES;
    view_one.layer.cornerRadius = 10.0;
    [view_user addSubview:view_one];
    UIButton * btn_one = [UIButton buttonWithType:0];
    btn_one.frame = CGRectMake(10, DEF_HEIGHT(view_one) - 45, DEF_WIDTH(view_one) - 30, 35);
    [self Eleven_Set_Button:btn_one setBackgroundColor:DEF_RGB_COLOR(129, 136, 158) setBackgroundImageNormal:nil setBackgroundImageHighlighted:nil setTitle:@"取消" setTitleFont:15 buttonTag:1 titleColor:[UIColor whiteColor]];
    [btn_one addTarget:self action:@selector(cancle) forControlEvents:UIControlEventTouchUpInside];
    [view_one addSubview:btn_one];
    
    
    view_two = [[UIView alloc]initWithFrame:CGRectMake(0, DEF_BOTTOM(view_top_2) - 90, DEF_WIDTH(view_top_2)  / 2 + 10, 90)];
    view_two.backgroundColor = DEF_RGB_COLOR(245, 245, 249);
    view_two.layer.masksToBounds = YES;
    view_two.layer.cornerRadius = 10.0;
    [view_user addSubview:view_two];
    UIButton * btn_two = [UIButton buttonWithType:0];
    btn_two.frame = CGRectMake(20, DEF_HEIGHT(view_two) - 45, DEF_WIDTH(view_two) - 30, 35);
    [self Eleven_Set_Button:btn_two setBackgroundColor:DEF_RGB_COLOR(243, 98, 79) setBackgroundImageNormal:nil setBackgroundImageHighlighted:nil setTitle:@"确定" setTitleFont:15 buttonTag:1 titleColor:[UIColor whiteColor]];
    [btn_two addTarget:self action:@selector(cancle) forControlEvents:UIControlEventTouchUpInside];
    [view_two addSubview:btn_two];
    
    
    view_top_2.backgroundColor = [UIColor whiteColor];
    view_top_2.layer.masksToBounds = YES;
    view_top_2.layer.cornerRadius = 10.0;
    [view_user addSubview:view_top_2];
    
    label_hint_2 = [[UILabel alloc]initWithFrame:CGRectMake(0, 15, DEF_WIDTH(view_user), 30)];
    [self Eleven_Set_label:label_hint_2 text:@"请输入您的手机号" textColor:[UIColor blackColor] fontSize:15 fontAlpha:1 textAlignment:3];
    [view_top_2 addSubview:label_hint_2];
    
    NSMutableAttributedString * att = [[NSMutableAttributedString alloc]initWithString:label_hint_2.text];
    NSRange range = [label_hint_2.text rangeOfString:@"手机号"];
    [att setAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17],NSForegroundColorAttributeName:DEF_RGB_COLOR(251, 17, 63)} range:range];
    label_hint_2.attributedText = att;
    
    text_phone = [[UITextField alloc]initWithFrame:CGRectMake(10, DEF_BOTTOM(label_hint_2) + 10, DEF_WIDTH(view_top_2) - 20, 35)];
    text_phone.delegate = self;
    text_phone.textAlignment = NSTextAlignmentCenter;
    text_phone.placeholder = @"手机号";
    text_phone.keyboardType = UIKeyboardTypeNumberPad;
    text_phone.font = [UIFont systemFontOfSize:15];
    text_phone.layer.borderColor=[DEF_RGB_COLOR(251, 17, 63)CGColor];
    text_phone.layer.borderWidth= 1.0f;
    text_phone.layer.masksToBounds = YES;
    text_phone.layer.cornerRadius = 5.0;
    text_phone.tag = 3;
    //text_phone.borderStyle = UITextBorderStyleRoundedRect;
    //text_phone.tintColor = [UIColor bl];
    [view_top_2 addSubview:text_phone];
    
    text_token = [[UITextField alloc]initWithFrame:CGRectMake(10, DEF_BOTTOM(text_phone) + 10, DEF_WIDTH(view_top_2)  - 120, 35)];
    text_token.textAlignment = NSTextAlignmentCenter;
    text_token.placeholder = @"验证码";
    text_token.tag = 1;
    text_token.delegate = self;
    text_token.font = [UIFont systemFontOfSize:15];
    text_token.keyboardType = UIKeyboardTypeNumberPad;
    text_token.layer.borderColor=[DEF_RGB_COLOR(230, 230, 230) CGColor];
    text_token.layer.borderWidth= 1.0f;
    text_token.layer.masksToBounds = YES;
    text_token.layer.cornerRadius = 5.0;
    //text_token.borderStyle = UITextBorderStyleRoundedRect;
    //text_token.tintColor = DEF_RGB_COLOR(245, 245, 249);
    [view_top_2 addSubview:text_token];
    
    UIButton * btn_token = [UIButton buttonWithType:0];
    btn_token.frame = CGRectMake(DEF_RIGHT(text_token) + 5, DEF_Y(text_token), 100, DEF_HEIGHT(text_token));
    [self Eleven_Set_Button:btn_token setBackgroundColor:DEF_RGB_COLOR(235, 235, 239) setBackgroundImageNormal:nil setBackgroundImageHighlighted:nil setTitle:@"发送验证码" setTitleFont:14 buttonTag:1 titleColor:[UIColor whiteColor]];
    [view_top_2 addSubview:btn_token];
    
    [UIView animateWithDuration:0.5 animations:^{
        
        back_view.backgroundColor = DEF_RGBA_COLOR(0, 0, 0, 0.3);
        
        view_user.frame = CGRectMake(50, DEF_SCREEN_HEIGHT / 10, DEF_SCREEN_WIDTH - 100, 250);
        
        
    } completion:^(BOOL finished) {
        
        [UIView animateWithDuration:0.3 animations:^{
            
            view_one.frame = CGRectMake(0, DEF_BOTTOM(view_top_2) - 30 , DEF_WIDTH(view_one), DEF_HEIGHT(view_one));
            view_two.frame = CGRectMake(0, DEF_BOTTOM(view_top_2) - 30 , DEF_WIDTH(view_one), DEF_HEIGHT(view_one));
        } completion:^(BOOL finished) {
            
            [UIView animateWithDuration:0.3 animations:^{
                
                view_two.frame = CGRectMake(DEF_WIDTH(view_top_2) / 2 - 10, DEF_BOTTOM(view_top_2) - 30 , DEF_WIDTH(view_one), DEF_HEIGHT(view_one));
                
            } completion:^(BOOL finished) {
                
                [text_phone becomeFirstResponder];
                
            }];
            
        }];
    }];
    
}

-(void)cancle
{
    [self.view endEditing:YES];
    
    
    
    [UIView animateWithDuration:0.3 animations:^{
        
        view_two.frame = CGRectMake(0, DEF_BOTTOM(view_top_2) - 30 , DEF_WIDTH(view_one), DEF_HEIGHT(view_one));
        
    } completion:^(BOOL finished) {
        
        [UIView animateWithDuration:0.3 animations:^{
            
            view_two.frame = CGRectMake(0, DEF_BOTTOM(view_top_2) - 90, DEF_WIDTH(view_top_2)  / 2 + 10, 90);
            view_one.frame = CGRectMake(0, DEF_BOTTOM(view_top_2) - 90, DEF_WIDTH(view_top_2)  / 2 + 10, 90);
            
        } completion:^(BOOL finished) {
            
            [UIView animateWithDuration:0.5 animations:^{
                view_user.frame = CGRectMake(50, DEF_SCREEN_HEIGHT / 10 - DEF_SCREEN_HEIGHT, DEF_SCREEN_WIDTH - 100, 250);
                back_view.backgroundColor = DEF_RGBA_COLOR(0, 0, 0, 0.0);
            } completion:^(BOOL finished) {
                
                [view_top_2 removeFromSuperview];
                view_top_2 = nil;
                [view_user removeFromSuperview];
                view_user = nil;
                [back_view removeFromSuperview];
                back_view = nil;
                
            }];
            
        }];
        
    }];
    
    
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if(text_phone.text.length == 10)
    {
        text_phone.text = [NSString stringWithFormat:@"%@%@",text_phone.text,string];
        
        text_token.tag = 2;
        if(text_token.text.length == 0)
        {
            [text_token becomeFirstResponder];
//            text_token.layer.borderColor=[DEF_RGB_COLOR(251, 17, 63) CGColor];
//            text_phone.layer.borderColor=[DEF_RGB_COLOR(230, 230, 230) CGColor];
            return NO;
        }
    }
    else
    {
        text_token.tag = 1;
    }
    
    
    
    if(text_phone.text.length >= 11 && text_phone.tag == 1)
    {
        text_phone.text = [text_phone.text substringToIndex:11];
        return NO;
    }
    
    
    
    return YES;
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if(text_phone.text.length != 11 && textField.tag == 1)
    {
        CAKeyframeAnimation * keyAnima_rotation = [CAKeyframeAnimation animation];
        keyAnima_rotation.keyPath = @"transform.rotation";
        keyAnima_rotation.duration = 0.1;
        
        //设置图片抖动弧度
        //把度数换成弧度 度数/180 * M_PI
        keyAnima_rotation.values = @[@(0),@(0.2),@(0)];
        
        //设置动画的重复次数
        keyAnima_rotation.repeatCount = 5;
        
        keyAnima_rotation.fillMode = kCAFillModeForwards;
        keyAnima_rotation.removedOnCompletion = NO;
        
        [label_hint_2.layer addAnimation:keyAnima_rotation forKey:nil];
        return NO;
    }
    
    if(textField.tag == 3)
    {
        text_phone.layer.borderColor=[DEF_RGB_COLOR(251, 17, 63) CGColor];
        text_token.layer.borderColor=[DEF_RGB_COLOR(230, 230, 230) CGColor];
    }
    
    if(textField.tag < 3)
    {
        text_token.layer.borderColor=[DEF_RGB_COLOR(251, 17, 63) CGColor];
        text_phone.layer.borderColor=[DEF_RGB_COLOR(230, 230, 230) CGColor];
    }
    
    return YES;
    
}

#pragma mark - 创建 button
- (void)Eleven_Set_Button:(UIButton*)button
       setBackgroundColor:(UIColor*)color
 setBackgroundImageNormal:(NSString*)NormalImage_str
setBackgroundImageHighlighted:(NSString*)HighlightedImage_str
                 setTitle:(NSString*)text
             setTitleFont:(NSInteger)integer
                buttonTag:(NSInteger)tag titleColor:(UIColor *)titleCol
{
    if(color != nil)
    {
        [button setBackgroundColor:color];
    }
    
    [button setBackgroundImage:[UIImage imageNamed:NormalImage_str] forState:UIControlStateNormal];
    
    [button setBackgroundImage:[UIImage imageNamed:HighlightedImage_str] forState:UIControlStateHighlighted];
    
    [button setTitle:text forState:UIControlStateNormal];
    
    [button.layer setMasksToBounds:YES];
    [button.layer setCornerRadius:5.0];
    
    if(titleCol == [UIColor blackColor])
    {
        [button.titleLabel setFont:[UIFont systemFontOfSize:integer]];
    }
    else
    {
        [button.titleLabel setFont:[UIFont boldSystemFontOfSize:integer]];
    }
    
    [button setTitleColor:titleCol forState:UIControlStateNormal];
    
    button.tag = tag;
}

#pragma mark - 创建 Label
- (void)Eleven_Set_label:(UILabel*)label
                    text:(NSString*)text
               textColor:(UIColor*)color
                fontSize:(NSInteger)size
               fontAlpha:(CGFloat)alpha
           textAlignment:(NSInteger)textAlignment
{
    label.numberOfLines = 0;
    label.text = text;
    //[label setBackgroundColor:[UIColor clearColor]];
    [label setTextColor:color];
    [label setFont:[UIFont systemFontOfSize:size]];
    //[label setAlpha:alpha];
    
    if (textAlignment == 1) {
        [label setTextAlignment:NSTextAlignmentLeft];
    }else if (textAlignment == 2){
        [label setTextAlignment:NSTextAlignmentRight];
    }else if (textAlignment == 3){
        [label setTextAlignment:NSTextAlignmentCenter];
    }else{
        [label setTextAlignment:NSTextAlignmentJustified];
    }
}

#pragma mark --  设置刷新
- (void)setupRefresh
{
    // 1.下拉刷新(进入刷新状态就会调用self的headerRereshing)
    [scrol addHeaderWithTarget:self action:@selector(headerRereshing)];
    
    scrol.footerPullToRefreshText = @"上拉加载";
    scrol.footerReleaseToRefreshText = @"松开加载更多数据";
    scrol.footerRefreshingText = @"正在加载";
}

-(void)headerRereshing
{
    //[self removebtnall];
    
    //[self end_search];
    dispatch_async(dispatch_get_main_queue(), ^{
        
        sleep(1);
        [scrol headerEndRefreshing];
        
    });
    
    //sleep(1);
    
}

@end

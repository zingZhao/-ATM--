//
//  UserViewController.m
//  口袋ATM
//
//  Created by 赵奎博 on 16/3/22.
//  Copyright © 2016年 赵奎博. All rights reserved.
//

#import "UserViewController.h"
#import "InComeViewController.h"
#import "MyTudiViewController.h"
#import "HelpViewController.h"
#import "FeedBackViewController.h"
@interface UserViewController ()<UITextFieldDelegate>
{
    UIView * back_view;
    UIView * view_user;
    UIView * view_top;
    UITextField * text_phone;
    UITextField * text_token;
    
    UIView * view_one;
    UIView * view_two;
    UILabel * label_hint;
}
@end

@implementation UserViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self addNavgationTitle:@"个人中心"];
    [self addNavgationLeftButton:@"toolbar_arrow"];
    
    [self initUI];

}

-(void)initUI
{
    self.view.backgroundColor = DEF_RGB_COLOR(245, 245, 249);
    self.contentView.frame = CGRectMake(0, topHight, DEF_SCREEN_WIDTH, DEF_SCREEN_HEIGHT - topHight);
    self.contentView.backgroundColor = DEF_RGB_COLOR(245, 245, 249);
    
//第一部分
    view_top = [[UIView alloc]initWithFrame:CGRectMake(0, 0, DEF_SCREEN_WIDTH, 100)];
    view_top.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:view_top];
    
    UIImageView * user_image = [[UIImageView alloc]initWithFrame:CGRectMake(20, 20, 60, 60)];
    user_image.image = [UIImage imageNamed:@"fang"];
    user_image.layer.masksToBounds = YES;
    user_image.layer.cornerRadius = DEF_WIDTH(user_image) / 2;
    [view_top addSubview:user_image];
    
    UILabel * label_one = [[UILabel alloc]initWithFrame:CGRectMake(DEF_RIGHT(user_image) + 20, 25, DEF_SCREEN_WIDTH - DEF_RIGHT(user_image) - 20, 20)];
    [self Eleven_Set_label:label_one text:@"一缕微阳" textColor:[UIColor blackColor] fontSize:16 fontAlpha:1 textAlignment:1];
    [view_top addSubview:label_one];
    
    UIImageView * image_two = [[UIImageView alloc]initWithFrame:CGRectMake(DEF_X(label_one), 48, 13, 13)];
    image_two.image = [UIImage imageNamed:@"detail_expense"];
    [view_top addSubview:image_two];
    
    UILabel * label_two = [[UILabel alloc]initWithFrame:CGRectMake(DEF_RIGHT(image_two), 45, DEF_SCREEN_WIDTH - DEF_RIGHT(image_two), 20)];
    [self Eleven_Set_label:label_two text:@"已绑定微信公众号" textColor:[UIColor blackColor] fontSize:12 fontAlpha:1 textAlignment:1];
    [view_top addSubview:label_two];
    
    UIImageView * image_three = [[UIImageView alloc]initWithFrame:CGRectMake(DEF_X(label_one), 69, 13, 13)];
    image_three.image = [UIImage imageNamed:@"close"];
    [view_top addSubview:image_three];
    
    UILabel * label_three = [[UILabel alloc]initWithFrame:CGRectMake(DEF_RIGHT(image_three), 65, DEF_SCREEN_WIDTH - DEF_RIGHT(image_three) - 20, 20)];
    [self Eleven_Set_label:label_three text:@"未绑定手机号码   立即登录" textColor:[UIColor blackColor] fontSize:12 fontAlpha:1 textAlignment:1];
    label_three.userInteractionEnabled = YES;
    NSMutableAttributedString * att = [[NSMutableAttributedString alloc]initWithString:label_three.text];
    
    NSRange range = [label_three.text rangeOfString:@"立即登录"];
    [att setAttributes:@{NSForegroundColorAttributeName:DEF_RGB_COLOR(251, 17, 63)} range:range];
    label_three.attributedText = att;
    
    [view_top addSubview:label_three];
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(login)];
    [label_three addGestureRecognizer:tap];
    
//第二部分
    UIView * view_two_1 = [[UIView alloc]initWithFrame:CGRectMake(0, DEF_BOTTOM(view_top) + 1, DEF_SCREEN_WIDTH, 42)];
    view_two_1.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:view_two_1];
    
    UIButton * btn_left = [UIButton buttonWithType:0];
    btn_left.frame = CGRectMake(0, 0, DEF_SCREEN_WIDTH / 2 - 0.5, DEF_HEIGHT(view_two_1));
    [btn_left setImage:[UIImage imageNamed:@"user_income"] forState:0];
    [btn_left addTarget:self action:@selector(left) forControlEvents:UIControlEventTouchUpInside];
    [btn_left setAdjustsImageWhenHighlighted:NO];
    [view_two_1 addSubview:btn_left];
    
    UIButton * btn_right = [UIButton buttonWithType:0];
    btn_right.frame = CGRectMake(DEF_SCREEN_WIDTH / 2 + 0.5, 0, DEF_SCREEN_WIDTH / 2 - 0.5, DEF_HEIGHT(view_two_1));
    [btn_right setImage:[UIImage imageNamed:@"user_disciple"] forState:0];
    [btn_right setAdjustsImageWhenHighlighted:NO];
    [btn_right addTarget:self action:@selector(right) forControlEvents:UIControlEventTouchUpInside];
    [view_two_1 addSubview:btn_right];
    
//第三部分
//    NSArray * array_image = @[@"more_icon0",@"more_icon1_news",@"more_icon_question",@"more_icon4_ask",@"more_icon5",@"more_icon6"];
//    NSArray * array_title = @[@"我要提现",@"消息提醒",@"常见问题",@"意见反馈",@"检查更新",@"关于我们"];
    NSArray * array_image = @[@"more_icon_question",@"more_icon4_ask",@"more_icon5"];
    NSArray * array_title = @[@"常见问题",@"意见反馈",@"检查更新"];
    
    UIView * view_bottom = [[UIView alloc]initWithFrame:CGRectMake(0, DEF_BOTTOM(view_two_1) + 10, DEF_SCREEN_WIDTH, array_image.count * 40)];
    view_bottom.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:view_bottom];
    
    for(int i=0; i< array_image.count; i++)
    {
        UIView * view_section = [[UIView alloc]initWithFrame:CGRectMake(0, i * 40, DEF_SCREEN_WIDTH, 40)];
        view_section.tag = i;
        [view_bottom addSubview:view_section];
        
        UITapGestureRecognizer * tap_section = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(sectionAction:)];
        [view_section addGestureRecognizer:tap_section];
        
        UIImageView * image = [[UIImageView alloc]initWithFrame:CGRectMake(20, 10, 20, 20)];
        NSString * path = [[NSBundle mainBundle]pathForResource:array_image[i] ofType:@"png"];
        image.image = [UIImage imageWithContentsOfFile:path];
        [view_section addSubview:image];
        
        UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(DEF_RIGHT(image) + 20, 0, DEF_SCREEN_WIDTH - 80, 40)];
        [self Eleven_Set_label:label text:array_title[i] textColor:[UIColor blackColor] fontSize:16 fontAlpha:1 textAlignment:1];
        [view_section addSubview:label];
        
        UIImageView * image_enter = [[UIImageView alloc]initWithFrame:CGRectMake(DEF_SCREEN_WIDTH - 30, 10, 15, 20)];
        NSString * path_2 = [[NSBundle mainBundle]pathForResource:@"more_arrow" ofType:@"png"];
        image_enter.image = [UIImage imageWithContentsOfFile:path_2];
        [view_section addSubview:image_enter];
        
        if(i == array_title.count - 1)
        {
            break;
        }
        
        UILabel * label_li = [[UILabel alloc]initWithFrame:CGRectMake(DEF_X(label), 39, DEF_SCREEN_WIDTH - DEF_X(label), 1)];
        label_li.backgroundColor = DEF_RGB_COLOR(200, 200, 200);
        [view_section addSubview:label_li];
    }
    
    self.contentView.contentSize = CGSizeMake(DEF_SCREEN_WIDTH, DEF_BOTTOM(view_bottom) + 20);
}

-(void)sectionAction:(UITapGestureRecognizer *)tap
{
    switch (tap.view.tag) {
        case 9:
        {
            
        }
            break;
            
        case 8:
        {
            
        }
            break;
            
        case 0:
        {
            HelpViewController * hvc = [[HelpViewController alloc]init];
            [self.navigationController pushViewController:hvc animated:YES];
        }
            break;
            
        case 1:
        {
            FeedBackViewController * fvc = [[FeedBackViewController alloc]init];
            [self.navigationController pushViewController:fvc animated:YES];
        }
            break;
            
        case 2:
        {
            UIAlertView * al = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"当前版本已是最新版本!" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [al show];
        }
            break;
            
        case 5:
        {
            
        }
            break;
            
        default:
            break;
    }
}

-(void)right
{
    MyTudiViewController * mvc = [[MyTudiViewController alloc]init];
    [self.navigationController pushViewController:mvc animated:YES];
}

-(void)left{
    InComeViewController * ivc = [[InComeViewController alloc]init];
    [self.navigationController pushViewController:ivc animated:YES];
}

-(void)cancle
{
    [self.view endEditing:YES];
    
    
    
    [UIView animateWithDuration:0.3 animations:^{
        
        view_two.frame = CGRectMake(0, DEF_BOTTOM(view_top) - 30 , DEF_WIDTH(view_one), DEF_HEIGHT(view_one));
        
    } completion:^(BOOL finished) {
        
        [UIView animateWithDuration:0.3 animations:^{
            
            view_two.frame = CGRectMake(0, DEF_BOTTOM(view_top) - 90, DEF_WIDTH(view_top)  / 2 + 10, 90);
            view_one.frame = CGRectMake(0, DEF_BOTTOM(view_top) - 90, DEF_WIDTH(view_top)  / 2 + 10, 90);
            
        } completion:^(BOOL finished) {
            
            [UIView animateWithDuration:0.5 animations:^{
                view_user.frame = CGRectMake(50, DEF_SCREEN_HEIGHT / 10 - DEF_SCREEN_HEIGHT, DEF_SCREEN_WIDTH - 100, 250);
                back_view.backgroundColor = DEF_RGBA_COLOR(0, 0, 0, 0.0);
            } completion:^(BOOL finished) {
                
                [view_top removeFromSuperview];
                view_top = nil;
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
        
        [label_hint.layer addAnimation:keyAnima_rotation forKey:nil];
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
//
//-(void)textFieldDidBeginEditing:(UITextField *)textField
//{
//    if(textField.tag == 2 && textField.text.length == 1)
//    {
//        textField.text = @"";
//    }
//}


-(void)login
{
    NSLog(@"login");
    
    back_view  = [[UIView alloc]initWithFrame:CGRectMake(0, 0, DEF_SCREEN_WIDTH, DEF_SCREEN_HEIGHT)];
    back_view.backgroundColor = DEF_RGBA_COLOR(0, 0, 0, 0.0);
    [self.view addSubview:back_view];
    
    view_user = [[UIView alloc]initWithFrame:CGRectMake(50, DEF_SCREEN_HEIGHT / 10 - DEF_SCREEN_HEIGHT, DEF_SCREEN_WIDTH - 100, 250)];
    view_user.backgroundColor = [UIColor clearColor];
    [back_view addSubview:view_user];
    
    
    view_top = [[UIView alloc]initWithFrame:CGRectMake(0, 0, DEF_WIDTH(view_user), 150)];
    
    view_one = [[UIView alloc]initWithFrame:CGRectMake(0, DEF_BOTTOM(view_top) - 90, DEF_WIDTH(view_top)  / 2 + 10, 90)];
    view_one.backgroundColor = DEF_RGB_COLOR(245, 245, 249);
    view_one.layer.masksToBounds = YES;
    view_one.layer.cornerRadius = 10.0;
    [view_user addSubview:view_one];
    UIButton * btn_one = [UIButton buttonWithType:0];
    btn_one.frame = CGRectMake(10, DEF_HEIGHT(view_one) - 45, DEF_WIDTH(view_one) - 30, 35);
    [self Eleven_Set_Button:btn_one setBackgroundColor:DEF_RGB_COLOR(129, 136, 158) setBackgroundImageNormal:nil setBackgroundImageHighlighted:nil setTitle:@"取消" setTitleFont:15 buttonTag:1 titleColor:[UIColor whiteColor]];
    [btn_one addTarget:self action:@selector(cancle) forControlEvents:UIControlEventTouchUpInside];
    [view_one addSubview:btn_one];

    
    view_two = [[UIView alloc]initWithFrame:CGRectMake(0, DEF_BOTTOM(view_top) - 90, DEF_WIDTH(view_top)  / 2 + 10, 90)];
    view_two.backgroundColor = DEF_RGB_COLOR(245, 245, 249);
    view_two.layer.masksToBounds = YES;
    view_two.layer.cornerRadius = 10.0;
    [view_user addSubview:view_two];
    UIButton * btn_two = [UIButton buttonWithType:0];
    btn_two.frame = CGRectMake(20, DEF_HEIGHT(view_two) - 45, DEF_WIDTH(view_two) - 30, 35);
    [self Eleven_Set_Button:btn_two setBackgroundColor:DEF_RGB_COLOR(243, 98, 79) setBackgroundImageNormal:nil setBackgroundImageHighlighted:nil setTitle:@"确定" setTitleFont:15 buttonTag:1 titleColor:[UIColor whiteColor]];
    [btn_two addTarget:self action:@selector(cancle) forControlEvents:UIControlEventTouchUpInside];
    [view_two addSubview:btn_two];
    
    
    view_top.backgroundColor = [UIColor whiteColor];
    view_top.layer.masksToBounds = YES;
    view_top.layer.cornerRadius = 10.0;
    [view_user addSubview:view_top];
    
    label_hint = [[UILabel alloc]initWithFrame:CGRectMake(0, 15, DEF_WIDTH(view_user), 30)];
    [self Eleven_Set_label:label_hint text:@"请输入您的手机号" textColor:[UIColor blackColor] fontSize:15 fontAlpha:1 textAlignment:3];
    [view_top addSubview:label_hint];
    
    NSMutableAttributedString * att = [[NSMutableAttributedString alloc]initWithString:label_hint.text];
    NSRange range = [label_hint.text rangeOfString:@"手机号"];
    [att setAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17],NSForegroundColorAttributeName:DEF_RGB_COLOR(251, 17, 63)} range:range];
    label_hint.attributedText = att;
    
    text_phone = [[UITextField alloc]initWithFrame:CGRectMake(10, DEF_BOTTOM(label_hint) + 10, DEF_WIDTH(view_top) - 20, 35)];
    text_phone.delegate = self;
    text_phone.textAlignment = NSTextAlignmentCenter;
    text_phone.placeholder = @"手机号";
    text_phone.layer.borderColor=[DEF_RGB_COLOR(251, 17, 63)CGColor];
    text_phone.layer.borderWidth= 1.0f;
    text_phone.layer.masksToBounds = YES;
    text_phone.layer.cornerRadius = 5.0;
    text_phone.tag = 3;
    //text_phone.borderStyle = UITextBorderStyleRoundedRect;
    text_phone.keyboardType = UIKeyboardTypeNumberPad;
    text_phone.font = [UIFont systemFontOfSize:15];
    //text_phone.tintColor = DEF_RGB_COLOR(251, 17, 63);
    [view_top addSubview:text_phone];
    
    text_token = [[UITextField alloc]initWithFrame:CGRectMake(10, DEF_BOTTOM(text_phone) + 10, DEF_WIDTH(view_top)  - 120, 35)];
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
//    text_token.borderStyle = UITextBorderStyleRoundedRect;
//    text_token.tintColor = DEF_RGB_COLOR(245, 245, 249);
    [view_top addSubview:text_token];
    
    UIButton * btn_token = [UIButton buttonWithType:0];
    btn_token.frame = CGRectMake(DEF_RIGHT(text_token) + 5, DEF_Y(text_token), 100, DEF_HEIGHT(text_token));
    [self Eleven_Set_Button:btn_token setBackgroundColor:DEF_RGB_COLOR(235, 235, 239) setBackgroundImageNormal:nil setBackgroundImageHighlighted:nil setTitle:@"发送验证码" setTitleFont:14 buttonTag:1 titleColor:[UIColor whiteColor]];
    [view_top addSubview:btn_token];
    
    [UIView animateWithDuration:0.5 animations:^{
        
        back_view.backgroundColor = DEF_RGBA_COLOR(0, 0, 0, 0.3);
        
        view_user.frame = CGRectMake(50, DEF_SCREEN_HEIGHT / 10, DEF_SCREEN_WIDTH - 100, 250);
        
       
    } completion:^(BOOL finished) {
        
        [UIView animateWithDuration:0.3 animations:^{
            
            view_one.frame = CGRectMake(0, DEF_BOTTOM(view_top) - 30 , DEF_WIDTH(view_one), DEF_HEIGHT(view_one));
            view_two.frame = CGRectMake(0, DEF_BOTTOM(view_top) - 30 , DEF_WIDTH(view_one), DEF_HEIGHT(view_one));
        } completion:^(BOOL finished) {
            
            [UIView animateWithDuration:0.3 animations:^{
                
                view_two.frame = CGRectMake(DEF_WIDTH(view_top) / 2 - 10, DEF_BOTTOM(view_top) - 30 , DEF_WIDTH(view_one), DEF_HEIGHT(view_one));
                
            } completion:^(BOOL finished) {
                
                [text_phone becomeFirstResponder];
                
            }];
            
        }];
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

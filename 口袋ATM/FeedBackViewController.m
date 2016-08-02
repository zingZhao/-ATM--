//
//  FeedBackViewController.m
//  口袋ATM
//
//  Created by 赵奎博 on 16/3/23.
//  Copyright © 2016年 赵奎博. All rights reserved.
//

#import "FeedBackViewController.h"

@interface FeedBackViewController ()<UITableViewDataSource,UITableViewDelegate,UITextViewDelegate,UITextFieldDelegate>
{
    UITableView * _tableView;
    
    UITextField * textf;
    
    UITextView * _textSend;
    
    UIView * view_botyom;
    UIView * view_line;
    UIButton * btn_send;
    UIImageView * image_luang;
    
    UIView * view_input;
    UITextField * textFiledQQ;
    UITextField * textFiledTel;
    UITextField * textFiledEmail;
    UITextField * textFiledOther;
    
    BOOL isnum;
    UILabel * label_top_left;
}
@end

@implementation FeedBackViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    [self addNavgationTitle:@"用户反馈"];
    [self addNavgationRightButton_title:@"关闭" title_Color:[UIColor whiteColor]];
    
    
    [self initUI];

}

-(void)rightAction
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)save
{
    NSLog(@"save");
    label_top_left.text = [NSString stringWithFormat:@"QQ:%@ 电话:%@\n邮箱:%@ 其他:%@",textFiledQQ.text,textFiledTel.text,textFiledEmail.text,textFiledOther.text];
    [textFiledEmail resignFirstResponder];
    [textFiledTel resignFirstResponder];
    [textFiledQQ resignFirstResponder];
    [textFiledOther resignFirstResponder];
    [self.view endEditing:YES];
    
    [self.backgroundView removeFromSuperview];

}

-(void)cancle
{
    NSLog(@"cancle");
    [textFiledEmail resignFirstResponder];
    [textFiledTel resignFirstResponder];
    [textFiledQQ resignFirstResponder];
    [textFiledOther resignFirstResponder];
    [self.view endEditing:YES];
    
    [self.backgroundView removeFromSuperview];

    
}

-(void)seg:(UISegmentedControl *)seg
{
    switch (seg.selectedSegmentIndex) {
        case 0:
        {
            if(isnum)
            {
                [textFiledQQ becomeFirstResponder];
                [view_input addSubview:textFiledQQ];
                break;
            }
            isnum = YES;
            [textFiledTel removeFromSuperview];
            [textFiledEmail removeFromSuperview];
            [textFiledOther removeFromSuperview];
            [textFiledQQ becomeFirstResponder];
            [view_input addSubview:textFiledQQ];
        }
            break;
        case 1:
            if(isnum)
            {
                [textFiledTel becomeFirstResponder];
                [view_input addSubview:textFiledTel];
                break;
            }
            isnum = YES;
            [textFiledQQ removeFromSuperview];
            [textFiledEmail removeFromSuperview];
            [textFiledOther removeFromSuperview];
            [textFiledTel becomeFirstResponder];
            [view_input addSubview:textFiledTel];
            break;
        case 2:
            if(isnum)
            {
                isnum = NO;
            }
            [textFiledTel removeFromSuperview];
            [textFiledQQ removeFromSuperview];
            [textFiledOther removeFromSuperview];
            [textFiledEmail becomeFirstResponder];
            [view_input addSubview:textFiledEmail];
            break;
        case 3:
            if(isnum)
            {
                isnum = NO;
            }
            [textFiledTel removeFromSuperview];
            [textFiledEmail removeFromSuperview];
            [textFiledQQ removeFromSuperview];
            [textFiledOther becomeFirstResponder];
            [view_input addSubview:textFiledOther];
            break;
            
        default:
            break;
    }
}

-(void)initUI
{
    isnum = YES;
    view_input = [[UIView alloc]initWithFrame:CGRectMake(0, 0, DEF_SCREEN_WIDTH, 90)];
    view_input.backgroundColor = DEF_RGB_COLOR(245, 245, 249);
    textFiledQQ = [[UITextField alloc]initWithFrame:CGRectMake(60, 10, DEF_SCREEN_WIDTH - 120, 30)];
    textFiledQQ.placeholder = @"请输入QQ号";
    textFiledQQ.borderStyle = UITextBorderStyleRoundedRect;
    textFiledQQ.keyboardType = UIKeyboardTypeNumberPad;
    [view_input addSubview:textFiledQQ];
    
    textFiledTel = [[UITextField alloc]initWithFrame:CGRectMake(60, 10, DEF_SCREEN_WIDTH - 120, 30)];
    textFiledTel.placeholder = @"请输入手机号";
    textFiledTel.borderStyle = UITextBorderStyleRoundedRect;
    textFiledTel.keyboardType = UIKeyboardTypeNumberPad;
    //[view_input addSubview:textFiledTel];
    
    textFiledEmail = [[UITextField alloc]initWithFrame:CGRectMake(60, 10, DEF_SCREEN_WIDTH - 120, 30)];
    textFiledEmail.placeholder = @"请输入邮箱";
    textFiledEmail.borderStyle = UITextBorderStyleRoundedRect;
    textFiledEmail.keyboardType = UIKeyboardTypeDefault;
    //[view_input addSubview:textFiledEmail];
    
    textFiledOther = [[UITextField alloc]initWithFrame:CGRectMake(60, 10, DEF_SCREEN_WIDTH - 120, 30)];
    textFiledOther.placeholder = @"随便写点什么吧";
    textFiledOther.borderStyle = UITextBorderStyleRoundedRect;
    textFiledOther.keyboardType = UIKeyboardTypeDefault;
    //[view_input addSubview:textFiledOther];
    
    UIButton * btn_left = [UIButton buttonWithType:0];
    btn_left.frame = CGRectMake(0, 10, 60, 30);
    [self Eleven_Set_Button:btn_left setBackgroundColor:[UIColor clearColor] setBackgroundImageNormal:nil setBackgroundImageHighlighted:nil setTitle:@"取消" setTitleFont:15 buttonTag:11 titleColor:DEF_RGB_COLOR(82, 188, 248)];
    [btn_left addTarget:self action:@selector(cancle) forControlEvents:UIControlEventTouchUpInside];
    [view_input addSubview:btn_left];
    
    UIButton * btn_right = [UIButton buttonWithType:0];
    btn_right.frame = CGRectMake(DEF_SCREEN_WIDTH - 60, 10, 60, 30);
    [self Eleven_Set_Button:btn_right setBackgroundColor:[UIColor clearColor] setBackgroundImageNormal:nil setBackgroundImageHighlighted:nil setTitle:@"保存" setTitleFont:15 buttonTag:11 titleColor:DEF_RGB_COLOR(82, 188, 248)];
    [btn_right addTarget:self action:@selector(save) forControlEvents:UIControlEventTouchUpInside];
    [view_input addSubview:btn_right];
    
    UISegmentedControl * segment = [[UISegmentedControl alloc]initWithItems:@[@"QQ",@"电话",@"邮箱",@"其他"]];
    segment.selectedSegmentIndex = 0;
    //segment.backgroundColor = [UIColor grayColor];
    segment.tintColor = [UIColor grayColor];
    segment.frame = CGRectMake(10, DEF_BOTTOM(textFiledQQ) + 10, DEF_SCREEN_WIDTH - 20, 30);
    [segment addTarget:self action:@selector(seg:) forControlEvents:UIControlEventValueChanged];
    [view_input addSubview:segment];
    
    textf = [[UITextField alloc]init];
    textf.inputAccessoryView = view_input;
    [self.view addSubview:textf];
    
    
    //self.contentView.backgroundColor = DEF_RGB_COLOR(245, 245, 249);
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, DEF_SCREEN_WIDTH, DEF_SCREEN_HEIGHT - topHight - 50)];
    _tableView.tableFooterView = [[UIView alloc]init];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    //_tableView.backgroundColor = DEF_RGB_COLOR(245, 245, 249);
    [self.contentView addSubview:_tableView];
    
    UIView * view_top = [[UIView alloc]initWithFrame:CGRectMake(0, 0, DEF_SCREEN_WIDTH, 50)];
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(keyboardShow)];
    [view_top addGestureRecognizer:tap];
    view_top.backgroundColor = DEF_RGB_COLOR(245, 245, 249);
    _tableView.tableHeaderView = view_top;
    
    label_top_left = [[UILabel alloc]initWithFrame:CGRectMake(5, 0, DEF_SCREEN_WIDTH - 120, 50)];
    [self Eleven_Set_label:label_top_left text:@"QQ: 电话:\n邮箱: 其他:" textColor:[UIColor blackColor] fontSize:12 fontAlpha:1 textAlignment:1];
    label_top_left.userInteractionEnabled = YES;
    [view_top addSubview:label_top_left];
    
    UILabel * label_right = [[UILabel alloc]initWithFrame:CGRectMake(DEF_SCREEN_WIDTH - 115, 0, 110, 50)];
    [self Eleven_Set_label:label_right text:@"完善联系信息" textColor:[UIColor blackColor] fontSize:16 fontAlpha:1 textAlignment:2];
    label_right.userInteractionEnabled = YES;
    [view_top addSubview:label_right];
    
    view_botyom = [[UIView alloc]initWithFrame:CGRectMake(0, DEF_SCREEN_HEIGHT - 50 - topHight, DEF_SCREEN_WIDTH, 50)];
    view_botyom.backgroundColor = DEF_RGB_COLOR(245, 245, 249);
    [self.contentView addSubview:view_botyom];
    
    view_line = [[UIView alloc]initWithFrame:CGRectMake(0, 0, DEF_SCREEN_WIDTH, 0.5)];
    view_line.backgroundColor = DEF_RGB_COLOR(150, 150, 150);
    [view_botyom addSubview:view_line];
    
    image_luang = [[UIImageView alloc]initWithFrame:CGRectMake(9, 9, DEF_SCREEN_WIDTH - 78, 32)];
    image_luang.layer.masksToBounds = YES;
    image_luang.layer.cornerRadius = 5.0;
    image_luang.userInteractionEnabled = YES;
    image_luang.backgroundColor = DEF_RGB_COLOR(150, 150, 150);
    [view_botyom addSubview:image_luang];
    
    _textSend = [[UITextView alloc]initWithFrame:CGRectMake(1, 1, DEF_SCREEN_WIDTH - 80, 30)];
    //_textSend.borderStyle = UITextBorderStyleRoundedRect;
    _textSend.delegate = self;
    _textSend.layer.masksToBounds = YES;
    _textSend.layer.cornerRadius = 4.0;
    _textSend.font = [UIFont systemFontOfSize:16];
    [image_luang addSubview:_textSend];
    
    btn_send = [UIButton buttonWithType:0];
    btn_send.frame = CGRectMake(DEF_SCREEN_WIDTH - 70, 0, 70, 50);
    [self Eleven_Set_Button:btn_send setBackgroundColor:[UIColor clearColor] setBackgroundImageNormal:nil setBackgroundImageHighlighted:nil setTitle:@"发送" setTitleFont:16 buttonTag:1 titleColor:DEF_RGB_COLOR(200, 200, 200)];
    [btn_send addTarget:self action:@selector(send) forControlEvents:UIControlEventTouchUpInside];
    [view_botyom addSubview:btn_send];
}

-(void)textViewDidChange:(UITextView *)textView
{
    if(textView.text.length > 0)
    {
        [btn_send setTitleColor:DEF_RGB_COLOR(82, 188, 248) forState:0];
    }
    else
    {
        [btn_send setTitleColor:DEF_RGB_COLOR(200, 200, 200) forState:0];
    }
    
    CGSize size = [self sizeOfStr:textView.text andFont:[UIFont systemFontOfSize:16] andMaxSize:CGSizeMake(DEF_WIDTH(_textSend) - 10, 200000) andLineBreakMode:NSLineBreakByWordWrapping];
    
    if(size.height < 20)
    {
        view_botyom.frame = CGRectMake(0, DEF_SCREEN_HEIGHT - [self.contentView keyboardRect].size.height - topHight - 50, DEF_WIDTH(view_botyom), 50);
        image_luang.frame = CGRectMake(9, 9, DEF_WIDTH(image_luang), 32);
        _textSend.frame = CGRectMake(1, 1, DEF_WIDTH(_textSend), 30);
        btn_send.frame = CGRectMake(DEF_SCREEN_WIDTH - 70, DEF_HEIGHT(view_botyom) - 50, 70, 50);
        return;
    }
    view_botyom.frame = CGRectMake(0, DEF_SCREEN_HEIGHT - [self.contentView keyboardRect].size.height - topHight - size.height * 1.1 - 20, DEF_WIDTH(view_botyom), size.height * 1.1 + 20);
    image_luang.frame = CGRectMake(9, 9, DEF_WIDTH(image_luang), size.height * 1.1 + 2);
    _textSend.frame = CGRectMake(1, 1, DEF_WIDTH(_textSend), size.height * 1.1);
    btn_send.frame = CGRectMake(DEF_SCREEN_WIDTH - 70, DEF_HEIGHT(view_botyom) - 50, 70, 50);
}

-(void)textViewDidBeginEditing:(UITextView *)textView
{
    if(textView.text.length > 0)
    {
        [btn_send setTitleColor:DEF_RGB_COLOR(82, 188, 248) forState:0];
    }
    else
    {
        [btn_send setTitleColor:DEF_RGB_COLOR(200, 200, 200) forState:0];
    }
    
    self.contentView.scrollEnabled = NO;
    
    CGSize size = [self sizeOfStr:textView.text andFont:[UIFont systemFontOfSize:16] andMaxSize:CGSizeMake(DEF_WIDTH(_textSend) -10, 200000) andLineBreakMode:NSLineBreakByCharWrapping];
    
    if(size.height < 20)
    {
        [UIView animateWithDuration:0.3 animations:^{
            view_botyom.frame = CGRectMake(0, DEF_SCREEN_HEIGHT - [self.contentView keyboardRect].size.height - topHight - 50, DEF_WIDTH(view_botyom), 50);
        }];
        return;
    }
    
    [UIView animateWithDuration:0.3 animations:^{
        view_botyom.frame = CGRectMake(0, DEF_SCREEN_HEIGHT - [self.contentView keyboardRect].size.height - topHight - size.height * 1.1 - 20, DEF_WIDTH(view_botyom), size.height * 1.1 + 20);
    }];
}

-(void)textViewDidEndEditing:(UITextView *)textView
{
//    [textFiledEmail resignFirstResponder];
//    [textFiledTel resignFirstResponder];
//    [textFiledQQ resignFirstResponder];
//    [textFiledOther resignFirstResponder];
//    [self.view endEditing:YES];
    
    if(textView.text.length > 0)
    {
        [btn_send setTitleColor:DEF_RGB_COLOR(82, 188, 248) forState:0];
    }
    else
    {
        [btn_send setTitleColor:DEF_RGB_COLOR(200, 200, 200) forState:0];
    }
    
    self.contentView.scrollEnabled = YES;
    
    CGSize size = [self sizeOfStr:textView.text andFont:[UIFont systemFontOfSize:16] andMaxSize:CGSizeMake(DEF_WIDTH(_textSend) - 10, 200000) andLineBreakMode:NSLineBreakByCharWrapping];
    
    if(size.height < 20)
    {
        [UIView animateWithDuration:0.3 animations:^{
            
            view_botyom.frame = CGRectMake(0, DEF_SCREEN_HEIGHT - [self.contentView keyboardRect].size.height - topHight - 50, DEF_WIDTH(view_botyom), 50);
            
            image_luang.frame = CGRectMake(9, 9, DEF_WIDTH(image_luang), 32);
            _textSend.frame = CGRectMake(1, 1, DEF_WIDTH(_textSend), 30);
            btn_send.frame = CGRectMake(DEF_SCREEN_WIDTH - 70, DEF_HEIGHT(view_botyom) - 50, 70, 50);
        }];
        return;
    }
    
    [UIView animateWithDuration:0.3 animations:^{
        view_botyom.frame = CGRectMake(0, DEF_SCREEN_HEIGHT - [self.contentView keyboardRect].size.height - topHight - size.height * 1.1 - 20, DEF_WIDTH(view_botyom), size.height * 1.1 + 20);
    }];
}

-(void)send
{
    
}

-(void)keyboardShow
{
    [self addBackgroundViewWithView];
    [_textSend resignFirstResponder];
    [textf becomeFirstResponder];
    [textFiledQQ becomeFirstResponder];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"I"];
    
    return cell;
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

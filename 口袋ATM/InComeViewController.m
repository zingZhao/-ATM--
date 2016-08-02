//
//  InComeViewController.m
//  口袋ATM
//
//  Created by 赵奎博 on 16/3/22.
//  Copyright © 2016年 赵奎博. All rights reserved.
//

#import "InComeViewController.h"
#define title_c [UIColor colorWithRed:100/255.00 green:100/255.00 blue:100/255.00 alpha:1]
@interface InComeViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UILabel * label1;
    UILabel * label2;
    UILabel * label3;
    UILabel * label4;
    
    UITableView * _tableView;
    BOOL is;
    
    NSMutableAttributedString * att44;
    NSMutableAttributedString * att_11;
    NSMutableAttributedString * att_22;
    NSMutableAttributedString * att_33;
}
@end

@implementation InComeViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self addNavgationTitle:@"收支明细"];
    [self addNavgationLeftButton:@"toolbar_arrow"];
    
    [self initUI];
    
    [self setupRefresh];
}

-(void)initUI
{
    self.contentView.frame = CGRectMake(0, topHight, DEF_SCREEN_WIDTH, DEF_SCREEN_HEIGHT - topHight);
    self.contentView.backgroundColor = DEF_RGB_COLOR(245, 245, 249);

//顶部
    UIView * view_top = [[UIView alloc]initWithFrame:CGRectMake(0, 0, DEF_SCREEN_WIDTH, 60)];
    view_top.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:view_top];
    
    label1 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, DEF_SCREEN_WIDTH / 4, 60)];
    label1.userInteractionEnabled = YES;
    [self Eleven_Set_label:label1 text:@"全部收入\n1.0" textColor:[UIColor blackColor] fontSize:15 fontAlpha:1 textAlignment:3];
    label1.tag = 0;
    [view_top addSubview:label1];
    
    att_11 = [[NSMutableAttributedString alloc]initWithString:label1.text];
    NSRange range = [label1.text rangeOfString:@"1.0"];
    [att_11 setAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12],NSForegroundColorAttributeName:title_c} range:range];
    label1.attributedText = att_11;
    
    UITapGestureRecognizer * tap1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
    [label1 addGestureRecognizer:tap1];
    
    NSRange range2 = [label1.text rangeOfString:@"全部收入"];
    [att_11 setAttributes:@{NSForegroundColorAttributeName:DEF_RGB_COLOR(251, 17, 63)} range:range2];
    label1.attributedText = att_11;
    
    label2 = [[UILabel alloc]initWithFrame:CGRectMake(DEF_SCREEN_WIDTH / 4, 0, DEF_SCREEN_WIDTH / 4, 60)];
    [self Eleven_Set_label:label2 text:@"任务收入\n0.0" textColor:[UIColor blackColor] fontSize:15 fontAlpha:1 textAlignment:3];
    label2.tag = 1;
    label2.userInteractionEnabled = YES;
    [view_top addSubview:label2];
    
    att_22 = [[NSMutableAttributedString alloc]initWithString:label2.text];
    NSRange range11 = [label2.text rangeOfString:@"0.0"];
    [att_22 setAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12],NSForegroundColorAttributeName:title_c} range:range11];
    label2.attributedText = att_22;
    
    UITapGestureRecognizer * tap2 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
    [label2 addGestureRecognizer:tap2];
    
    label3 = [[UILabel alloc]initWithFrame:CGRectMake(DEF_SCREEN_WIDTH / 2, 0, DEF_SCREEN_WIDTH / 4, 60)];
    [self Eleven_Set_label:label3 text:@"徒弟提成\n0.0" textColor:[UIColor blackColor] fontSize:15 fontAlpha:1 textAlignment:3];
    label3.tag = 2;
    label3.userInteractionEnabled = YES;
    [view_top addSubview:label3];
    
    att_33 = [[NSMutableAttributedString alloc]initWithString:label3.text];
    NSRange range22 = [label3.text rangeOfString:@"0.0"];
    [att_33 setAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12],NSForegroundColorAttributeName:title_c} range:range22];
    label3.attributedText = att_33;
    
    UITapGestureRecognizer * tap3 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
    [label3 addGestureRecognizer:tap3];
    
    label4 = [[UILabel alloc]initWithFrame:CGRectMake(DEF_SCREEN_WIDTH / 4 * 3, 0, DEF_SCREEN_WIDTH / 4, 60)];
    label4.userInteractionEnabled = YES;
    [self Eleven_Set_label:label4 text:@"成功兑换\n0.0" textColor:[UIColor blackColor] fontSize:15 fontAlpha:1 textAlignment:3];
    label4.tag = 3;
    [view_top addSubview:label4];
    att44 = [[NSMutableAttributedString alloc]initWithString:label4.text];
    NSRange range44 = [label4.text rangeOfString:@"0.0"];
    [att44 setAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12],NSForegroundColorAttributeName:DEF_RGB_COLOR(120, 120, 120)} range:range44];
    label4.attributedText = att44;
    
    UITapGestureRecognizer * tap4 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
    [label4 addGestureRecognizer:tap4];
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, topHight + 65, DEF_SCREEN_WIDTH, DEF_SCREEN_HEIGHT - topHight - 60)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = DEF_RGB_COLOR(245, 245, 249);
    _tableView.tableFooterView = [[UIView alloc]init];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(is)
    {
        return _tableView.frame.size.height;
    }
    else
    {
        return 60;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"123"];
    cell.backgroundColor = [UIColor whiteColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if(is)
    {
        UILabel * label_ui = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, DEF_SCREEN_WIDTH, DEF_SCREEN_WIDTH - topHight - 60)];
        label_ui.text = @"暂无记录!下拉刷新试试";
        label_ui.textAlignment = NSTextAlignmentCenter;
        label_ui.font = [UIFont systemFontOfSize:15];
        label_ui.textColor = DEF_RGB_COLOR(100, 100, 100);
        [cell addSubview:label_ui];
        cell.backgroundColor = DEF_RGB_COLOR(245, 245, 249);
        return cell;
    }
    
    
    UILabel * label_one = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 40, 60)];
    [self Eleven_Set_label:label_one text:@"周三\n3-16" textColor:title_c fontSize:16 fontAlpha:1 textAlignment:3];
    [cell addSubview:label_one];
    
    NSMutableAttributedString * att = [[NSMutableAttributedString alloc]initWithString:label_one.text];
    NSRange range = [label_one.text rangeOfString:@"3-16"];
    [att setAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} range:range];
    label_one.attributedText = att;
    
    UIImageView * image = [[UIImageView alloc]initWithFrame:CGRectMake(DEF_RIGHT(label_one) + 5, 5, 50, 50)];
    image.image = [UIImage imageNamed:@"main_kuaisu"];
    [cell addSubview:image];
    
    UILabel * label_two = [[UILabel alloc]initWithFrame:CGRectMake(DEF_RIGHT(image) + 10, 10, DEF_SCREEN_WIDTH - DEF_RIGHT(image) - 20, 20)];
    [self Eleven_Set_label:label_two text:@"+1.000" textColor:[UIColor blackColor] fontSize:14 fontAlpha:1 textAlignment:1];
    [cell addSubview:label_two];
    
    UILabel * label_three = [[UILabel alloc]initWithFrame:CGRectMake(DEF_RIGHT(image) + 10, 30, DEF_SCREEN_WIDTH - DEF_RIGHT(image) - 20, 20)];
    [self Eleven_Set_label:label_three text:@"用户注册微信绑定" textColor:title_c fontSize:14 fontAlpha:1 textAlignment:1];
    [cell addSubview:label_three];
    
    return cell;
}

-(void)tapAction:(UITapGestureRecognizer *)tap
{
    switch (tap.view.tag) {
        case 0:
        {
            NSRange range1 = [label4.text rangeOfString:@"成功兑换"];
            [att44 setAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor]} range:range1];
            label4.attributedText = att44;
            NSRange range2= [label2.text rangeOfString:@"任务收入"];
            [att_22 setAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor]} range:range2];
            label2.attributedText = att_22;
            NSRange range3= [label3.text rangeOfString:@"徒弟提成"];
            [att_33 setAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor]} range:range3];
            label3.attributedText = att_33;
            
            NSRange range = [label1.text rangeOfString:@"全部收入"];
            [att_11 setAttributes:@{NSForegroundColorAttributeName:DEF_RGB_COLOR(251, 17, 63)} range:range];
            label1.attributedText = att_11;
            
            if(is == YES)
            {
                is = NO;
                [_tableView reloadData];
            }
        }
            break;
        case 1:
        {
            NSRange range1 = [label4.text rangeOfString:@"成功兑换"];
            [att44 setAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor]} range:range1];
            label4.attributedText = att44;
            NSRange range2= [label1.text rangeOfString:@"全部收入"];
            [att_11 setAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor]} range:range2];
            label1.attributedText = att_11;
            NSRange range3= [label3.text rangeOfString:@"徒弟提成"];
            [att_33 setAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor]} range:range3];
            label3.attributedText = att_33;
            
            NSRange range = [label2.text rangeOfString:@"任务收入"];
            [att_22 setAttributes:@{NSForegroundColorAttributeName:DEF_RGB_COLOR(251, 17, 63)} range:range];
            label2.attributedText = att_22;
            
            if(is == YES)
            {
                is = NO;
                [_tableView reloadData];
            }
        }
            break;
        case 2:
        {
            NSRange range1 = [label4.text rangeOfString:@"成功兑换"];
            [att44 setAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor]} range:range1];
            label4.attributedText = att44;
            NSRange range2= [label1.text rangeOfString:@"全部收入"];
            [att_11 setAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor]} range:range2];
            label1.attributedText = att_11;
            NSRange range3= [label2.text rangeOfString:@"任务收入"];
            [att_22 setAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor]} range:range3];
            label2.attributedText = att_22;
            
            NSRange range = [label3.text rangeOfString:@"徒弟提成"];
            [att_33 setAttributes:@{NSForegroundColorAttributeName:DEF_RGB_COLOR(251, 17, 63)} range:range];
            label3.attributedText = att_33;
            
            if(is == YES)
            {
                is = NO;
                [_tableView reloadData];
            }
        }
            break;
        
        case 3:
        {
            NSRange range1= [label1.text rangeOfString:@"全部收入"];
            [att_11 setAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor]} range:range1];
            label1.attributedText = att_11;
            
            NSRange range2= [label2.text rangeOfString:@"任务收入"];
            [att_22 setAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor]} range:range2];
            label2.attributedText = att_22;
            
            NSRange range3= [label3.text rangeOfString:@"徒弟提成"];
            [att_33 setAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor]} range:range3];
            label3.attributedText = att_33;
            
            NSRange range = [label4.text rangeOfString:@"成功兑换"];
            [att44 setAttributes:@{NSForegroundColorAttributeName:DEF_RGB_COLOR(251, 17, 63)} range:range];
            label4.attributedText = att44;
            
            if(is == NO)
            {
                is = YES;
                [_tableView reloadData];
            }
        }
            break;
            
        default:
            break;
    }
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

#pragma mark --  设置刷新
- (void)setupRefresh
{
    // 1.下拉刷新(进入刷新状态就会调用self的headerRereshing)
    [_tableView addHeaderWithTarget:self action:@selector(headerRereshing)];
    // 2.上拉加载更多(进入刷新状态就会调用self的footerRereshing)
    [_tableView addFooterWithTarget:self action:@selector(footerRereshing)];
    [_tableView footerEndRefreshing];
    
    // 设置文字(也可以不设置,默认的文字在MJRefreshConst中修改)
    _tableView.headerPullToRefreshText = @"下拉刷新";
    _tableView.headerReleaseToRefreshText = @"松开刷新";
    _tableView.headerRefreshingText = @"正在刷新";
    
    _tableView.footerPullToRefreshText = @"上拉加载";
    _tableView.footerReleaseToRefreshText = @"松开加载更多数据";
    _tableView.footerRefreshingText = @"正在加载";
}

-(void)headerRereshing
{
    //[self removebtnall];
    
    //[self end_search];
    dispatch_async(dispatch_get_main_queue(), ^{
        
        sleep(1);
        [_tableView headerEndRefreshing];
        
    });
    
    //sleep(1);
    
}

-(void)footerRereshing
{
    //[self removebtnall];
    
    //sleep(1);
    dispatch_async(dispatch_get_main_queue(), ^{
        
        sleep(1);
        [_tableView footerEndRefreshing];
    });
    
}

@end

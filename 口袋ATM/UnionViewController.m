//
//  UnionViewController.m
//  口袋ATM
//
//  Created by 赵奎博 on 16/3/22.
//  Copyright © 2016年 赵奎博. All rights reserved.
//

#import "UnionViewController.h"

@interface UnionViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView * _tableView;
    
    UIView * view_back;
    
    UIView * view_user;
}

@end

@implementation UnionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addNavgationTitle:@"联盟任务"];
    [self addNavgationLeftButton:@"toolbar_arrow"];
    
    [self initUI];
    
    [self setupRefresh];
}

-(void)initUI
{
    self.contentView.frame = CGRectMake(0, topHight, DEF_SCREEN_WIDTH, DEF_SCREEN_HEIGHT - topHight);
    self.contentView.backgroundColor = DEF_RGB_COLOR(245, 245, 249);
    self.view.backgroundColor = DEF_RGB_COLOR(245, 245, 249);
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, topHight, DEF_SCREEN_WIDTH, DEF_SCREEN_HEIGHT - topHight)];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.tableFooterView = [[UIView alloc]init];
    _tableView.backgroundColor = DEF_RGB_COLOR(245, 245, 249);
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    //_tableView.backgroundColor = DEF_RGB_COLOR(230, 245, 249);
    [self.view addSubview:_tableView];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"p"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = DEF_RGB_COLOR(245, 245, 249);
    
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(10,20, DEF_SCREEN_WIDTH - 20, 60)];
    view.backgroundColor = [UIColor whiteColor];
    view.layer.masksToBounds = YES;
    view.layer.cornerRadius = 10.0;
    [cell addSubview:view];
    
    UIImageView * image = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 40, 40)];
    image.image = [UIImage imageNamed:@"icon_more"];
    [view addSubview:image];
    
    UILabel * label_text = [[UILabel alloc]initWithFrame:CGRectMake(DEF_RIGHT(image) + 20, 20, DEF_WIDTH(view) - 90, 20)];
    [self Eleven_Set_label:label_text text:@"更多任务请下载企业版" textColor:[UIColor blackColor] fontSize:16 fontAlpha:1 textAlignment:1];
    [view addSubview:label_text];
    
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark --- 点击效果
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self didSelect];
}

-(void)didSelect
{
    view_back = [[UIView alloc]initWithFrame:CGRectMake(0, 0, DEF_SCREEN_WIDTH, DEF_SCREEN_HEIGHT )];
    view_back.backgroundColor = DEF_RGBA_COLOR(0, 0, 0, 0.4);
    [self.view addSubview:view_back];
    
    //    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(removeViewBack)];
    //    [view_back addGestureRecognizer:tap];
    
    view_user = [[UIView alloc]initWithFrame:CGRectMake(50,  - 400, DEF_SCREEN_WIDTH - 100, 140)];
    view_user.backgroundColor = [UIColor whiteColor];
    view_user.layer.masksToBounds = YES;
    view_user.layer.cornerRadius = 10.0;
    [view_back addSubview:view_user];
    
    
    
    
    UILabel * label_1 = [[UILabel alloc]initWithFrame:CGRectMake(0, 20, DEF_WIDTH(view_user), 20)];
    [self Eleven_Set_label:label_1 text:@"提示" textColor:[UIColor blackColor] fontSize:18 fontAlpha:1 textAlignment:3];
    [view_user addSubview:label_1];
    
    UILabel * label_2 = [[UILabel alloc]initWithFrame:CGRectMake(0, DEF_BOTTOM(label_1) + 10, DEF_WIDTH(view_user), 40)];
    [self Eleven_Set_label:label_2 text:@"联盟任务请下载企业版本!" textColor:[UIColor blackColor] fontSize:14 fontAlpha:1 textAlignment:3];
    label_2.numberOfLines = 0;
    [view_user addSubview:label_2];

    
    UILabel * label_line = [[UILabel alloc]initWithFrame:CGRectMake(0, DEF_BOTTOM(label_2) + 10, DEF_WIDTH(view_user), 1)];
    label_line.backgroundColor = DEF_RGB_COLOR(235, 235, 235);
    [view_user addSubview:label_line];
    
    UIButton * btn_begin = [UIButton buttonWithType:0];
    btn_begin.frame = CGRectMake(20, DEF_BOTTOM(label_line) , DEF_WIDTH(view_user) - 40, 35);
    [self Eleven_Set_Button:btn_begin setBackgroundColor:[UIColor clearColor] setBackgroundImageNormal:nil setBackgroundImageHighlighted:nil setTitle:@"立即前往" setTitleFont:14 buttonTag:1 titleColor:DEF_RGB_COLOR(231, 77, 79)];
    [btn_begin addTarget:self action:@selector(removeViewBack) forControlEvents:UIControlEventTouchUpInside];
    [view_user addSubview:btn_begin];
    
    [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionTransitionFlipFromBottom animations:^{
        
        view_user.frame = CGRectMake(50, DEF_SCREEN_HEIGHT / 2 - 100, DEF_SCREEN_WIDTH - 100, 140);
    } completion:^(BOOL finished) {
        
    }];
}

-(void)removeViewBack
{
    [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        
        view_user.frame = CGRectMake(50,DEF_SCREEN_HEIGHT + DEF_SCREEN_HEIGHT / 2 - 100, DEF_SCREEN_WIDTH - 100, 180);
    } completion:^(BOOL finished) {
        
        [view_back removeFromSuperview];
        view_back = nil;
        
    }];
    
    
}

#pragma mark --  设置刷新
- (void)setupRefresh
{
    // 1.下拉刷新(进入刷新状态就会调用self的headerRereshing)
    [_tableView addHeaderWithTarget:self action:@selector(headerRereshing)];
    
    // 设置文字(也可以不设置,默认的文字在MJRefreshConst中修改)
    _tableView.headerPullToRefreshText = @"下拉刷新";
    _tableView.headerReleaseToRefreshText = @"松开刷新";
    _tableView.headerRefreshingText = @"正在刷新";
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

@end

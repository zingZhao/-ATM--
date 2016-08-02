//
//  MyTudiViewController.m
//  口袋ATM
//
//  Created by 赵奎博 on 16/3/22.
//  Copyright © 2016年 赵奎博. All rights reserved.
//

#import "MyTudiViewController.h"

@interface MyTudiViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView * _tableView;
}

@end

@implementation MyTudiViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self addNavgationTitle:@"我的徒弟"];
    [self addNavgationLeftButton:@"toolbar_arrow"];
    
    [self addnavgation];
    
    [self initUI];
    
    [self setupRefresh];
}

-(void)addnavgation
{
    UIImageView * image_us = [[UIImageView alloc]initWithFrame:CGRectMake(DEF_SCREEN_WIDTH - 60, 30, 20, 20)];
    image_us.image = [UIImage imageNamed:@"disciple_count"];
    [downimage addSubview:image_us];
    
    UILabel * label_zero = [[UILabel alloc]initWithFrame:CGRectMake(DEF_SCREEN_WIDTH - 25, 30, 20, 20)];
    [self Eleven_Set_label:label_zero text:@"0" textColor:[UIColor whiteColor] fontSize:14 fontAlpha:1 textAlignment:1];
    label_zero.font = [UIFont boldSystemFontOfSize:16];
    [downimage addSubview:label_zero];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initUI
{
    self.contentView.frame = CGRectMake(0, topHight, DEF_SCREEN_WIDTH, DEF_SCREEN_HEIGHT - topHight);
    self.contentView.backgroundColor = DEF_RGB_COLOR(245, 245, 249);
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, topHight, DEF_SCREEN_WIDTH, DEF_SCREEN_HEIGHT - topHight)];
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
   return _tableView.frame.size.height;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"123"];
    cell.backgroundColor = [UIColor whiteColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    UILabel * label_ui = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, DEF_SCREEN_WIDTH, DEF_SCREEN_WIDTH - topHight - 60)];
    label_ui.text = @"暂无记录!下拉刷新试试";
    label_ui.textAlignment = NSTextAlignmentCenter;
    label_ui.font = [UIFont systemFontOfSize:15];
    label_ui.textColor = DEF_RGB_COLOR(100, 100, 100);
    [cell addSubview:label_ui];
    cell.backgroundColor = DEF_RGB_COLOR(245, 245, 249);
    return cell;
}

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

@end

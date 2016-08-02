//
//  ShareViewController.m
//  口袋ATM
//
//  Created by 赵奎博 on 16/3/22.
//  Copyright © 2016年 赵奎博. All rights reserved.
//

#import "ShareViewController.h"
#import "ShareDetailViewController.h"
@interface ShareViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView * _tableView;
}

@end

@implementation ShareViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addNavgationTitle:@"分享收徒"];
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
    return 100;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"p"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = DEF_RGB_COLOR(245, 245, 249);
    
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(10,20, DEF_SCREEN_WIDTH - 20, 80)];
    view.backgroundColor = [UIColor whiteColor];
    view.layer.masksToBounds = YES;
    view.layer.cornerRadius = 10.0;
    [cell addSubview:view];
    
    UIImageView * image = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 60, 60)];
    image.image = [UIImage imageNamed:@"icon_meiri"];
    [view addSubview:image];
    
    UILabel * label_text = [[UILabel alloc]initWithFrame:CGRectMake(DEF_RIGHT(image) + 5, 18, DEF_WIDTH(view) - 90, 20)];
    [self Eleven_Set_label:label_text text:@"分享收徒" textColor:[UIColor blackColor] fontSize:16 fontAlpha:1 textAlignment:1];
    [view addSubview:label_text];
    
    UILabel * label_text_2 = [[UILabel alloc]initWithFrame:CGRectMake(DEF_RIGHT(image) + 5, 45, DEF_WIDTH(view) - 90, 20)];
    [self Eleven_Set_label:label_text_2 text:@"分享领奖励,徒弟越多惊喜越多" textColor:[UIColor grayColor] fontSize:14 fontAlpha:1 textAlignment:1];
    [view addSubview:label_text_2];
    
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark --- 点击效果
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    ShareDetailViewController * svc = [[ShareDetailViewController alloc]init];
    [self.navigationController pushViewController:svc animated:YES];
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

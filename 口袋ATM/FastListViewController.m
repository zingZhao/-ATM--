//
//  FastListViewController.m
//  口袋ATM
//
//  Created by 赵奎博 on 16/3/17.
//  Copyright © 2016年 赵奎博. All rights reserved.
//

#import "FastListViewController.h"
#import "abTableViewCell.h"
@interface FastListViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView * _tableView;
    
    UIView * view_back;
    
    UIScrollView * view_user;
}
@end

@implementation FastListViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self addNavgationTitle:@"免费获取元"];
    [self addNavgationLeftButton:@"videoback"];
    [self addNavgationRightButton:@"re"];

    [self initUI];
    
    [self setupRefresh];
}

-(void)rightAction
{
    [_tableView headerBeginRefreshing];
    
    [self headerRereshing];
}

-(void)initUI
{
    self.contentView.frame = CGRectMake(0, topHight, DEF_SCREEN_WIDTH, DEF_SCREEN_HEIGHT - topHight);
    self.view.backgroundColor = DEF_RGB_COLOR(245, 245, 249);
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, topHight, DEF_SCREEN_WIDTH, DEF_SCREEN_HEIGHT - topHight)];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    //_tableView.backgroundColor = DEF_RGB_COLOR(230, 245, 249);
    [self.view addSubview:_tableView];
    
    UIView * view_foot = [[UIView alloc]initWithFrame:CGRectMake(0, 0, DEF_SCREEN_WIDTH, 40)];
    view_foot.backgroundColor = DEF_RGB_COLOR(255, 255, 255);
    _tableView.tableFooterView = view_foot;
    
    UILabel * label_help = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, 100, 40)];
    [self Eleven_Set_label:label_help text:@"帮助中心" textColor:DEF_RGB_COLOR(180, 180, 180) fontSize:14 fontAlpha:1 textAlignment:1];
    [view_foot addSubview:label_help];
    
    UIImageView * image_right = [[UIImageView alloc]initWithFrame:CGRectMake(DEF_SCREEN_WIDTH - 130, 5, 120, 30)];
    image_right.image = [UIImage imageNamed:@"souying"];
    [view_foot addSubview:image_right];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    abTableViewCell * tabl = [tableView dequeueReusableCellWithIdentifier:@"ID"];
    if(tabl == nil)
    {
        tabl = [[abTableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"ID"];
    }
    tabl.selectionStyle = UITableViewCellSelectionStyleNone;

    tabl.layer.transform = CATransform3DMakeScale(0.1, 1, 1);
    
    //设置动画时间为0.25秒,xy方向缩放的最终值为1
    [UIView animateWithDuration:0.5 animations:^{
        tabl.layer.transform = CATransform3DMakeScale(1, 1, 1);
    }];
    
    
    return tabl;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 35;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    NSArray * array_title = @[@"    限时任务",@"    经典任务"];
    UILabel * view = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, DEF_SCREEN_WIDTH, 36)];
    view.text = array_title[section];
    view.textColor = [UIColor redColor];
    view.font = [UIFont systemFontOfSize:16];
    view.backgroundColor = DEF_RGB_COLOR(245, 245, 249);
    return view;
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
    CGSize size_des = [self sizeOfStr:@"1、非首次下载将无法获得奖励;\n2、长按虚线，拷贝关键词；\n3、点击“开始任务”，粘贴并搜索；\n4、找到“口袋ATM_任务通知专用（注册并5星好评返奖励）”(1位左右)下载注册试玩1分钟；\n5、试玩时间达到要求后自动提交" andFont:[UIFont systemFontOfSize:13] andMaxSize:CGSizeMake(DEF_SCREEN_WIDTH - 100, 20000) andLineBreakMode:NSLineBreakByCharWrapping];

    
    view_back = [[UIView alloc]initWithFrame:CGRectMake(0, 0, DEF_SCREEN_WIDTH, DEF_SCREEN_HEIGHT )];
    view_back.backgroundColor = DEF_RGBA_COLOR(0, 0, 0, 0.0);
    [self.view addSubview:view_back];
    
//    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(removeViewBack)];
//    [view_back addGestureRecognizer:tap];
    
    CGFloat user_hie = size_des.height + 350;
    
    
    view_user = [[UIScrollView alloc]initWithFrame:CGRectMake(30, (DEF_SCREEN_HEIGHT - user_hie) / 2 + DEF_SCREEN_HEIGHT, DEF_SCREEN_WIDTH - 60, user_hie)];
    view_user.backgroundColor = [UIColor whiteColor];
    view_user.layer.masksToBounds = YES;
    view_user.layer.cornerRadius = 10.0;
    view_user.showsVerticalScrollIndicator = NO;
    [view_back addSubview:view_user];
    
    UIButton * btn_cha = [UIButton buttonWithType:0];
    btn_cha.frame = CGRectMake(DEF_WIDTH(view_user) - 30, 0, 30, 30);
    [btn_cha setImage:[UIImage imageNamed:@"ty_btn_close"] forState:0];
    [view_user addSubview:btn_cha];
    [btn_cha addTarget:self action:@selector(removeViewBack) forControlEvents:UIControlEventTouchUpInside];
    
    UIImageView * image_use = [[UIImageView alloc]initWithFrame:CGRectMake(20, 20, 50, 50)];
    image_use.image = [UIImage imageNamed:@"fang.png"];
    [view_user addSubview:image_use];
    
    UILabel * label_1 = [[UILabel alloc]initWithFrame:CGRectMake(DEF_RIGHT(image_use) + 20, 20, DEF_WIDTH(view_user) - 30 - DEF_RIGHT(image_use), 20)];
    [self Eleven_Set_label:label_1 text:@"口袋ATM" textColor:[UIColor blackColor] fontSize:16 fontAlpha:1 textAlignment:1];
    [view_user addSubview:label_1];
    
    UILabel * label_2 = [[UILabel alloc]initWithFrame:CGRectMake(DEF_RIGHT(image_use) + 20, DEF_BOTTOM(label_1), DEF_WIDTH(view_user) - 30 - DEF_RIGHT(image_use), 40)];
    [self Eleven_Set_label:label_2 text:@"搜索\"口袋ATM\"首次下载获取奖励" textColor:DEF_RGB_COLOR(231, 77, 79) fontSize:12 fontAlpha:1 textAlignment:1];
    label_2.numberOfLines = 0;
    [view_user addSubview:label_2];
    
    UILabel * label_3 = [[UILabel alloc]initWithFrame:CGRectMake(20, DEF_BOTTOM(image_use) + 5, DEF_WIDTH(view_user) - 20, 40)];
    [self Eleven_Set_label:label_3 text:@"下线时间：2016-03-31 23：59：00" textColor:DEF_RGB_COLOR(150, 150, 150) fontSize:13 fontAlpha:1 textAlignment:3];
    [view_user addSubview:label_3];
    
    UIImageView * image_name = [[UIImageView alloc]initWithFrame:CGRectMake(DEF_WIDTH(view_user) / 2 - 70, DEF_BOTTOM(label_3), 140, 35)];
    [self imageWithSize:image_name borderColor:[UIColor blackColor] lineWidth:1.0 lineLenth:5 lineSpace:3];
    image_name.userInteractionEnabled = YES;
    [view_user addSubview:image_name];
    
    UILongPressGestureRecognizer * longpress = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPress:)];
    [image_name addGestureRecognizer:longpress];
    
    
    UILabel * label_name = [[UILabel alloc]initWithFrame:image_name.bounds];
    [self Eleven_Set_label:label_name text:@"口袋ATM" textColor:[UIColor blackColor] fontSize:14 fontAlpha:1 textAlignment:3];
    label_name.userInteractionEnabled = YES;
    [image_name addSubview:label_name];
    
    UILabel * label_hint = [[UILabel alloc]initWithFrame:CGRectMake(0, DEF_BOTTOM(image_name), DEF_WIDTH(view_user), 30)];
    [self Eleven_Set_label:label_hint text:@"长按虚线框,复制关键词" textColor:DEF_RGB_COLOR(150, 150, 150) fontSize:13 fontAlpha:1 textAlignment:3];
    [view_user addSubview:label_hint];
    
    UILabel * label_des = [[UILabel alloc]initWithFrame:CGRectMake(20, DEF_BOTTOM(label_hint) - 10, DEF_WIDTH(view_user) - 40, size_des.height + 20)];
    [self Eleven_Set_label:label_des text:@"1、非首次下载将无法获得奖励;\n2、长按虚线，拷贝关键词；\n3、点击“开始任务”，粘贴并搜索；\n4、找到“口袋ATM_任务通知专用（注册并5星好评返奖励）”(1位左右)下载注册试玩1分钟；\n5、试玩时间达到要求后自动提交" textColor:[UIColor blackColor] fontSize:13 fontAlpha:1 textAlignment:1];
    [view_user addSubview:label_des];
    
    UIButton * btn_begin = [UIButton buttonWithType:0];
    btn_begin.frame = CGRectMake(20, DEF_BOTTOM(label_des) + 10 , DEF_WIDTH(view_user) - 40, 35);
    [self Eleven_Set_Button:btn_begin setBackgroundColor:DEF_RGB_COLOR(231, 77, 79) setBackgroundImageNormal:nil setBackgroundImageHighlighted:nil setTitle:@"开始任务" setTitleFont:14 buttonTag:1 titleColor:[UIColor whiteColor]];
    [btn_begin addTarget:self action:@selector(removeViewBack) forControlEvents:UIControlEventTouchUpInside];
    [view_user addSubview:btn_begin];
    
    UIButton * btn_begin_2 = [UIButton buttonWithType:0];
    btn_begin_2.frame = CGRectMake(20, DEF_BOTTOM(btn_begin) + 10 , DEF_WIDTH(view_user) - 40, 35);
    [self Eleven_Set_Button:btn_begin_2 setBackgroundColor:DEF_RGB_COLOR(231, 77, 79) setBackgroundImageNormal:nil setBackgroundImageHighlighted:nil setTitle:@"完成后将自动提交" setTitleFont:14 buttonTag:1 titleColor:[UIColor whiteColor]];
    [btn_begin_2 addTarget:self action:@selector(removeViewBack) forControlEvents:UIControlEventTouchUpInside];
    [view_user addSubview:btn_begin_2];
    
    UIButton * btn_begin_3 = [UIButton buttonWithType:0];
    btn_begin_3.frame = CGRectMake(20, DEF_BOTTOM(btn_begin_2) + 10 , DEF_WIDTH(view_user) - 40, 35);
    [self Eleven_Set_Button:btn_begin_3 setBackgroundColor:DEF_RGB_COLOR(243, 98, 79) setBackgroundImageNormal:nil setBackgroundImageHighlighted:nil setTitle:@"放弃任务" setTitleFont:14 buttonTag:1 titleColor:[UIColor whiteColor]];
    [btn_begin_3 addTarget:self action:@selector(removeViewBack) forControlEvents:UIControlEventTouchUpInside];
    [view_user addSubview:btn_begin_3];
    
    
    [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionTransitionFlipFromBottom animations:^{
        view_back.backgroundColor = DEF_RGBA_COLOR(0, 0, 0, 0.4);
        view_user.frame = CGRectMake(view_user.frame.origin.x, (DEF_SCREEN_HEIGHT - user_hie) / 2, DEF_WIDTH(view_user), user_hie);
    } completion:^(BOOL finished) {
//        if(user_hie == DEF_SCREEN_HEIGHT - 150)
//        {
//            view_user.contentSize = CGSizeMake(DEF_WIDTH(view_user), size_des.height + 350);
//        }
        
    }];
    
}

-(void)longPress:(UILongPressGestureRecognizer *)longPress
{
    if (longPress.state == UIGestureRecognizerStateBegan) {
        
        NSLog(@"longpress");
        
        UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
        pasteboard.string = @"口袋ATM";
        UIAlertView * la = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"关键词\"口袋ATM\"复制成功!" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [la show];
    }
}

-(void)removeViewBack
{
    [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        
        view_user.frame = CGRectMake(50,DEF_SCREEN_HEIGHT + view_user.frame.origin.y, DEF_SCREEN_WIDTH - 100, view_user.frame.size.height);
        view_back.backgroundColor = DEF_RGBA_COLOR(0, 0, 0, 0.0);
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

-(void)imageWithSize:(UIView *)size borderColor:(UIColor *)color lineWidth:(CGFloat)width lineLenth:(NSInteger)lenth lineSpace:(NSInteger)space {
    
    CAShapeLayer *border = [CAShapeLayer layer];
    
    border.strokeColor = color.CGColor;
    
    border.fillColor = nil;
    
    border.path = [UIBezierPath bezierPathWithRect:size.bounds].CGPath;
    
    border.frame = size.bounds;
    
    border.lineWidth = width;
    
    border.lineCap = @"square";
    
    border.masksToBounds = YES;
    border.cornerRadius = 5.0;
    
    border.lineDashPattern = @[@(lenth), @(space)];
    
    [size.layer addSublayer:border];
}

@end

//
//  BMBaseViewController.m
//  Eleven_frame
//
//  Created by 吕君 on 15/4/2.
//  Copyright (c) 2015年 eleven. All rights reserved.
//

#import "BMBaseViewController.h"
//#import "BannerScrollView.h"
//#import "QRViewController.h"
#import "MJRefresh.h"
//#import "LoginViewController.h"
#import "DataHander.h"
#define kCachePath [NSHomeDirectory() stringByAppendingPathComponent:@"Library/Caches/cache.db"]
@interface BMBaseViewController ()<UIAlertViewDelegate>//<BannerScrollViewDelegate>
{
    UIButton* first_button;//第一个右按钮
    UIButton* sceond_button;//第二个右按钮
    //BannerScrollView* banners;//广告位
   
}
@end

@implementation BMBaseViewController
@synthesize navView;
@synthesize navTitle;
@synthesize leftButton;
@synthesize rightButton;
@synthesize tapGestureRecognizer;
@synthesize rightButtonImageName;
@synthesize navgationImageName;
@synthesize appdele;
@synthesize backgroundView;
//@synthesize ShoppingCartHidden;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    str_data = [[NSMutableString alloc]initWithString:@""];
    
    self.userDefaults = [NSUserDefaults standardUserDefaults];
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    //背景
    image_back = [[UIImageView alloc]initWithFrame:CGRectMake(0,topHight,DEF_SCREEN_WIDTH,DEF_SCREEN_HEIGHT - topHight)];
    image_back.userInteractionEnabled = YES;
    image_back.image = [UIImage imageNamed:@"tab01_bg"];
    [self.view addSubview:image_back];
    
    // 内容视图
    self.contentView = [[BaseScrollView alloc] initWithFrame:CGRectMake(0, topHight, DEF_SCREEN_WIDTH, DEF_SCREEN_HEIGHT - topHight)];
    self.contentView.backgroundColor = [UIColor clearColor];
    self.contentView.showsVerticalScrollIndicator = NO;
    //self.contentView.backgroundColor = [UIColor colorWithRed:235.0/255.0 green:235.0/255.0 blue:235.0/255.0 alpha:1];
    self.contentView.userInteractionEnabled = YES;
    self.contentView.showsHorizontalScrollIndicator = NO;
    self.contentView.showsVerticalScrollIndicator = NO;
    self.contentView.contentSize = CGSizeMake(DEF_SCREEN_WIDTH, DEF_SCREEN_HEIGHT - topHight);
    [self.view addSubview:self.contentView];
    
    [self addNavView:@""];
    
    tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
    tapGestureRecognizer.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tapGestureRecognizer];
}

-(CGFloat)font
{
    if([UIScreen mainScreen].bounds.size.height > 570)
    {
        return 20;
    }
    
    return 18;
    
}

#pragma mark - 给 view 上加一层 实现有些按钮点击后界面上的其他控件不能被点击
- (void)addBackgroundViewWithView{
    appdele = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    backgroundView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, DEF_SCREEN_WIDTH, DEF_SCREEN_HEIGHT)];
    backgroundView.backgroundColor=[UIColor clearColor];
    //backgroundView.alpha=.3;
    [appdele.window addSubview:backgroundView];
}
#pragma mark - 添加 navi 上的
- (void)addNaviAllSubView_NaviView:(NSString*)image_str
                         NaviTitle:(NSString*)title
                    LeftButtonBool:(BOOL)YesOrNo
{
    [self addNavView:image_str];
    [self addNavgationTitle:title];
    if (YesOrNo == YES) {
        [self addNavgationLeftButton];
    }
}
#pragma mark - 软键盘
-(void)keyboardHide:(UITapGestureRecognizer*)tap
{
    [self.view endEditing:YES];
}

#pragma mark - 添加子视图
- (void)addSubview:(UIView *)view
{
    [self.contentView addSubview:view];
}

#pragma mark - 添加自定义导航栏
- (void)addNavView:(NSString *)imageStr
{
    navgationImageName = imageStr;
    navView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, DEF_SCREEN_WIDTH, topHight)];
    navView.userInteractionEnabled = YES;
    //navView.alpha = 0.8;
    //[self chageNavStyle];
    navView.backgroundColor = DEF_RGB_COLOR(251, 17, 63);
    //[navView setBackgroundColor:[self hexStringToColor:@"#415151"]];
    downimage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, navView.frame.size.width, navView.frame.size.height)];
    downimage.image = [UIImage imageNamed:@""];
    downimage.userInteractionEnabled = YES;
    downimage.backgroundColor = [UIColor clearColor];
    [navView addSubview:downimage];
    [self.view addSubview:navView];
}


#pragma mark - 添加左按钮
- (void)addNavgationLeftButton
{
    leftButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 70)];
    [leftButton addTarget:self action:@selector(leftAction) forControlEvents:UIControlEventTouchUpInside];
    [leftButton setBackgroundColor:[UIColor clearColor]];
    
    UIImageView* buttonImageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 25, 30, 30)];
    [buttonImageView setImage:[UIImage imageNamed:@"back"]];
    [downimage addSubview:buttonImageView];
    [downimage addSubview:leftButton];
    
}

-(void)addNavgationLeftButton:(NSString *)image
{
    leftButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 70, 70)];
    [leftButton addTarget:self action:@selector(leftAction) forControlEvents:UIControlEventTouchUpInside];
    [leftButton setBackgroundColor:[UIColor clearColor]];
    
    UIImageView* buttonImageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 15, 50, 50)];
    [buttonImageView setImage:[UIImage imageNamed:image]];
    [downimage addSubview:buttonImageView];
    [downimage addSubview:leftButton];
}
#pragma mark - 左按钮点击事件
- (void)leftAction
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 添加右按钮 按钮显示文字
- (void)addNavgationRightButton_title:(NSString *)str title_Color:(UIColor *)color
{
    rightButton = [[UIButton alloc] initWithFrame:CGRectMake(DEF_SCREEN_WIDTH - 100 - 20, 0 , 100 , 70)];
    [rightButton addTarget:self action:@selector(rightAction) forControlEvents:UIControlEventTouchUpInside];
    [rightButton setBackgroundColor:[UIColor clearColor]];
    
    UILabel * label_right = [[UILabel alloc]initWithFrame:CGRectMake(DEF_SCREEN_WIDTH  - 200, 25, 185, 30)];
    [self Eleven_Set_label:label_right text:str textColor:color fontSize:16 fontAlpha:1 textAlignment:2];
    label_right.font = [UIFont boldSystemFontOfSize:17];
    [downimage addSubview:label_right];
    [downimage addSubview:rightButton];
}

#pragma mark - 添加右按钮 按钮显示图片
- (void)addNavgationRightButton:(NSString *)str
{
    rightButton = [[UIButton alloc] initWithFrame:CGRectMake(DEF_SCREEN_WIDTH - 70, 0 , 70 , 70)];
    [rightButton addTarget:self action:@selector(rightAction) forControlEvents:UIControlEventTouchUpInside];
    [rightButton setBackgroundColor:[UIColor clearColor]];
    
    self.buttonImageView_right = [[UIImageView alloc]initWithFrame:CGRectMake(DEF_SCREEN_WIDTH - 40, 30, 20, 20)];
    [self.buttonImageView_right setImage:[UIImage imageNamed:str]];
    [downimage addSubview:self.buttonImageView_right];
    [downimage addSubview:rightButton];
}
#pragma mark - 添加多个右按钮 按钮显示图片
- (void)addNavgationRightButtons:(NSString*)button_one_str
                  Button_two_str:(NSString*)button_two_str
{
    first_button = [[UIButton alloc]initWithFrame:CGRectMake(DEF_SCREEN_WIDTH - (DEF_SCREEN_WIDTH) / 3, 0, ((DEF_SCREEN_WIDTH) / 3) / 2, DEF_HEIGHT(self.navView))];
    [self Eleven_Set_Button:first_button
         setBackgroundColor:[UIColor clearColor]
   setBackgroundImageNormal:nil
setBackgroundImageHighlighted:nil
                   setTitle:nil
               setTitleFont:0
                  buttonTag:0 titleColor:[UIColor whiteColor]];
    [first_button addTarget:self action:@selector(rightButtons_action:) forControlEvents:UIControlEventTouchUpInside];
    [downimage addSubview:first_button];
    
    UIImageView* first_buttonImageView = [[UIImageView alloc]initWithFrame:CGRectMake(DEF_X(first_button) + (DEF_WIDTH(first_button) - 20) / 2 , 30, 20, 20)];
    [first_buttonImageView setImage:[UIImage imageNamed:button_one_str]];
    [downimage addSubview:first_buttonImageView];
    
    sceond_button = [[UIButton alloc]initWithFrame:CGRectMake(DEF_RIGHT(first_button), 0, ((DEF_SCREEN_WIDTH) / 3) / 2, DEF_HEIGHT(self.navView))];
    [self Eleven_Set_Button:sceond_button
         setBackgroundColor:[UIColor clearColor]
   setBackgroundImageNormal:nil
setBackgroundImageHighlighted:nil
                   setTitle:nil
               setTitleFont:0
                  buttonTag:1 titleColor:[UIColor whiteColor]];
    [sceond_button addTarget:self action:@selector(rightButtons_action:) forControlEvents:UIControlEventTouchUpInside];
    [downimage addSubview:sceond_button];
    
    UIImageView* sceond_buttonImageView = [[UIImageView alloc]initWithFrame:CGRectMake(DEF_X(sceond_button) + (DEF_WIDTH(sceond_button) - 20) / 2, 30, 20, 20)];
    [sceond_buttonImageView setImage:[UIImage imageNamed:button_two_str]];
    [downimage addSubview:sceond_buttonImageView];
}

#pragma mark - 添加右按钮 按钮显示图片和文字
- (void)addNavgationRightButtons:(NSString*)button_one_image
                  Button_one_str:(NSString*)button_one_str Button_oneStr_color:(UIColor *)color
{
    first_button = [[UIButton alloc]initWithFrame:CGRectMake(DEF_SCREEN_WIDTH - 100, 0, 100, DEF_HEIGHT(self.navView))];
    [self Eleven_Set_Button:first_button
         setBackgroundColor:[UIColor clearColor]
   setBackgroundImageNormal:nil
setBackgroundImageHighlighted:nil
                   setTitle:nil
               setTitleFont:0
                  buttonTag:0 titleColor:[UIColor whiteColor]];
    [first_button addTarget:self action:@selector(rightAction) forControlEvents:UIControlEventTouchUpInside];
    [downimage addSubview:first_button];
    
    UIImageView* first_buttonImageView = [[UIImageView alloc]initWithFrame:CGRectMake(DEF_X(first_button), 30, 20, 20)];
    [first_buttonImageView setImage:[UIImage imageNamed:button_one_image]];
    [downimage addSubview:first_buttonImageView];
    
    UILabel * label_str = [[UILabel alloc]initWithFrame:CGRectMake(DEF_RIGHT(first_buttonImageView), 30, 80, 20)];
    [self Eleven_Set_label:label_str text:button_one_str textColor:color fontSize:16 fontAlpha:1 textAlignment:1];
    [downimage addSubview:label_str];
    
//    sceond_button = [[UIButton alloc]initWithFrame:CGRectMake(DEF_RIGHT(first_button), 0, ((DEF_SCREEN_WIDTH) / 3) / 2, DEF_HEIGHT(self.navView))];
//    [self Eleven_Set_Button:sceond_button
//         setBackgroundColor:[UIColor clearColor]
//   setBackgroundImageNormal:nil
//setBackgroundImageHighlighted:nil
//                   setTitle:nil
//               setTitleFont:0
//                  buttonTag:1 titleColor:[UIColor whiteColor]];
//    [sceond_button addTarget:self action:@selector(rightButtons_action:) forControlEvents:UIControlEventTouchUpInside];
//    [downimage addSubview:sceond_button];
//    
//    UIImageView* sceond_buttonImageView = [[UIImageView alloc]initWithFrame:CGRectMake(DEF_X(sceond_button) + (DEF_WIDTH(sceond_button) - 20) / 2, 30, 20, 20)];
//    [sceond_buttonImageView setImage:[UIImage imageNamed:button_two_str]];
//    [downimage addSubview:sceond_buttonImageView];
}

#pragma mark - 多个右按钮的点击事件
- (void)rightButtons_action:(UIButton*)button
{
    if (button.tag == 0) {
        [self showHUDWithString:@"右按钮1"];
    }else{
        [self showHUDWithString:@"右按钮2"];
    }
}
#pragma mark - 右按钮方法 单个按钮
- (void)rightAction
{
    
}
#pragma mark - 导航栏标题
- (void)addNavgationTitle:(NSString *)title
{
    self.titleLB = [[UILabel alloc] initWithFrame:CGRectMake(DEF_SCREEN_WIDTH/2-160/2, 25, 160, 30)];
    self.titleLB.textAlignment = NSTextAlignmentCenter;
    self.titleLB.textColor = [UIColor whiteColor];
    self.titleLB.font = [UIFont boldSystemFontOfSize:18.0];
    self.titleLB.text = title;
    [downimage addSubview:self.titleLB];
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

#pragma mark - 创建 textField
- (void)Eleven_Set_TextField:(UITextField*)textField
             placeholderText:(NSString*)text
                   text_font:(NSInteger)font
{
    textField.borderStyle=UITextBorderStyleNone;
    textField.backgroundColor=[UIColor whiteColor];
    textField.returnKeyType =UIReturnKeyDone;
    textField.font = [UIFont systemFontOfSize:font];
    textField.placeholder = text;
    //textField.clearButtonMode = UITextFieldViewModeWhileEditing;
}



#pragma mark 刷新
- (void)setupRefresh
{
    // 1.下拉刷新(进入刷新状态就会调用self的headerRereshing)
    [self.tableView addHeaderWithTarget:self action:@selector(headerRereshing)];
    // 2.上拉加载更多(进入刷新状态就会调用self的footerRereshing)
    [self.tableView addFooterWithTarget:self action:@selector(footerRereshing)];
    [self.tableView footerEndRefreshing];
    
    // 设置文字(也可以不设置,默认的文字在MJRefreshConst中修改)
    self.tableView.headerPullToRefreshText = @"下拉刷新";
    self.tableView.headerReleaseToRefreshText = @"松开刷新";
    self.tableView.headerRefreshingText = @"正在刷新";
    
    self.tableView.footerPullToRefreshText = @"上拉加载";
    self.tableView.footerReleaseToRefreshText = @"松开加载更多数据";
    self.tableView.footerRefreshingText = @"正在加载";
}

- (void)setupHaderRefresh
{
    // 1.下拉刷新(进入刷新状态就会调用self的headerRereshing)
    [self.tableView addHeaderWithTarget:self action:@selector(headerRereshing)];
    // [self.tableView1 headerBeginRefreshing];
    
    // 设置文字(也可以不设置,默认的文字在MJRefreshConst中修改)
    self.tableView.headerPullToRefreshText = @"下拉刷新";
    self.tableView.headerReleaseToRefreshText = @"松开刷新";
    self.tableView.headerRefreshingText = @"正在刷新";
}

#pragma mark 开始进入刷新状态
- (void)headerRereshing
{
    
}

- (void)footerRereshing
{
    
}

#pragma mark ---  电源条变色
-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}


//- (void)webViewDidFinishLoad:(UIWebView *)webView
//{
//    NSString *str = @"document.getElementsByTagName('body')[0].style.webkitTextSizeAdjust= '250%'";
//    [webView stringByEvaluatingJavaScriptFromString:str];
//}

#pragma mark -- 添加web
-(void)addWebView:(NSString *)url and:(CGRect)frame
{
    if(!url)
    {
        [self showHUDWithString:@"链接无效"];
    }
    
    _webView = [[UIWebView alloc]initWithFrame:frame];
    _webView.backgroundColor = [UIColor whiteColor];
    _webView.scalesPageToFit = YES;//自动对页面进行缩放以适应屏幕
    [self.view addSubview:_webView];
    _webView.delegate = self;
    _webView.scrollView.bounces = NO;
    _webView.scrollView.showsHorizontalScrollIndicator = NO;
    _webView.scrollView.showsVerticalScrollIndicator = NO;
    NSURL *filePath = [[NSBundle mainBundle] URLForResource:[NSString stringWithFormat:@"%@.html",url] withExtension:nil];
    NSURLRequest* request = [NSURLRequest requestWithURL:filePath];
    [_webView loadRequest:request];//加载
}
@end


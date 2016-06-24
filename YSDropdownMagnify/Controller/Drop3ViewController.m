//
//  Drop3ViewController.m
//  YSDropdownMagnify
//
//  Created by jiangys on 16/6/23.
//  Copyright © 2016年 jiangys. All rights reserved.
//

#import "Drop3ViewController.h"
#import "UINavigationBar+Transparent.h"
#import "YSTestViewController.h"
#import "UIView+YSKit.h"

#define kScreenWidth ([UIScreen mainScreen].bounds.size.width)
#define kScreenHeight ([UIScreen mainScreen].bounds.size.height)
#define NavigationBarBGColor [UIColor colorWithRed:32/255.0f green:177/255.0f blue:232/255.0f alpha:1]
#define kHeadImageHeight 200
#define Max_OffsetY  50 // 表示滚动到Y值哪里才显示导航栏

@interface Drop3ViewController ()<UITableViewDataSource, UITableViewDelegate>

@property(nonatomic, strong) UITableView *tableView;
@property(nonatomic, strong) UIImageView *imageView;
@property(nonatomic, strong) UIImageView *avatarView;
/** 是否将要销毁  */
@property(nonatomic) BOOL isDisappear;

@end

@implementation Drop3ViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    _isDisappear = NO;
    [self scrollViewDidScroll:self.tableView];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self.navigationController.navigationBar ys_reset];
    _isDisappear = YES;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor redColor];
    
    //添加TableView
    [self createTableView];
    
    //添加表头视图
    [self addTableHeadView];
    
    //设置导航
    [self.navigationController.navigationBar ys_setBackgroundColor:[UIColor clearColor]];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"right" style:(UIBarButtonItemStylePlain) target:self action:@selector(right)];
}

- (void)createTableView
{
    self.automaticallyAdjustsScrollViewInsets = NO;
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_tableView];
}

- (void)addTableHeadView
{
    self.imageView = [[UIImageView alloc]init];
    self.imageView.frame = CGRectMake(0, -kHeadImageHeight, kScreenWidth, kHeadImageHeight);
    self.imageView.image = [UIImage imageNamed:@"background"];
    self.imageView.contentMode = UIViewContentModeScaleAspectFill;
    self.imageView.clipsToBounds = YES;
    [self.tableView addSubview:self.imageView];
    
    _avatarView = [UIImageView new];
    _avatarView.image = [UIImage imageNamed:@"icon.jpg"];
    _avatarView.contentMode = UIViewContentModeScaleToFill;
    _avatarView.size = CGSizeMake(80, 80);
    _avatarView.y = -120;
    _avatarView.centerX = kScreenWidth * 0.5;
    _avatarView.layer.masksToBounds = YES;
    _avatarView.layer.cornerRadius = _avatarView.width / 2;
    [self.tableView addSubview:_avatarView];
    
    self.tableView.contentInset = UIEdgeInsetsMake(kHeadImageHeight, 0, 0, 0);
}

#pragma mark - UITableViewDelegate，UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"测试测试测试测试 %ld",indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    YSTestViewController *testController = [[YSTestViewController alloc] init];
    [self.navigationController pushViewController:testController animated:YES];
}

/**
 *  当改变了scrollView的contentOffset，都会调用该方法。由于，在跳转到另一个控制器的时候，会被触发，导致导航栏为空白。
 *  因而，加上_isDisappear判断，如果是跳转则不执行
 *
 */
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (_isDisappear) {
        return;
    }
    CGFloat offSet_Y = self.tableView.contentOffset.y;
    NSLog(@"上下偏移量 OffsetY:%f ->",offSet_Y);
    
    if (offSet_Y < -kHeadImageHeight) {
        //获取imageView的原始frame
        CGRect frame = self.imageView.frame;
        //修改y
        frame.origin.y = offSet_Y;
        //修改height
        frame.size.height = -offSet_Y;
        //重新赋值
        self.imageView.frame = frame;
    }
    
    //tableView相对于图片的偏移量
    CGFloat reoffSet = offSet_Y + kHeadImageHeight;
    NSLog(@"reoffSet:%f ->",reoffSet);
    // kHeadImageHeight-64是为了向上拉倒导航栏底部时alpha = 1
    if (reoffSet > Max_OffsetY) {
        CGFloat alpha = (reoffSet - Max_OffsetY)/(kHeadImageHeight-64 - Max_OffsetY);
        alpha = MIN(alpha, 0.99);
        self.title = alpha > 0.8 ? @"导航栏":@"";
        [self.navigationController.navigationBar ys_setBackgroundColor:[NavigationBarBGColor colorWithAlphaComponent:alpha]];
    } else {
        [self.navigationController.navigationBar ys_setBackgroundColor:[NavigationBarBGColor colorWithAlphaComponent:0]];
    }
}

#pragma mark - 私有方法
- (void)right
{
    
}
@end

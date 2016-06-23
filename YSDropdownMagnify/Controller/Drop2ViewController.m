//
//  Drop2ViewController.m
//  YSDropdownMagnify
//
//  Created by jiangys on 16/6/23.
//  Copyright © 2016年 jiangys. All rights reserved.
//

#import "Drop2ViewController.h"
#import "ViewController.h"
#import "UIViewController+navigatinSetting.h"

#define kScreenWidth ([UIScreen mainScreen].bounds.size.width)
#define kScreenHeight ([UIScreen mainScreen].bounds.size.height)
#define YSRGBAColor(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]
#define kHeadImageHeight 200

@interface Drop2ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic, strong) UITableView *tableView;
@property(nonatomic, strong) UIImageView *imageView;

@end

@implementation Drop2ViewController


- (void)viewDidAppear:(BOOL)animated
{
    [self transitionAlpha];
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [self setNavigationBarAlpha:1.0];
    [super viewWillDisappear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"导航栏下拉隐藏";
    
    //添加TableView
    [self createTableView];
    //添加表头视图
    [self addTableHeadView];
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
    [self.tableView addSubview:self.imageView];
    self.imageView.contentMode = UIViewContentModeScaleAspectFill;
    self.imageView.clipsToBounds = YES;
    self.tableView.contentInset = UIEdgeInsetsMake(kHeadImageHeight, 0, 0, 0);
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identify = @"ID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"测试cell%ld",(long)indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ViewController *vc = [[ViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

/**
 *  核心代码
 *
 *  @param scrollView scrollView
 */
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self transitionAlpha];
}

- (void)transitionAlpha
{
    NSLog(@"contentOffset--%f",self.tableView.contentOffset.y);
    
    CGFloat offSet_Y = self.tableView.contentOffset.y;
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
    //kHeadImageHeight-64是为了向上拉倒导航栏底部时alpha = 1
    CGFloat alpha = reoffSet/(kHeadImageHeight-64);
    alpha = MIN(alpha, 0.99);
    
    [self setNavigationBarAlpha:alpha];
}

@end

//
//  Drop3ViewController.m
//  YSDropdownMagnify
//
//  Created by jiangys on 16/6/23.
//  Copyright © 2016年 jiangys. All rights reserved.
//

#import "Drop3ViewController.h"
#import "UINavigationBar+Transparent.h"

#define kScreenWidth ([UIScreen mainScreen].bounds.size.width)
#define kScreenHeight ([UIScreen mainScreen].bounds.size.height)
#define YSRGBAColor(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]
#define kHeadImageHeight 200

@interface Drop3ViewController ()<UITableViewDataSource, UITableViewDelegate>

@property(nonatomic, strong) UITableView *tableView;
@property(nonatomic, strong) UIImageView *imageView;

@end

@implementation Drop3ViewController

static NSString *ID = @"cell";

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    
    self.title = @"表头视图";
    
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

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar js_setBackgroundColor:[UIColor clearColor]];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar js_reset];
}

#pragma mark - UITableViewDelegate，UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"测试测试测试测试 %ld",indexPath.row];
    
    return cell;
}

//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    TestViewController *testController = [[TestViewController alloc] init];
//    [self.navigationController pushViewController:testController animated:YES];
//}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offsetY = scrollView.contentOffset.y;
    if (offsetY >0) {
        CGFloat alpha = (offsetY -64) / 64 ;
        alpha = MIN(alpha, 0.99);
        [self.navigationController.navigationBar js_setBackgroundColor:[[UIColor whiteColor] colorWithAlphaComponent:alpha]];
    } else {
        [self.navigationController.navigationBar js_setBackgroundColor:[UIColor clearColor]];
    }
}

@end

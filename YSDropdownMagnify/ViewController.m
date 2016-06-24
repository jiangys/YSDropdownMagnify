//
//  ViewController.m
//  YSDropdownMagnify
//
//  Created by jiangys on 16/6/23.
//  Copyright © 2016年 jiangys. All rights reserved.
//

#import "ViewController.h"
#import "Drop1ViewController.h"
#import "Drop2ViewController.h"
#import "Drop3ViewController.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *dataArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"下拉放大";
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view, typically from a nib.
    _dataArray = @[@"隐藏原生导航栏，自定义导航View",@"改变原生导航栏背景透明",@"原生导航栏通过添加背景图片改变"];
    
    _tableView= [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate=self;
    _tableView.tableFooterView = [UIView new];
    [self.view addSubview:_tableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource数据源方法
// 返回每组行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

// 返回每行的单元格
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.textLabel.text = _dataArray[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        Drop1ViewController *mineVc = [[Drop1ViewController alloc] init];
        [self.navigationController pushViewController:mineVc animated:YES];
    } else if (indexPath.row == 1)
    {
        Drop2ViewController *mineVc = [[Drop2ViewController alloc] init];
        [self.navigationController pushViewController:mineVc animated:YES];
    } else {
        Drop3ViewController *mineVc = [[Drop3ViewController alloc] init];
        [self.navigationController pushViewController:mineVc animated:YES];
    }
}
@end


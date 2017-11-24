//
//  ViewController.m
//  SHUIImageExpansion
//
//  Created by angle on 2017/11/24.
//  Copyright © 2017年 angle. All rights reserved.
//

#import "ViewController.h"
#import "SHImageViewController.h"
#import "SHImageViewController.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableDictionary *dataDict;
@property (nonatomic, strong) NSMutableArray *keys;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.navigationItem.title = @"UIImage 扩展";
    
    [self.view addSubview:self.tableView];
    
}
#pragma mark -
#pragma mark   ==============UITableViewDelegate==============
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section < [self.keys count] && indexPath.row < [self.dataDict[self.keys[indexPath.section]] count]) {
        SHImageViewController *controller = [[SHImageViewController alloc] init];
        controller.bitmapType = indexPath.section + indexPath.row;
        [self.navigationController pushViewController:controller animated:YES];
    }
}
#pragma mark -
#pragma mark   ==============UITableViewDataSource==============
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.keys count];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.dataDict[self.keys[section]] count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    if (indexPath.section < [self.dataDict.allKeys count] && indexPath.row < [self.dataDict[self.keys[indexPath.section]] count]) {
        cell.textLabel.text = [NSString stringWithFormat:@"%@",self.dataDict[self.keys[indexPath.section]][indexPath.row]];
    }
    return cell;
}
#pragma mark -
#pragma mark   ==============lazy==============
- (NSMutableDictionary *)dataDict {
    if (_dataDict == nil) {
        _dataDict = @{@"Size":@[@"图片绘制圆角",@"改变图片尺寸"],
                      @"Color":@[@"绘制一个颜色图片"],
                      @"Image":@[@"添加水印",@"根据原图绘制一个全屏宽"],
                      @"String":@[@"字符串绘制一张图片",@"富文本字符串绘制一张图片"],
                      @"animatedGIF":@[@"二进制流gif图",@"本地gif图绘制"]}.mutableCopy;
    }
    return _dataDict;
}
- (NSMutableArray *)keys {
    if (_keys == nil) {
        _keys = self.dataDict.allKeys.mutableCopy;
    }
    return _keys;
}
- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:(UITableViewStyleGrouped)];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        [_tableView registerClass:UITableViewCell.class forCellReuseIdentifier:@"cell"];
    }
    return _tableView;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

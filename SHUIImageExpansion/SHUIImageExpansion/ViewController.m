//
//  ViewController.m
//  SHUIImageExpansion
//
//  Created by angle on 2017/11/24.
//  Copyright © 2017年 angle. All rights reserved.
//

#import "ViewController.h"
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
- (SHImageBitmapType)matchIndexPath:(NSIndexPath *)indePath {
    if (indePath.section == 0) {
        if (indePath.row == 0) {
            return SHImageBitmapTypeRadius;
        }
        return SHImageBitmapTypeSize;
    }else if (indePath.section == 1) {
        return SHImageBitmapTypeColor;
    }else if (indePath.section == 2) {
        if (indePath.row == 0) {
            return SHImageBitmapTypeWaterImage;
        }
        return SHImageBitmapTypeScreenImage;
    }else if (indePath.section == 3) {
        if (indePath.row == 0) {
            return SHImageBitmapTypeStringImage;
        }
        return SHImageBitmapTypeAttributedStringImage;
    }else if (indePath.section == 4) {
        if (indePath.row == 0) {
            return SHImageBitmapTypeSourceData;
        }else if (indePath.row == 1){
            return SHImageBitmapTypeSourceName;
        }
        return SHImageBitmapTypeSourceSize;
    }else if (indePath.section == 5) {
        return SHImageBitmapTypeDrawArc;
    }
    return SHImageBitmapTypeNone;
}
#pragma mark -
#pragma mark   ==============UITableViewDelegate==============
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section < [self.keys count] && indexPath.row < [self.dataDict[self.keys[indexPath.section]] count]) {
        SHImageViewController *controller = [[SHImageViewController alloc] init];
        controller.bitmapType = [self matchIndexPath:indexPath];
        controller.navigationItem.title = [NSString stringWithFormat:@"%@",self.dataDict[self.keys[indexPath.section]][indexPath.row]];
        [self.navigationController pushViewController:controller animated:YES];
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 30.f;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 30.f)];
    label.text = [NSString stringWithFormat:@"  %@",self.keys[section]];
    label.font = [UIFont boldSystemFontOfSize:17];
    return label;
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
        cell.textLabel.font = [UIFont systemFontOfSize:15];
        cell.textLabel.textColor = [UIColor grayColor];
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
                      @"AnimatedGIF":@[@"二进制流gif图",@"本地gif图绘制",@"gif图更改尺寸"],
                      @"DrawArc":@[@"绘制大转盘扇形"]}.mutableCopy;
    }
    return _dataDict;
}
- (NSMutableArray *)keys {
    if (_keys == nil) {
        _keys = @[@"Size",@"Color",@"Image",@"String",@"AnimatedGIF",@"DrawArc"].mutableCopy;
    }
    return _keys;
}
- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:(UITableViewStyleGrouped)];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        [_tableView registerClass:UITableViewCell.class forCellReuseIdentifier:@"cell"];
        if (@available(iOS 11.0, *)) {
            _tableView.estimatedSectionFooterHeight = 0;
            _tableView.estimatedSectionHeaderHeight = 0;
            _tableView.estimatedRowHeight = 0;
        }
    }
    return _tableView;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

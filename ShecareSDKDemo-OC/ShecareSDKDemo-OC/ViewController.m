//
//  ViewController.m
//  ShecareSDKDemo-OC
//
//  Created by 北京爱康泰科技有限责任公司 on 2018/3/19.
//  Copyright © 2018年 北京爱康泰科技有限责任公司. All rights reserved.
//

#import "ViewController.h"
#import <ShecareSDK/ShecareSDK-Swift.h>

@interface ViewController ()<UITableViewDataSource, UITableViewDelegate, YCBindViewControllerDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDelegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self models].count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *reuseID = @"ShecareSDKDemoOCVCReuseID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseID];
    }
    cell.textLabel.text = [self models][indexPath.row][@"title"];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    int modelID = [(NSNumber *)([self models][indexPath.row][@"id"]) intValue];
    if (modelID == 0) {
        
    } else if (modelID == 1) {
        
    } else if (modelID == 2) {
        
    } else if (modelID == 3) {
        
    } else if (modelID == 4) {
        
    } else if (modelID == 5) {
        
    } else if (modelID == 6) {
        
    }
}

#pragma mark - YCBindViewControllerDelegate

-(void)bindViewController:(YCBindViewController *)bindViewController didBind:(NSString *)macAddress {
    
}

-(void)bindViewController:(YCBindViewController *)bindViewController didFailedToBind:(NSString *)macAddress errorMessage:(NSString *)errorMessage {
    
}

- (NSArray *)models {
    return @[@{@"title": @"绑定体温计", @"id": @0},
             @{@"title": @"解绑体温计，使用固定 MAC 地址", @"id": @1},
             @{@"title": @"打开体温曲线", @"id": @2},
             @{@"title": @"上传基础生理信息", @"id": @3},
             @{@"title": @"上传体温", @"id": @4},
             @{@"title": @"上传经期", @"id": @5},
             @{@"title": @"初始化用户数据", @"id": @6}];
}

@end

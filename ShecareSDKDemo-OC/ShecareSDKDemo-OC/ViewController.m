//
//  ViewController.m
//  ShecareSDKDemo-OC
//
//  Created by 北京爱康泰科技有限责任公司 on 2018/3/19.
//  Copyright © 2018年 北京爱康泰科技有限责任公司. All rights reserved.
//

#import "ViewController.h"
#import <ShecareSDK/ShecareSDK-Swift.h>
#import "YCWebViewController.h"
#import "YCViewController+Extension.h"
#import "YCDOHTTPClient.h"
#import "YCDOConstants.h"
#import "AFNetworking/AFHTTPSessionManager.h"

@interface ViewController ()<UITableViewDataSource, UITableViewDelegate, YCBindViewControllerDelegate>

@property (strong, nonatomic) UITableView *tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"首页";
    [self tableView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)showAlertWithTitle:(NSString *)title
                   message:(NSString *)message
            confirmHandler:(void (^ __nullable)(UIAlertAction *action))confirmHandler {
    UIAlertController *alertC = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *confirmAct = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:confirmHandler];
    [alertC addAction:confirmAct];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        NSLog(@"Show alert with title :%@, message: %@", title, message);
        [[UIViewController currentViewController] presentViewController:alertC animated:YES completion:nil];
    });
}

#pragma mark - UITableViewDelegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self models].count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50.0;
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
        //  实例化绑定页面控制器并设置代理
        YCBindViewController *vc = [[YCBindViewController alloc] init];
        UINavigationController *navC = [[UINavigationController alloc] initWithRootViewController:vc];
        vc.delegate = self;
        [self showViewController:navC sender:nil];
    } else if (modelID == 1) {
        [[ShecareService shared] unBindWithMacAddress:@"C8:FD:19:02:95:7E" completion:^(NSError * _Nullable error) {
            if (error == nil) {
                NSLog(@"解绑成功");
            } else {
                NSLog(@"%@", error);
                NSLog(@"解绑失败");
            }
        }];
    } else if (modelID == 2) {
        YCWebViewController *webVC = [[YCWebViewController alloc] init];
        webVC.urlString = [[ShecareService shared] temperatureCharts];
        webVC.title = @"体温曲线";
        [self.navigationController pushViewController:webVC animated:true];
    } else if (modelID == 3) {
        YCUserInfoModel *infoModel = [[YCUserInfoModel alloc] initWithCycleLength:30 mensLength:6];
        [[ShecareService shared] uploadWithUserInfo:infoModel completion:^(BOOL success) {
            if (success) {
                [self showAlertWithTitle:@"温馨提示" message:@"生理信息上传成功" confirmHandler:nil];
            } else {
                [self showAlertWithTitle:@"温馨提示" message:@"生理信息上传失败" confirmHandler:nil];
            }
        }];
    } else if (modelID == 4) {
        YCTemperatureModel *tempModel1 = [[YCTemperatureModel alloc] initWithTemperature:@"37.12" measureTime:[NSDate dateWithTimeIntervalSinceNow:-86400] deleted:NO];
        YCTemperatureModel *tempModel2 = [[YCTemperatureModel alloc] initWithTemperature:@"36.12" measureTime:[NSDate date] deleted:NO];
        [[ShecareService shared] uploadWithTemperatures:@[tempModel1, tempModel2] completion:^(BOOL success) {
            if (success) {
                [self showAlertWithTitle:@"温馨提示" message:@"温度上传成功" confirmHandler:nil];
            } else {
                [self showAlertWithTitle:@"温馨提示" message:@"温度上传失败" confirmHandler:nil];
            }
        }];
    } else if (modelID == 5) {
        YCPeriodModel *perModel1 = [[YCPeriodModel alloc] initWithDate:[NSDate dateWithTimeIntervalSinceNow:-5 * 86400] period:1 status:1];
        YCPeriodModel *perModel2 = [[YCPeriodModel alloc] initWithDate:[NSDate date] period:2 status:1];
        [[ShecareService shared] uploadWithPeriods:@[perModel1, perModel2] completion:^(BOOL success) {
            if (success) {
                [self showAlertWithTitle:@"温馨提示" message:@"经期上传成功" confirmHandler:nil];
            } else {
                [self showAlertWithTitle:@"温馨提示" message:@"经期上传失败" confirmHandler:nil];
            }
        }];
    } else if (modelID == 6) {
        YCUserInfoModel *infoModel = [[YCUserInfoModel alloc] initWithCycleLength:30 mensLength:6];
        YCTemperatureModel *tempModel1 = [[YCTemperatureModel alloc] initWithTemperature:@"37.12" measureTime:[NSDate dateWithTimeIntervalSinceNow:-86400] deleted:NO];
        YCTemperatureModel *tempModel2 = [[YCTemperatureModel alloc] initWithTemperature:@"36.12" measureTime:[NSDate date] deleted:NO];
        YCPeriodModel *perModel1 = [[YCPeriodModel alloc] initWithDate:[NSDate dateWithTimeIntervalSinceNow:-5 * 86400] period:1 status:1];
        YCPeriodModel *perModel2 = [[YCPeriodModel alloc] initWithDate:[NSDate date] period:2 status:1];
        [[ShecareService shared] initDataWithTemperatures:@[tempModel1, tempModel2] periods:@[perModel1, perModel2] userInfo:infoModel completion:^(BOOL success) {
            if (success) {
                [self showAlertWithTitle:@"温馨提示" message:@"数据初始化成功" confirmHandler:nil];
            } else {
                [self showAlertWithTitle:@"温馨提示" message:@"数据初始化失败" confirmHandler:nil];
            }
        }];
    } else if (modelID == 7) {
        [[ShecareService shared] analysis:^(NSError * _Nullable error, NSDictionary * _Nullable result) {
            if (error == nil) {
                NSLog(@"Response: %@", result);
            } else {
                NSLog(@"Error: %@", error);
            }
        }];
    }
}

#pragma mark - YCBindViewControllerDelegate

-(void)bindViewController:(YCBindViewController *)bindViewController didBind:(NSString *)macAddress {
    [self showAlertWithTitle:@"绑定成功" message:macAddress confirmHandler:^(UIAlertAction *action) {
        [bindViewController dismissViewControllerAnimated:true completion:nil];
    }];
}

-(void)bindViewController:(YCBindViewController *)bindViewController didFailedToBind:(NSString *)macAddress errorMessage:(NSString *)errorMessage {
    [self showAlertWithTitle:@"绑定失败" message:[NSString stringWithFormat:@"%@\n%@", macAddress, errorMessage] confirmHandler:^(UIAlertAction *action) {
        [bindViewController dismissViewControllerAnimated:true completion:nil];
    }];
}

#pragma mark - lazy load

- (NSArray *)models {
    return @[@{@"title": @"绑定体温计", @"id": @0},
             @{@"title": @"解绑体温计，使用固定 MAC 地址", @"id": @1},
             @{@"title": @"打开体温曲线", @"id": @2},
             @{@"title": @"访问智能分析接口", @"id": @7},
             @{@"title": @"上传基础生理信息", @"id": @3},
             @{@"title": @"上传体温", @"id": @4},
             @{@"title": @"上传经期", @"id": @5},
             @{@"title": @"初始化用户数据", @"id": @6}];
}

-(UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

@end

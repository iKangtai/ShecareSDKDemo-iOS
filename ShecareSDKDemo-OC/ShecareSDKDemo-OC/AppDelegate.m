//
//  AppDelegate.m
//  ShecareSDKDemo-OC
//
//  Created by 北京爱康泰科技有限责任公司 on 2018/3/19.
//  Copyright © 2018年 北京爱康泰科技有限责任公司. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import <ShecareSDK/ShecareSDK-Swift.h>
#import "YCDOConstants.h"

@interface AppDelegate ()<BLEThermometerDelegate>
///  蓝牙连接类型
@property (nonatomic, assign) YCBLEConnectType connectType;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [self setupShecareService];
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:[[ViewController alloc] init]];
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)setupShecareService {
    [[ShecareService shared] setApplicationIdentifier:@"123456"];
    [[ShecareService shared] setApplicationSecret:@"1"];
    [[ShecareService shared] setUserIdentifier:@"1002"];
    // 设置 SDK 环境，可以不设置。默认是 线上环境 .release
    [ShecareService shared].environment = YCEnvironmentTester;
    [BLEThermometer shared].delegate = self;
    self.connectType = YCBLEConnectTypeNotBinding;
    [self scanForThermometer];
}

- (void)scanForThermometer {
    //  if the bleutooth availabel to use
    if ([BLEThermometer shared].bleState == YCBLEStateValid) {
        if ([BLEThermometer shared].activePeripheral != nil) {
            NSLog(@"已经连接！");
            return;
        }
        //  start to scan the peripheral
        if ([[BLEThermometer shared] connectThermometerWithType:self.connectType macList:@"C8:FD:19:02:95:7E,18:93:D7:24:7A:8F"]) {
            NSLog(@"Has start to scan.");
        } else {
            NSLog(@"Start scan Failed!");
        }
    }
}

#pragma mark - BLEThermometerDelegate

-(void)bleThermometerDidUpdateState:(BLEThermometer *)bleThermometer {
    if ([bleThermometer bleState] == YCBLEStateValid) {
        [self scanForThermometer];
    } else {
        bleThermometer.activePeripheral = nil;
    }
}

-(void)bleThermometer:(BLEThermometer *)bleThermometer didConnect:(CBPeripheral *)peripheral {
    
}

-(void)bleThermometer:(BLEThermometer *)bleThermometer didFailToConnect:(CBPeripheral *)peripheral error:(NSError *)error {
    [self scanForThermometer];
}

-(void)bleThermometer:(BLEThermometer *)bleThermometer didDisconnect:(CBPeripheral *)peripheral error:(NSError *)error {
    [self scanForThermometer];
}

-(void)bleThermometer:(BLEThermometer *)bleThermometer didUpload:(NSArray<YCTemperatureModel *> *)temperatures {
    NSLog(@"****************\n  temperatures:%@  \n****************", temperatures);
}

-(void)bleThermometer:(BLEThermometer *)bleThermometer didSetTemperatureUnit:(BOOL)success {
    
}

-(void)bleThermometer:(BLEThermometer *)bleThermometer didGetFirmwareVersion:(NSString *)firmwareVersion {
    bleThermometer.firmwareVersion = firmwareVersion;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.6 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [bleThermometer asynchroizationTimeFromLocalWithDate:[NSDate date]];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [bleThermometer setNotifyValueWithType:BLENotifyTypeTransmitTemperature value:0];
        });
    });
}

-(void)bleThermometer:(BLEThermometer *)bleThermometer didSetThermometerTime:(BOOL)success {
    if (success) {
        NSLog(@"同步时间成功");
    } else {
        NSLog(@"同步时间失败");        
    }
}

-(void)bleThermometer:(BLEThermometer *)bleThermometer didGetThermometerPower:(double)value {
    
}

-(void)bleThermometer:(BLEThermometer *)bleThermometer didReadFirmwareImageType:(enum BLEFirmwareImageType)type {
    
}

@end

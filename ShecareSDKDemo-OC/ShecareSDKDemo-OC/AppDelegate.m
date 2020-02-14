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
@property (nonatomic, assign) BLEConnectType connectType;

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
    // 中国家医网 AppID 和 Secret
    [[ShecareService shared] setApplicationIdentifier:@"100024"];
    [[ShecareService shared] setApplicationSecret:@"9838026264882FF82ACE610B8C176DAA"];
    [[ShecareService shared] setUserIdentifier:@"17611113591"];
    // 设置 SDK 环境，可以不设置。默认是 Release 环境 .release
    [ShecareService shared].environment = YCEnvironmentRelease;
    [Thermometer shared].delegate = self;
    self.connectType = BLEConnectTypeNotBinding;
    [self scanForThermometer];
}

- (void)scanForThermometer {
    //  if the bleutooth availabel to use
    if ([Thermometer shared].bleState == BLEStateValid) {
        if ([Thermometer shared].activePeripheral != nil) {
            NSLog(@"已经连接！");
            return;
        }
        //  start to scan the peripheral
        NSLog(@"Has start to scan.");
        [[Thermometer shared] scanWithType:self.connectType macList:@"C8:FD:19:02:95:7E,18:93:D7:24:7A:8F"];
    }
}

#pragma mark - BLEThermometerDelegate

-(void)bleThermometer:(Thermometer *)bleThermometer didStartScan:(NSString *)info {
    
}

-(void)bleThermometerDidUpdateState:(Thermometer *)bleThermometer {
    if ([bleThermometer bleState] == BLEStateValid) {
        [self scanForThermometer];
    } else {
        bleThermometer.activePeripheral = nil;
    }
}

-(void)bleThermometer:(Thermometer *)bleThermometer didConnect:(CBPeripheral *)peripheral {
    
}

-(void)bleThermometer:(Thermometer *)bleThermometer didFailToConnect:(CBPeripheral *)peripheral error:(NSError *)error {
    [self scanForThermometer];
}

-(void)bleThermometer:(Thermometer *)bleThermometer didDisconnect:(CBPeripheral *)peripheral error:(NSError *)error {
    [self scanForThermometer];
}

-(void)bleThermometer:(Thermometer *)bleThermometer didSetTemperatureUnit:(BOOL)success {
    
}

-(void)bleThermometer:(Thermometer *)bleThermometer didGetFirmwareVersion:(NSString *)firmwareVersion {
    bleThermometer.firmwareVersion = firmwareVersion;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.6 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [bleThermometer asynchroizationTimeFromLocalWithDate:[NSDate date]];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [bleThermometer setNotifyValueWithType:BLENotifyTypeTransmitTemperature value:0];
        });
    });
}

-(void)bleThermometer:(Thermometer *)bleThermometer didSetThermometerTime:(BOOL)success {
    if (success) {
        NSLog(@"同步时间成功");
    } else {
        NSLog(@"同步时间失败");        
    }
}

-(void)bleThermometer:(Thermometer *)bleThermometer didGetThermometerPower:(double)value {
    
}

-(void)bleThermometer:(Thermometer *)bleThermometer didReadFirmwareImageType:(enum BLEFirmwareImageType)type {
    
}

- (void)bleThermometer:(Thermometer * _Nonnull)bleThermometer didUpload:(double)temperature time:(NSString * _Nonnull)time flag:(enum BLEMeasureFlag)flag dataStr:(NSString * _Nonnull)dataStr {
    NSLog(@"****************\n  temperatures:%@  \n****************", temperatures);
}


- (void)connectUnBindedHardware:(NSString * _Nonnull)macAddress {
    
}


@end

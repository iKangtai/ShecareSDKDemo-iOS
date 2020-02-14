//
//  AppDelegate.swift
//  ShecareSDKDemo
//
//  Created by 罗培克 on 2018/3/15.
//  Copyright © 2018年 ikangtai.com. All rights reserved.
//

import UIKit
import ShecareSDK

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    lazy var bleThermometer: Thermometer = {
        return Thermometer.shared()
    }()
    var bleConnectType: BLEConnectType = .notBinding


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        setupShecareService(launchOptions: launchOptions)
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = UIColor.white
        //  修改 Alert/ActionSheet 等弹出按钮的颜色
        window?.rootViewController = UINavigationController(rootViewController: ViewController())
        window?.makeKeyAndVisible()
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    fileprivate func setupShecareService(launchOptions: [UIApplicationLaunchOptionsKey: Any]?) {
        // 中国家医网 AppID 和 Secret
        ShecareService.shared().setApplicationIdentifier("100024")
        ShecareService.shared().setApplicationSecret("9838026264882FF82ACE610B8C176DAA")
        ShecareService.shared().setUserIdentifier("17611113591")
        // 设置 SDK 环境，可以不设置。默认是 线上环境 .release
        ShecareService.shared().environment = .release
        bleThermometer.delegate = self
        scanForThermometer(type: bleConnectType)
    }

}

extension AppDelegate: BLEThermometerDelegate {
    func bleThermometer(_ bleThermometer: Thermometer, didStartScan info: String) {
        
    }
    
    func connectUnBindedHardware(_ macAddress: String) {
        
    }
    
    func bleThermometer(_ bleThermometer: Thermometer, didUpload temperature: Double, time: String, flag: BLEMeasureFlag, dataStr: String) {
        
    }
    
    public func scanForThermometer(type: BLEConnectType) {
        //  即使当前状态为 已连接 或 蓝牙不可用，蓝牙扫描状态也需要根据外部传入数据改变
        bleConnectType = type
        if bleThermometer.bleState() != .valid {
            print("Bluetooth is OFF.")
            return
        }
        //  即使当前状态为 已连接，也需要重置 bleThermometer 的 type
        print("Start to scan. Type: \(type)")
        bleThermometer.scan(type: type, macList: "")
    }
    
    func bleThermometerDidUpdateState(_ bleThermometer: Thermometer) {
        
        if bleThermometer.bleState() == .valid {
            scanForThermometer(type: bleConnectType)
        } else {
            bleThermometer.activePeripheral = nil
        }
    }
    
    func bleThermometer(_ bleThermometer: Thermometer, didConnect peripheral: CBPeripheral) {
        
    }
    
    func bleThermometer(_ bleThermometer: Thermometer, didFailToConnect peripheral: CBPeripheral, error: Error?) {
        scanForThermometer(type: bleConnectType)
    }
    
    func bleThermometer(_ bleThermometer: Thermometer,
                        didDisconnect peripheral: CBPeripheral,
                        error: Error?) {
        scanForThermometer(type: bleConnectType)
    }
    
    func bleThermometer(_ bleThermometer: Thermometer, didSetTemperatureUnit success: Bool) {
        print("set temperature unit, result: \(success)")
    }
    
    func bleThermometer(_ bleThermometer: Thermometer, didGetFirmwareVersion firmwareVersion: String) {
        bleThermometer.firmwareVersion = firmwareVersion
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
            bleThermometer.asynchroizationTimeFromLocal(date: Date())
            DispatchQueue.main.asyncAfter(deadline: .now() + 5.0, execute: {
                bleThermometer.setNotifyValue(type: .transmitTemperature, value: 0)
            })
        }
    }
    
    func bleThermometer(_ bleThermometer: Thermometer, didSetThermometerTime success: Bool) {
        if success {
            print("\(type(of: self)) sync time success!")
        } else {
            print("\(type(of: self)) sync time fail")
        }
    }
    
    func bleThermometer(_ bleThermometer: Thermometer, didGetThermometerPower value: Double) {
    }
    
    func bleThermometer(_ bleThermometer: Thermometer, didReadFirmwareImageType type: BLEFirmwareImageType) {
    }
    
}


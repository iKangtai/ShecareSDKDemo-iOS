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
    lazy var bleThermometer: BLEThermometer = {
        return BLEThermometer.shared()
    }()
    var bleConnectType: YCBLEConnectType = .notBinding


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
        ShecareService.shared().setApplicationIdentifier("123456")
        ShecareService.shared().setApplicationSecret("1")
        ShecareService.shared().setUserIdentifier(userIdentifier)
        bleThermometer.delegate = self
        scanForThermometer(type: bleConnectType)
    }

}

extension AppDelegate: BLEThermometerDelegate {
    
    public func scanForThermometer(type: YCBLEConnectType) {
        //  即使当前状态为 已连接 或 蓝牙不可用，蓝牙扫描状态也需要根据外部传入数据改变
        bleConnectType = type
        if bleThermometer.bleState() != .valid {
            print("Bluetooth is OFF.")
            return
        }
        //  即使当前状态为 已连接，也需要重置 bleThermometer 的 type
        if bleThermometer.connectThermometer(type: type, macList: "") {
            print("Start to scan. Type: \(type)")
        } else {
            print("Start scan failed!")
        }
    }
    
    func bleThermometerDidUpdateState(_ bleThermometer: BLEThermometer) {
        
        if bleThermometer.bleState() == .valid {
            scanForThermometer(type: bleConnectType)
        } else {
            bleThermometer.activePeripheral = nil
        }
    }
    
    func bleThermometer(_ bleThermometer: BLEThermometer, didConnect peripheral: CBPeripheral) {
        
    }
    
    func bleThermometer(_ bleThermometer: BLEThermometer, didFailToConnect peripheral: CBPeripheral, error: Error?) {
        scanForThermometer(type: bleConnectType)
    }
    
    func bleThermometer(_ bleThermometer: BLEThermometer,
                        didDisconnect peripheral: CBPeripheral,
                        error: Error?) {
        scanForThermometer(type: bleConnectType)
    }
    
    func bleThermometer(_ bleThermometer: BLEThermometer,
                        didUpload temperatures: [YCTemperatureModel]) {
        print("***************\n temperatures: " + temperatures.description + " \n****************")
        
        
    }
    
    func bleThermometer(_ bleThermometer: BLEThermometer, didSetTemperatureUnit success: Bool) {
        print("set temperature unit, result: \(success)")
    }
    
    func bleThermometer(_ bleThermometer: BLEThermometer, didGetFirmwareVersion firmwareVersion: String) {
        bleThermometer.firmwareVersion = firmwareVersion
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
            bleThermometer.asynchroizationTimeFromLocal(date: Date())
            DispatchQueue.main.asyncAfter(deadline: .now() + 5.0, execute: {
                bleThermometer.setNotifyValue(type: .transmitTemperature, value: 0)
            })
        }
    }
    
    func bleThermometer(_ bleThermometer: BLEThermometer, didSetThermometerTime success: Bool) {
        if success {
            print("\(type(of: self)) sync time success!")
        } else {
            print("\(type(of: self)) sync time fail")
        }
    }
    
    func bleThermometerDidGetTemperature(_ bleThermometer: BLEThermometer) {
    }
    
    func bleThermometer(_ bleThermometer: BLEThermometer, didGetThermometerPower value: Double) {
    }
    
    func bleThermometer(_ bleThermometer: BLEThermometer, didReadFirmwareImageType type: BLEFirmwareImageType) {
    }
    
}


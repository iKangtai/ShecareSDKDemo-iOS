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
    var bleConnectType: BLEConnectType = .notBinding
    var validTemperatures = [[String: Any]]()


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
        ShecareService.shared().setApplicationSecret("ikangtai123")
        ShecareService.shared().setUserIdentifier("luopk@ikangtai.com")
        // 设置 SDK 环境，可以不设置。默认是 线上环境 .release
        ShecareService.shared().environment = .release
        Thermometer.shared.delegate = self
        scanForThermometer(type: bleConnectType)
    }

}

extension AppDelegate: BLEThermometerDelegate {
    func bleThermometer(_ bleThermometer: Thermometer, didStartScan info: String) {
        
    }
    
    func connectUnBindedHardware(_ macAddress: String) {
        
    }
    
    func bleThermometer(_ bleThermometer: Thermometer, didUpload temperature: Double, time: String, flag: BLEMeasureFlag, dataStr: String) {
        
        print("\n******* 体温计上传温度: \(temperature), " + "时间: " + time + ", 类型: " + flag.descString())
        
        let formatter = DateFormatter()
        formatter.locale = Locale.current
        formatter.timeZone = TimeZone.current
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let measTime = formatter.date(from: time) as NSDate? ?? NSDate()
        
        validTemperatures.append(["measureTime": measTime, "temperature": temperature])
        
        switch flag {
        case .offlineBegin:
            break
        case .offlineEnd: // 体温数据上传结束
            if validTemperatures.count > 0 {
                print(validTemperatures)
                print("上传数量：\(self.validTemperatures.count)")
                bleThermometer.setNotifyValue(type: .temperatureCount, value: UInt8(self.validTemperatures.count))
                self.validTemperatures.removeAll()
            }
        case .online:
            //  一代设备 或 额温枪 数据上传
            if validTemperatures.count > 0 {
                print(validTemperatures)
                print("上传数量：\(self.validTemperatures.count)")
            }
            validTemperatures.removeAll()
        case .unknown:
            break
        }
    }
    
    public func scanForThermometer(type: BLEConnectType) {
        //  即使当前状态为 已连接 或 蓝牙不可用，蓝牙扫描状态也需要根据外部传入数据改变
        bleConnectType = type
        //  即使当前状态为 已连接，也需要重置 bleThermometer 的 type
        print("Start to scan. Type: " + type.descString())
        Thermometer.shared.scan(type: type, macList: "")
    }
    
    func bleThermometerDidUpdateState(_ bleThermometer: Thermometer) {
        if bleThermometer.bleState() == .valid {
        } else {
            NotificationCenter.default.post(name: .thermometerConnectSuccess, object: false)
            bleThermometer.activePeripheral = nil
        }
        scanForThermometer(type: bleConnectType)
        NotificationCenter.default.post(name: .thermometerDidUpdateState,
                                        object: bleThermometer.bleState())
    }
    
    func bleThermometer(_ bleThermometer: Thermometer, didConnect peripheral: CBPeripheral) {
        
        NotificationCenter.default.post(name: .thermometerConnectSuccess, object: true)
    }
    
    func bleThermometerDidStopScan(_ bleThermometer: Thermometer) {
        print("停止扫描")
    }
    
    func bleThermometer(_ bleThermometer: Thermometer, didSetDefaultProperties info: String) {
        print(info)
    }
    
    func bleThermometer(_ bleThermometer: Thermometer, didAsynchroizationTimeFromLocal info: String) {
        print(info)
    }
    
    func bleThermometer(_ bleThermometer: Thermometer, didGetTemperatureIndication indication: String) {
        print(indication)
        bleThermometer.setNotifyValue(type: .thermometerPower, value: 0)
    }
    
    func bleThermometer(_ bleThermometer: Thermometer, didFailToConnect peripheral: CBPeripheral, error: Error?) {
        scanForThermometer(type: bleConnectType)
    }
    
    func bleThermometer(_ bleThermometer: Thermometer,
                        didDisconnect peripheral: CBPeripheral,
                        error: Error?) {
        scanForThermometer(type: bleConnectType)
        validTemperatures.removeAll()
        NotificationCenter.default.post(name: .thermometerConnectSuccess, object: false)
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
        NotificationCenter.default.post(name: .thermometerGetFirmwareVersion, object: bleThermometer)
    }
    
    func bleThermometer(_ bleThermometer: Thermometer, didSetThermometerTime success: Bool) {
        if success {
            print("\(type(of: self)) sync time success!")
        } else {
            print("\(type(of: self)) sync time fail")
        }
        NotificationCenter.default.post(name: .thermometerSetTime, object: success)
    }
    
    func bleThermometer(_ bleThermometer: Thermometer, didGetThermometerPower value: Double) {
    }
    
    func bleThermometer(_ bleThermometer: Thermometer, didReadFirmwareImageType type: BLEFirmwareImageType) {
    }
    
}


//
//  ViewController.swift
//  ShecareSDKDemo
//
//  Created by 罗培克 on 2018/3/15.
//  Copyright © 2018年 ikangtai.com. All rights reserved.
//

import UIKit
import ShecareSDK

class ViewController: UIViewController {
    
    fileprivate let models = [["title": "绑定体温计", "id": 0],
                              ["title": "解绑体温计，使用固定 MAC 地址", "id": 1],
//                              ["title": "打开体温曲线", "id": 2],
//                              ["title": "访问智能分析接口", "id": 7],
//                              ["title": "上传基础生理信息", "id": 3],
                              ["title": "上传体温", "id": 4],
//                              ["title": "上传经期", "id": 5],
//                              ["title": "初始化用户数据", "id": 6]
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "首页"
        self.view.addSubview(tableView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    let reuseID = "ReuseIDForHomePage"
    fileprivate let cellHeight: CGFloat = 50
    fileprivate lazy var tableView: UITableView = {
        let tableView = UITableView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height), style: UITableViewStyle.plain)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: self.reuseID)
        tableView.bounces = false
        return tableView
    }()
}

extension ViewController {
    public func showAlert(title: String?,
                                message: String?,
                                confirmHandler: ((UIAlertAction) -> Void)?,
                                cancelHandler: ((UIAlertAction) -> Void)?) {
        
        let alertC = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        let confirmAct1 = UIAlertAction(title: "确定",
                                        style: UIAlertActionStyle.default,
                                        handler: confirmHandler)
        alertC.addAction(confirmAct1)
        if cancelHandler != nil {
            let cancelAct = UIAlertAction(title: "取消",
                                          style: UIAlertActionStyle.default,
                                          handler: cancelHandler)
            alertC.addAction(cancelAct)
        }
        
        DispatchQueue.main.async {
            //  避免重复弹出同一个弹窗
            let currentVC = UIViewController.currentViewController()
            if currentVC.isKind(of: type(of: UIAlertController())) {
                if let currentAlertC = currentVC as? UIAlertController {
                    if currentAlertC.title == title && currentAlertC.message == message {
                        return
                    }
                }
            }
            print("===> Show alert with title: " + (title ?? "nil") + ", message: " + (message ?? "nil"))
            currentVC.present(alertC, animated: true, completion: nil)
        }
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseID)
        cell?.textLabel?.text = models[indexPath.row]["title"] as? String
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeight
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cellID = models[indexPath.row]["id"] as! NSNumber
        switch cellID {
        case 0:
            //  实例化绑定页面控制器并设置代理
            let vc = YCBindViewController()
            vc.delegate = self
            let leftItem = UIBarButtonItem(title: "Return", style: .plain, target: self, action: #selector(dismissBindVC))
            vc.navigationItem.leftBarButtonItem = leftItem
            vc.title = "设备绑定"
            let navC = UINavigationController(rootViewController: vc)
            self.show(navC, sender: nil)
        case 1:
            ShecareService.shared().unBind(macAddress: "C8:FD:19:02:95:7E") { error in
                if error == nil {
                    print("解绑成功")
                } else {
                    print(error!)
                    print("解绑失败")
                }
            }
        case 2:
            let webVC = YCWebViewController()
            webVC.urlString = ShecareService.shared().temperatureCharts()
            webVC.title = "体温曲线"
            self.navigationController?.pushViewController(webVC, animated: true)
        case 3:
            let userInfo = YCUserInfoModel(cycleLength: 30, mensLength: 6)
            ShecareService.shared().upload(userInfo: userInfo) { error in
                if error == nil {
                    self.showAlert(title: "温馨提示", message: "生理信息上传成功！", confirmHandler: nil, cancelHandler: nil)
                } else {
                    print(error!)
                    self.showAlert(title: "温馨提示", message: "生理信息上传失败！", confirmHandler: nil, cancelHandler: nil)
                }
            }
        case 4:
            let tempModel1 = YCTemperatureModel(temperature: "37.12", measureTime: NSDate(timeIntervalSinceNow: -86_400), deleted: false)
            let tempModel2 = YCTemperatureModel(temperature: "36.87", measureTime: NSDate(), deleted: false)
            ShecareService.shared().upload(temperatures: [tempModel1, tempModel2]) { error in
                if error == nil {
                    self.showAlert(title: "温馨提示", message: "温度上传成功！", confirmHandler: nil, cancelHandler: nil)
                } else {
                    print(error!)
                    self.showAlert(title: "温馨提示", message: "温度上传失败！", confirmHandler: nil, cancelHandler: nil)
                }
            }
        case 5:
            let startDate = NSDate(timeIntervalSinceNow: -5 * 86_400)
            let periodModel1 = YCPeriodModel(date: startDate, period: 1, deleted: false)
            let periodModel2 = YCPeriodModel(date: NSDate(), period: 2, deleted: false)
            ShecareService.shared().upload(periods: [periodModel1, periodModel2]) { error in
                if error == nil {
                    self.showAlert(title: "温馨提示", message: "经期信息上传成功！", confirmHandler: nil, cancelHandler: nil)
                } else {
                    print(error!)
                    self.showAlert(title: "温馨提示", message: "经期信息上传失败！", confirmHandler: nil, cancelHandler: nil)
                }
            }
        case 6:
            let userInfo = YCUserInfoModel(cycleLength: 30, mensLength: 6)
            let startDate = NSDate(timeIntervalSinceNow: -5 * 86_400)
            let tempModel1 = YCTemperatureModel(temperature: "37.22", measureTime: startDate, deleted: false)
            let tempModel2 = YCTemperatureModel(temperature: "36.97", measureTime: NSDate(), deleted: false)
            let temperatures = [tempModel1, tempModel2]
            let periodModel1 = YCPeriodModel(date: startDate, period: 1, deleted: false)
            let periodModel2 = YCPeriodModel(date: NSDate(), period: 2, deleted: false)
            let periods = [periodModel1, periodModel2]
            if ShecareService.shared().needInitData() {
                ShecareService.shared().initData(temperatures: temperatures, periods: periods, userInfo: userInfo, completion: { error in
                    if error == nil {
                        //  Shecare SDK 数据初始化成功
                        self.showAlert(title: "温馨提示", message: "初始化成功！", confirmHandler: nil, cancelHandler: nil)
                    } else {
                        print(error!)
                        //  Shecare SDK 数据初始化失败
                        self.showAlert(title: "温馨提示", message: "初始化失败！", confirmHandler: nil, cancelHandler: nil)
                    }
                })
            } else {
                print("=====> 不需要重复初始化数据！")
            }
        case 7:
            ShecareService.shared().analysis({ (error, result) in
                if let error = error {
                    print(error)
                } else {
                    print(result ?? "analysis result is nil.")
                }
            })
        default:
            break
        }
    }
    
    @objc private func dismissBindVC() {
        self.dismiss(animated: true, completion: nil)
    }
}

extension ViewController: YCBindViewControllerDelegate {
    func bindViewController(_ bindViewController: YCBindViewController, didBind macAddress: String, error: NSError?) {
        if error == nil {
            showAlert(title: "绑定成功", message: macAddress, confirmHandler: { (_) in
                bindViewController.dismiss(animated: true, completion: nil)
            }, cancelHandler: nil)
        } else {
            showAlert(title: "绑定失败", message: macAddress + "\n" + (error?.localizedDescription)!, confirmHandler: { (_) in
                bindViewController.dismiss(animated: true, completion: nil)
            }, cancelHandler: nil)
        }
    }
}


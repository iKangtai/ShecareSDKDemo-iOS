
#### ShecareSDK Demo

##### 注意事项
- 必须把 YCShecareV2 添加到 info.plist 的 LSApplicationQueriesSchemes 白名单里；
- 需要把 bluetooth-central 添加到 info.plist 的 UIBackgroundModes 项里；
- 需要把 NSBluetoothPeripheralUsageDescription 添加到 info.plist 里；
- 和孕橙智能体温计配合使用；
- AppDelegate 里需要执行一次 bleThermometer.bleState() 方法，否则直接进入绑定页，首次获取蓝牙状态得到的返回值是 YCBLEStateUnknown。
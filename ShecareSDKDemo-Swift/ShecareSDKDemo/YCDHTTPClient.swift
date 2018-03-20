//
//  YCDHTTPClient.swift
//  ShecareSDKDemo
//
//  Created by 罗培克 on 2018/3/20.
//  Copyright © 2018年 ikangtai.com. All rights reserved.
//

import UIKit

class YCDHTTPClient: NSObject {
    let defaultHeaders = ["Accept": "application/json;charset=UTF-8"]
    var sessionManager: SessionManager?
    let nullResponse = NSNull()
    
    static let sharedClient: YCDHTTPClient = {
        let instance = YCDHTTPClient()
        
        let serverTrustPolicies: [String: ServerTrustPolicy] = [
            "developer.ikangtai.com": .performDefaultEvaluation(validateHost: true)
        ]
        let stpMan = ServerTrustPolicyManager(policies: serverTrustPolicies)
        instance.sessionManager = SessionManager(configuration: URLSessionConfiguration.default,
                                                 delegate: SessionDelegate(),
                                                 serverTrustPolicyManager: stpMan)
        
        return instance
    }()
}

//
//  RNUserdefaults.swift
//  RNUserdefaults
//
//  Created by Kamaal Farah on 08/04/2021.
//  Copyright © 2021 Kamaal. All rights reserved.
//

import Foundation

@objc(RNUserdefaults)
public class RNUserdefaults: NSObject {

    private let standardUserDefaultsKey = "STANDARD"

    public override init() {
        super.init()
    }

    @objc
    public func set(_ value: String, forKey key: String, inSuite suite: String) {
        let defaults = determineUserDefaults(inSuite: suite)
        defaults.set(value, forKey: key)
    }

    @objc
    public func get(_ key: String, inSuite suite: String, resolve: RCTPromiseResolveBlock, reject: RCTPromiseRejectBlock) {
        let defaults = determineUserDefaults(inSuite: suite)
        let value = defaults.object(forKey: key) as? String
        resolve(value)
    }

    @objc
    public func remove(_ key: String, inSuite suite: String) {
        let defaults = determineUserDefaults(inSuite: suite)
        defaults.removeObject(forKey: key)
    }

    @objc
    public func set(_ value: String, forKey key: String) {
        set(value, forKey: key, inSuite: standardUserDefaultsKey)
    }

    @objc
    public func get(_ key: String, resolve: RCTPromiseResolveBlock, reject: RCTPromiseRejectBlock) {
        get(key, inSuite: standardUserDefaultsKey, resolve: resolve, reject: reject)
    }

    @objc
    public func remove(_ key: String) {
        remove(key, inSuite: standardUserDefaultsKey)
    }

    private func determineUserDefaults(inSuite suite: String) -> UserDefaults {
        let defaults: UserDefaults
        if suite == standardUserDefaultsKey {
            defaults = .standard
        } else {
            defaults = UserDefaults(suiteName: suite) ?? .standard
        }
        return defaults
    }

    @objc
    static public func requiresMainQueueSetup() -> Bool {
        true
    }

}

//
//  AppDelegate.swift
//  FontTest
//
//  Created by Pit Schrader on 16.01.20.
//  Copyright © 2020 leberwurstsaft.de. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    override init() {
        super.init()
        UIFont.overrideInitialize()
    }
}


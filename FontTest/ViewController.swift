//
//  ViewController.swift
//  FontTest
//
//  Created by Pit Schrader on 16.01.20.
//  Copyright © 2020 leberwurstsaft.de. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let l = UILabel(frame: CGRect(x: 100, y: 100, width: 200, height: 40))
        l.text = "Code label"
        l.font = UIFont.preferredFont(forTextStyle: .title1)
        l.sizeToFit()
        self.view.addSubview(l)

        let l2 = UILabel(frame: CGRect(x: 100, y: 250, width: 200, height: 40))
        l2.text = "Code label 2"
        l2.font = UIFont.preferredFont(forTextStyle: .title2)
        l2.sizeToFit()
        self.view.addSubview(l2)
    }


}


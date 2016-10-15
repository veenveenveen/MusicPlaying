//
//  ViewController.swift
//  MusicPlaying
//
//  Created by 黄启明 on 2016/10/15.
//  Copyright © 2016年 huatengIOT. All rights reserved.
//

import UIKit
import KVNProgress

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        KVNProgress.setConfiguration(KVNProgressConfiguration.default())
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        KVNProgress.show(withStatus: "this is a test")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


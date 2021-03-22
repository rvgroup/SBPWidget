//
//  ViewController.swift
//  SBPWidget
//
//  Created by Nikolay Hordynchuk on 03/22/2021.
//  Copyright (c) 2021 Nikolay Hordynchuk. All rights reserved.
//

import UIKit
import SBPWidget

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    
    SBPWidgetModule().show(on: self) { scheme in
      print(scheme)
    }
  }

}


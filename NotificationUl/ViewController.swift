//
//  ViewController.swift
//  NotificationUl
//
//  Created by neal on 2017/9/12.
//  Copyright © 2017年 neal. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var datePicker: UIDatePicker!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func datePickerDidSelectedNewDate(_ sender: UIDatePicker) {
        if let delegate = UIApplication.shared.delegate as? AppDelegate {
            delegate.scheduleNotification(at: sender.date)
        }
    }


}


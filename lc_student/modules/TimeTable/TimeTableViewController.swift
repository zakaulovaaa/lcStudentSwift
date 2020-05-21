//
//  TimeTableViewController.swift
//  lc_student
//
//  Created by Дарья Закаулова on 21.05.2020.
//  Copyright © 2020 Дарья Закаулова. All rights reserved.
//

import UIKit

class TimeTableViewController: UIViewController {

    @IBOutlet var viewTimeTable: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.viewTimeTable.backgroundColor = ViewAppearance.backgroundColor
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

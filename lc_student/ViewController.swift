//
//  ViewController.swift
//  lc_student
//
//  Created by Дарья Закаулова on 08.04.2020.
//  Copyright © 2020 Дарья Закаулова. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var userModelController: UserModelController!;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //userModelController.user.is_authorized
        
        
//        if ( true ) {
//            
//        } else {
//            performSegue(withIdentifier: "mainGoSignIn", sender: nil);
//        }
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func qq(_ sender: Any) {
        performSegue(withIdentifier: "mainGoSignIn", sender: nil)
    }
    


}


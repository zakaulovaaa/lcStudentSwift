//
//  FirstWindow.swift
//  lc_student
//
//  Created by Дарья Закаулова on 08.05.2020.
//  Copyright © 2020 Дарья Закаулова. All rights reserved.
//

import UIKit

class FirstWindow: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
//        print( UserSettings.userModel ?? "нету" )
        if UserSettings.userModel != nil {
            DispatchQueue.main.async(execute: {
                let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let newViewController = storyboard.instantiateViewController(withIdentifier: "MainMenu") as! MainMenu
                newViewController.modalPresentationStyle = .overFullScreen
                self.present(newViewController, animated: true, completion: nil)
            })
        } else {
            DispatchQueue.main.async(execute: {
                let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let newViewController = storyboard.instantiateViewController(withIdentifier: "SignIn") as! SignIn
                newViewController.modalPresentationStyle = .overFullScreen
                self.present(newViewController, animated: true, completion: nil)
            })
            
        }
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

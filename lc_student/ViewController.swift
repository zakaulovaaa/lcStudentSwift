//
//  ViewController.swift
//  lc_student
//
//  Created by Дарья Закаулова on 08.04.2020.
//  Copyright © 2020 Дарья Закаулова. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
//    var userModelController = UserModelController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
//        let is_authorized = userModelController.user.is_authorized
        
        print( UserSettings.email ?? "нету" )
        
        if UserSettings.email != nil {
            print("!!!!!")
            DispatchQueue.main.async(execute: {
                let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                
                let newViewController = storyboard.instantiateViewController(withIdentifier: "MenuTable") as! MenuTable
                
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
        
//        if ( is_authorized ) {
//            DispatchQueue.main.async(execute: {
//                let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//                let newViewController = storyboard.instantiateViewController(withIdentifier: "Menu") as! Menu
//                newViewController.modalPresentationStyle = .overFullScreen
//                self.present(newViewController, animated: true, completion: nil)
//            })
//        } else {
//            DispatchQueue.main.async(execute: {
//                let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//                let newViewController = storyboard.instantiateViewController(withIdentifier: "SignIn") as! SignIn
//                newViewController.modalPresentationStyle = .overFullScreen
//                self.present(newViewController, animated: true, completion: nil)
//            })
//        }
        
        
        
    }
    
    
    @IBAction func sign(_ sender: Any) {
        

        
    }
    
    
//    @IBAction func menu(_ sender: Any) {
//
//        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//        let newViewController = storyboard.instantiateViewController(withIdentifier: "Menu") as! MenuTable
//        newViewController.modalPresentationStyle = .overFullScreen
//        self.present(newViewController, animated: true, completion: nil)
//    }
    

}

/*
 
 if let newViewController = storyboard?.instantiateViewController(withIdentifier: "NewViewController") as? NewViewController {
  newViewController.modalTransitionStyle = .crossDissolve // это значение можно менять для разных видов анимации появления
  newViewController.modalPresentationStyle = .overCurrentContext // это та самая волшебная строка, убрав или закомментировав ее, вы получите появление смахиваемого контроллера
  present(newViewController, animated: false, completion: nil)
 }
 
 */

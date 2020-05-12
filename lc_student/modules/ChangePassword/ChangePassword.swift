//
//  ChangePassword.swift
//  lc_student
//
//  Created by Дарья Закаулова on 09.05.2020.
//  Copyright © 2020 Дарья Закаулова. All rights reserved.
//

import UIKit

class ChangePassword: UIViewController {

//    let ADDRESS: String = "http://192.168.1.185:8000/" // ДЛЯ ДИМЫ
       
    let ADDRESS: String = "http://localhost:8000/" //ДЛЯ ДАШИ

    @IBOutlet weak var warning: UITextView!
    @IBOutlet weak var oldPassword: UITextField!
    @IBOutlet weak var newPassword1: UITextField!
    @IBOutlet weak var newPassword2: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    

    
    //при нажатии на кнопку сменить
    @IBAction func changePassword(_ sender: Any) {
        var check: Bool = true
        warning.text = ""
        if ( newPassword1.text!.count < 5 ) {
            warning.text += "Пароль должен состоять не менее, \nчем из 5 символов"
            check = false
        }
        if ( newPassword1.text! != newPassword2.text! ) {
            warning.text += "\nВведенные пароли не совпадают"
            check = false
        }
        
        if ( check ) {
            let jsonObject: [String: Any] = [
                "email": UserSettings.userModel.email,
                "current_password": oldPassword.text!,
                "new_password": newPassword1.text!
            ]
            
            let jsonRequest: [String: Any] = requestMain(urlStr: ADDRESS + "actions_with_password/change/",
                                                         jsonBody: jsonObject)
            
            if let status = jsonRequest[ "status" ] as? Bool {
                if ( !status ) {
                    
                    if let message = jsonRequest[ "comment" ] as? String {
                        warning.text = message
                    }
                } else {
                    let alert = UIAlertController(title: "Смена пароля",
                                                  message: "Смена пароля прошла успешно!",
                                                  preferredStyle: .alert)
                    
                    alert.addAction(UIAlertAction(title: "Успех!",
                                                  style: .default,
                                                  handler: nil ))
                            
                    self.present(alert, animated: true)
                    
                }
            }
            
            print(jsonRequest)
            
            
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

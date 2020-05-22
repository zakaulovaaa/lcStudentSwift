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
    @IBOutlet var viewChangePassword: UIView!
    @IBOutlet weak var warningLC: NSLayoutConstraint!
    @IBOutlet weak var btnChangePassword: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //наводим красоту
        viewChangePassword.backgroundColor = ViewAppearance.backgroundColor
        btnChangePassword.setTitleColor(ButtonAppearance.textColor, for: .normal)
        
        oldPassword.backgroundColor = TextFieldAppearance.backgroundColor
        oldPassword.borderStyle = .none
        oldPassword.layer.masksToBounds = false
        oldPassword.layer.cornerRadius = 5.0;
        oldPassword.layer.borderColor = UIColor.clear.cgColor
        oldPassword.layer.shadowColor = TextFieldAppearance.shadowOpacityColor.cgColor
        oldPassword.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        oldPassword.layer.shadowOpacity = 0.6
        oldPassword.layer.shadowRadius = 4.0
        oldPassword.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: oldPassword.frame.height))
        oldPassword.leftViewMode = .always
        
        newPassword1.backgroundColor = TextFieldAppearance.backgroundColor
        newPassword1.borderStyle = .none
        newPassword1.layer.masksToBounds = false
        newPassword1.layer.cornerRadius = 5.0;
        newPassword1.layer.borderColor = UIColor.clear.cgColor
        newPassword1.layer.shadowColor = TextFieldAppearance.shadowOpacityColor.cgColor
        newPassword1.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        newPassword1.layer.shadowOpacity = 0.6
        newPassword1.layer.shadowRadius = 4.0
        newPassword1.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: newPassword1.frame.height))
        newPassword1.leftViewMode = .always
        
        newPassword2.backgroundColor = TextFieldAppearance.backgroundColor
        newPassword2.borderStyle = .none
        newPassword2.layer.masksToBounds = false
        newPassword2.layer.cornerRadius = 5.0;
        newPassword2.layer.borderColor = UIColor.clear.cgColor
        newPassword2.layer.shadowColor = TextFieldAppearance.shadowOpacityColor.cgColor
        newPassword2.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        newPassword2.layer.shadowOpacity = 0.6
        newPassword2.layer.shadowRadius = 4.0
        newPassword2.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: newPassword2.frame.height))
        newPassword2.leftViewMode = .always
        
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
        self.warningLC.constant = self.warning.contentSize.height
        
        if ( check ) {
            let jsonObject: [ String: Any ] = [
                "email": UserSettings.userModel.email,
                "current_password": oldPassword.text!,
                "new_password": newPassword1.text!
            ]
            let jsonRequest: [ String: Any ] = requestMain(
                urlStr: ADDRESS + "actions_with_password/change/",
                jsonBody: jsonObject
            )
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

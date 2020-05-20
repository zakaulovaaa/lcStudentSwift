//
//  RecoverThePassword.swift
//  lc_student
//
//  Created by Дарья Закаулова on 03.05.2020.
//  Copyright © 2020 Дарья Закаулова. All rights reserved.
//

import UIKit

class RecoverThePassword: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewRecoverPassword.backgroundColor = ViewAppearance.backgroundColor
        btnRecover.setTitleColor(ButtonAppearance.textColor, for: .normal)
        
        email.backgroundColor = TextFieldAppearance.backgroundColor
        
        email.borderStyle = .none
        email.layer.masksToBounds = false
        email.layer.cornerRadius = 5.0;
        email.layer.borderColor = UIColor.clear.cgColor
        email.layer.shadowColor = TextFieldAppearance.shadowOpacityColor.cgColor
        email.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        email.layer.shadowOpacity = 0.6
        email.layer.shadowRadius = 4.0
        email.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: email.frame.height))
        email.leftViewMode = .always
        
        navigationController?.navigationBar.barTintColor = ViewAppearance.backgroundColor
        
    }
    
    @IBOutlet var viewRecoverPassword: UIView!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var warning: UITextView!
    @IBOutlet weak var warningHC: NSLayoutConstraint!
    @IBOutlet weak var btnRecover: UIButton!
    
    //на предыдущую страницу
    @IBAction func back(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    //при нажатии на кнопочку восстановить
    @IBAction func recover(_ sender: UIButton) {
        warning.text = email.text!
        let jsonObject: [String: Any] = [
            "email": email.text!
        ]
        let jsonRequest: [String : Any] = requestMain( urlStr: "http://localhost:8000/actions_with_password/reset/",
                    jsonBody: jsonObject
        )
        if let status = jsonRequest[ "status" ] as? Bool {
            
            if ( status ) { //все ок, заявка отправлена
                let alert = UIAlertController(title: "Заявка отправлена!", message: "Дальнейшие инструкции направлены на почту!", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Успех!", style: .default,
                                              handler: { (action: UIAlertAction) in
                    self.dismiss(animated: true, completion: nil)
                }))
                self.present(alert, animated: true)
            } else { //вывод в ворнингах ошибки
                if let message = jsonRequest[ "comment" ] as? String {
                    warning.text = message
                    
                    warningHC.constant = self.warning.contentSize.height
                    
                    warning.textColor = UIColor.systemPink
                }
            }
        }
        
    }
    
    // darya.zakaulova@yandex.ru
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

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

        
    }
    
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var warning: UITextView!
    
    @IBAction func back(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func recover(_ sender: UIButton) {
        warning.text = email.text!
        let jsonObject: [String: Any] = [
            "email": email.text!
        ]
        
        let jsonRequest: [String : Any] = requestMain( urlStr: "http://localhost:8000/actions_with_password/reset/",
                    jsonBody: jsonObject
        )
        if let status = jsonRequest[ "status" ] as? Bool {
            if ( status ) {
                if let message = jsonRequest[ "comment" ] as? String {
                    warning.text = message + "\nДальнейшие инструкции направлены на почту."
                    warning.textColor = UIColor.black
                }
            } else {
                if let message = jsonRequest[ "comment" ] as? String {
                    warning.text = message
                    warning.textColor = UIColor.systemPink
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

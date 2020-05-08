import UIKit


class SignIn: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var warning: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        email.delegate = self
        password.delegate = self
    }
    /*
     * TODO: ДАША НЕ ЗАБУДЬ ПОМЕНЯТЬ
     */
    let ADDRESS: String = "http://192.168.1.185:8000/" // ДЛЯ ДИМЫ
    
//    let ADDRESS: String = "http://localhost:8000/" //ДЛЯ ДАШИ
    
    @IBAction func btnSignIn(_ sender: Any) {
        
        let jsonObject: [String: Any] = [
            "email": email.text!,
            "password": password.text!
        ]
        
        print("DAROVA")
        
        let jsonRequest: [String : Any] = requestMain(
            urlStr: ADDRESS + "sign_in/",
            jsonBody: jsonObject
        )
        
        print( jsonRequest )
        
        if let status_auth = jsonRequest[ "status" ]! as? Bool {
            if ( status_auth ) {
                UserSettings.email = email.text!
                
                performSegue( withIdentifier: "signInGoMenu", sender: nil )
            } else {
                print( "!!!!!!!!!" )
                if let message = jsonRequest[ "comment" ] as? String {
                    warning.text = message
                    print(warning.text!)
                }
            }
        }
    }
        
    func hideKeyBoardInLoginScreen() {
        email.resignFirstResponder()
        password.resignFirstResponder()
    }

    func textFieldShouldReturn(_ textField : UITextField) -> Bool {
        hideKeyBoardInLoginScreen()
        return true
    }

    

}






/*
 

 
 
 */

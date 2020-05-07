import UIKit


class SignIn: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var warning: UILabel!
    
    @IBAction func btnSignIn(_ sender: Any) {
        
        let jsonObject: [String: Any] = [
            "email": email.text!,
            "password": password.text!
        ]
        
        let jsonRequest: [String : Any] = requestMain( urlStr: "http://localhost:8000/sign_in/",
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

    

}






/*
 

 
 
 */

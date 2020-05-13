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
    
//    let ADDRESS: String = "http://192.168.1.185:8000/" // ДЛЯ ДИМЫ
    
    let ADDRESS: String = "http://localhost:8000/" //ДЛЯ ДАШИ
    
    
    func printUserModel(user: UserModel) {
        print( "\n\n\nemail = \(user.email) \nlastName = \(user.lastName!) \nfirstName = \(user.firstName!) \nmiddleName = \(user.middleName!) \nisVerified = \(user.isVerified)" )
    }
    
    
    
    @IBAction func btnSignIn(_ sender: Any) {
        
        let jsonObject: [String: Any] = [
            "email": email.text!,
            "password": password.text!
        ]
        
        
        let jsonRequest: [String : Any] = requestMain(
            urlStr: ADDRESS + "sign_in/",
            jsonBody: jsonObject
        )
        
        print( jsonRequest )
        
        if let status_auth = jsonRequest[ "status" ]! as? Bool {
            if ( status_auth ) {
                
                var lastName = "", firstName = "", middleName = ""
                var isVerified: Bool = false
                
                if let cnt = jsonRequest[ "last_name" ] as? String {
                    lastName = cnt
                }
                if let cnt = jsonRequest[ "first_name" ] as? String {
                    firstName = cnt
                }
                if let cnt = jsonRequest[ "middle_name" ] as? String {
                    middleName = cnt
                }
                if let cnt = jsonRequest[ "is_verificated" ] as? Bool {
                    isVerified = cnt
                }

                let user: UserModel = UserModel( email: email.text!,
                                                 isVerified: isVerified,
                                                 lastName: lastName,
                                                 firstName: firstName,
                                                 middleName: middleName,
                                                 studentsGroup: [] )
                
                UserSettings.userModel = user
                
                printUserModel(user: UserSettings.userModel)
                
                
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

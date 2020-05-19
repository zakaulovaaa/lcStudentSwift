import UIKit


class SignIn: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var warning: UITextView!
    @IBOutlet weak var warningLC: NSLayoutConstraint!
    
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
    
    //чекер для вывода
    func printUserModel(user: UserModel) {
        print( "\n\n\nemail = \(user.email) \nlastName = \(user.lastName!) \nfirstName = \(user.firstName!) \nmiddleName = \(user.middleName!) \nisVerified = \(user.isVerified)" )
        
        if ( user.studentsGroup != nil) {
            print(type(of: user.studentsGroup!))
            for group in user.studentsGroup! {
                print(group.name, group.degreeProgram, group.faculty, group.idZK1C)
            }
        }
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
        if let status_auth = jsonRequest[ "status" ]! as? Bool {
            if ( status_auth ) {
                
                var lastName = "", firstName = "", middleName = ""
                var isVerified: Bool = false
                var groups: [ Group ] = []
                
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
                if let cnt = jsonRequest[ "students" ] as? [ [String:String] ] {
                    
                    for i in 0 ..< cnt.count {
                        
                        groups.append(
                            Group(
                                name: cnt[ i ][ "group_name" ]!,
                                id: cnt[ i ][ "id_ZK_1C" ]!,
                                degreeProgram: cnt[ i ][ "degree_program" ]!,
                                faculty: cnt[ i ][ "faculty_name" ]!
                            )
                        )
                    }
                }
                let user: UserModel = UserModel( email: email.text!,
                                                 isVerified: isVerified,
                                                 lastName: lastName,
                                                 firstName: firstName,
                                                 middleName: middleName,
                                                 studentsGroup: groups )
                
                UserSettings.userModel = user
                printUserModel(user: UserSettings.userModel)
                performSegue( withIdentifier: "signInGoMenu", sender: nil )
            } else {
                if let message = jsonRequest[ "comment" ] as? String {
                    warning.text = message
                    warningLC.constant = self.warning.contentSize.height
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

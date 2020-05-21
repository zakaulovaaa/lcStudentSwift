import UIKit


class SignIn: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var warning: UITextView!
    @IBOutlet weak var warningLC: NSLayoutConstraint!
    @IBOutlet weak var btnSignIn: UIButton!
    @IBOutlet weak var btnToRegistration: UIButton!
    @IBOutlet weak var btnToRecoverThePassword: UIButton!
    
    @IBOutlet var viewSignIn: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //наводим красоту
        //кнопочки хотят быть красивыми
        btnSignIn.setTitleColor(ButtonAppearance.textColor, for: .normal)
        btnToRegistration.setTitleColor(ButtonAppearance.textColor, for: .normal)
        btnToRecoverThePassword.setTitleColor(ButtonAppearance.textColor, for: .normal)
        //вьюшечка тоже хочет быть красивой
        viewSignIn.backgroundColor = ViewAppearance.backgroundColor
        //textField'ы хотят быть вообще самые красивые
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
        
        password.backgroundColor = TextFieldAppearance.backgroundColor
        password.borderStyle = .none
        password.layer.masksToBounds = false
        password.layer.cornerRadius = 5.0;
        password.layer.borderColor = UIColor.clear.cgColor
        password.layer.shadowColor = TextFieldAppearance.shadowOpacityColor.cgColor
        password.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        password.layer.shadowOpacity = 0.6
        password.layer.shadowRadius = 5.0
        password.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: email.frame.height))
        password.leftViewMode = .always
    
        
        email.delegate = self
        password.delegate = self
    }
    
    /*
     * TODO: ДАША НЕ ЗАБУДЬ ПОМЕНЯТЬ
     */
    
    let ADDRESS: String = "http://192.168.1.185:8000/" // ДЛЯ ДИМЫ
    
 //   let ADDRESS: String = "http://localhost:8000/" //ДЛЯ ДАШИ
    
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

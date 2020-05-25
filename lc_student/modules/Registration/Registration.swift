import UIKit

class Registration: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //наводим красоту
        viewRegistration.backgroundColor = ViewAppearance.backgroundColor
        btnRegistration.setTitleColor(ButtonAppearance.textColor, for: .normal)
        
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
        
        password1.backgroundColor = TextFieldAppearance.backgroundColor
        password1.borderStyle = .none
        password1.layer.masksToBounds = false
        password1.layer.cornerRadius = 5.0;
        password1.layer.borderColor = UIColor.clear.cgColor
        password1.layer.shadowColor = TextFieldAppearance.shadowOpacityColor.cgColor
        password1.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        password1.layer.shadowOpacity = 0.6
        password1.layer.shadowRadius = 4.0
        password1.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: email.frame.height))
        password1.leftViewMode = .always
        
        password2.backgroundColor = TextFieldAppearance.backgroundColor
        password2.borderStyle = .none
        password2.layer.masksToBounds = false
        password2.layer.cornerRadius = 5.0;
        password2.layer.borderColor = UIColor.clear.cgColor
        password2.layer.shadowColor = TextFieldAppearance.shadowOpacityColor.cgColor
        password2.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        password2.layer.shadowOpacity = 0.6
        password2.layer.shadowRadius = 4.0
        password2.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: email.frame.height))
        password2.leftViewMode = .always
    }
    
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password1: UITextField!
    @IBOutlet weak var password2: UITextField!
    @IBOutlet weak var warning: UITextView!
    @IBOutlet weak var warningLC: NSLayoutConstraint!
    @IBOutlet var viewRegistration: UIView!
    @IBOutlet weak var btnRegistration: UIButton!
    
    //возвращаемся на предыдущую страницу
    @IBAction func toSignIn(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func register(_ sender: UIButton) {
        
        //будет проверять на наличие ошибок
        var check = true
        var message = ""
        
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate( format:"SELF MATCHES %@", emailRegEx )
        
        if ( !emailPred.evaluate( with: self.email.text! ) ) {
            message += "Вместо почты ты ввел дичь"
            check = false
        }
        
        if ( password1.text!.count < 5 ) {
            message += "\nПароль должен состоять не менее, \nчем из 5 символов"
            check = false
        }
        if ( password1.text! != password2.text! ) {
            message += "\nВведенные пароли не совпадают"
            check = false
        }
        
        
        //если ошибок не обнаружено
        if ( check ) {
            //собираем json
            let jsonObject: [ String: Any ] = [
                "email": email.text!,
                "password": password1.text!
            ]
            //делаем запрос
            let jsonRequest: [ String: Any ] = requestMain(
                urlStr: "http://localhost:8000/registration/",
                jsonBody: jsonObject
            )
            if let status = jsonRequest[ "status" ] as? Bool {
                if ( !status ) {
                    //выводим ошибки
                    if let message = jsonRequest[ "comment" ] as? String {
                        warning.text = message
                    }
                } else {
                    let user: UserModel = UserModel( email: email.text!,
                                                     isVerified: false,
                                                     lastName: "",
                                                     firstName: "",
                                                     middleName: "",
                                                     studentsGroup: [] )
                    
                    UserSettings.userModel = user
                    performSegue( withIdentifier: "registerGoMenu", sender: nil )
                }
            }
        }
        
        if (message == self.warning.text!) {
            
        } else {
            self.warning.text = message
            self.warningLC.constant = self.warning.contentSize.height + 15.0
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

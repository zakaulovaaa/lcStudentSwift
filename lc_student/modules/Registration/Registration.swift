import UIKit

class Registration: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    @IBOutlet weak var email: UITextField!
    
    @IBOutlet weak var password1: UITextField!
    
    @IBOutlet weak var password2: UITextField!
    
    @IBOutlet weak var warning: UITextView!
    
    @IBAction func goLogin(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    
    
    @IBAction func register(_ sender: UIButton) {
        
        warning.text = ""
        
        var check = true
        
        if ( password1.text!.count < 5 ) {
            warning.text += "Пароль должен состоять не менее, \nчем из 5 символов"
            check = false
        }
        if ( password1.text! != password2.text! ) {
            warning.text += "\nВведенные пароли не совпадают"
            check = false
        }
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        if ( !emailPred.evaluate( with: email.text! ) ) {
            warning.text += "\nВместо почты ты ввел дичь"
            check = false
        }
        
        if ( check ) {
            
            let jsonObject: [String: Any] = [
                "email": email.text!,
                "password": password1.text!
            ]
            
            let jsonRequest: [String: Any] = requestMain(
                urlStr: "http://localhost:8000/registration/",
                jsonBody: jsonObject
            )
            
            if let status = jsonRequest[ "status" ] as? Bool {
                if ( !status ) {
                    if let message = jsonRequest[ "comment" ] as? String {
                        warning.text = message
                    }
                } else {
                    performSegue( withIdentifier: "registerGoMenu", sender: nil )
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

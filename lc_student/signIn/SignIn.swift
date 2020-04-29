import UIKit


class SignIn: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    
    @IBAction func btnSignIn(_ sender: Any) {
        
        let jsonObject: [String: Any] = [
            "email": email.text!,
            "password": password.text!
        ]
        var json_request: [String : Any] = [:]
        
        requestMain(urlStr: "http://localhost:8000/sign_in/",
                    jsonBody: jsonObject,
                    finished: { answer in
                        json_request = answer
                    }
        )
        
        if let status_auth = json_request[ "status" ]! as? Bool {
            if ( status_auth ) {
                let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let newViewController = storyboard.instantiateViewController(withIdentifier: "Menu") as! Menu
                newViewController.modalPresentationStyle = .overFullScreen
                self.present(newViewController, animated: true, completion: nil)
            }
        }
    }
        
    @IBAction func btnRegietration(_ sender: UIButton) {
        
        let storyboard: UIStoryboard = UIStoryboard( name: "Main", bundle: nil )
        
        let newViewController = storyboard.instantiateViewController(withIdentifier: "Registration") as! Registration
        
        newViewController.modalPresentationStyle = .overFullScreen
        self.present( newViewController, animated: true, completion: nil )
        
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






/*
 

 
 
 */

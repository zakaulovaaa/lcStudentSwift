//
//  SignIn.swift
//  lc_student
//
//  Created by Дарья Закаулова on 19.04.2020.
//  Copyright © 2020 Дарья Закаулова. All rights reserved.
//

import UIKit

class SignIn: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    
    @IBAction func btnSignIn(_ sender: Any) {
        
        guard let url = URL(string: "http://localhost:8000/sign_in/") else { return }
        var isSignIn = false;
        
        let jsonObject: [String: Any] = [
            "email": email.text!,
            "password": password.text!
        ]
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        guard let httpBody = try? JSONSerialization.data(withJSONObject: jsonObject, options: []) else { return }
        request.httpBody = httpBody
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            if let response = response {
                print(response)
            }
            
            guard let data = data else { return }
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: [])
//                self.navigationController.pushViewController(GoToTheMenu, animated: true)
                if let dict = json as? [String: Any] {
                    let q = dict["status"]! as? Bool;
                    print( q! )
                    if ( q! ) {
                        isSignIn = true;
                    }
//                    print(dict)
//                    print(dict["status"]!)
                }
            } catch {
                print(error)
            }
            
        }.resume()
        
        print("is sign in = ")
        print(isSignIn)
        if ( isSignIn ) {
            let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let newViewController = storyboard.instantiateViewController(withIdentifier: "Menu") as! Menu
            newViewController.modalPresentationStyle = .overFullScreen
            self.present(newViewController, animated: true, completion: nil)
        }
        
        /*
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyboard.instantiateViewController(withIdentifier: "Menu") as! Menu
        newViewController.modalPresentationStyle = .overFullScreen
        self.present(newViewController, animated: true, completion: nil)
        */
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

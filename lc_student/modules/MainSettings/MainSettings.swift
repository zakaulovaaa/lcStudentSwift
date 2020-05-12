//
//  MainSettings.swift
//  lc_student
//
//  Created by Дарья Закаулова on 08.05.2020.
//  Copyright © 2020 Дарья Закаулова. All rights reserved.
//

import UIKit

//класс пунктов меню
final class SettingsItems: NSObject { 
    var name: String
    
    init( name: String ) {
        self.name = name
        super.init()
    }
}

//объявляем ВСЕ пункты, которые могут отображаться
let settingsItems = [ SettingsItems( name: "Сменить пароль" ),
                      SettingsItems( name: "Выйти" )
                    ]


class MainSettings: UITableViewController {
    
    var items: [SettingsItems] = settingsItems

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //переход в меню
    @IBAction func toMenu(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    //отрисовка пунктов меню
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SettingsCell", for: indexPath)

        let item = items[indexPath.row] as SettingsItems
        cell.textLabel?.text = item.name

        return cell
    }
    
    //обработка клика на пункт меню
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let action = self.items[ indexPath.row ].name
        
        //обработка выхода из аккаунта
        if (action == "Выйти") {
            UserSettings.userModel = nil
            DispatchQueue.main.async(execute: {
                let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                
                let newViewController = storyboard.instantiateViewController(withIdentifier: "FirstWindow") as! FirstWindow
                newViewController.modalPresentationStyle = .overFullScreen
                self.present(newViewController, animated: false, completion: nil)
                
            })
        }
        
        
        if (action == "Сменить пароль") {
            performSegue( withIdentifier: "ToChangePassword", sender: nil )
        }
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

//
//  GroupPersonalCard.swift
//  lc_student
//
//  Created by Дарья Закаулова on 14.05.2020.
//  Copyright © 2020 Дарья Закаулова. All rights reserved.
//

import UIKit

class GroupPersonalCard: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    //переход назад
    @IBAction func toPersonalCard(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    //получаем список групп текущего пользователя
    let groups: [ Group ] = UserSettings.userModel.studentsGroup ?? []
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groups.count
    }
    //отрисовываем ячейки
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellGroup", for: indexPath)
        let group: Group = groups[ indexPath.row ]
        cell.textLabel?.text = group.name
        return cell
    }
    
    //обработка нажатия на ячейку
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let action = self.groups[ indexPath.row ].name
            
        let cntGroup = UserSettings.userModel.studentsGroup?.filter( {($0.name == action)} )
            
        
        let message = "\n\(cntGroup?[ 0 ].degreeProgram ?? "") \n\n\(cntGroup?[ 0 ].faculty ?? "")"
        
        let alert = UIAlertController(title: "", message: "", preferredStyle: .alert)
        let titleAttributes = [NSAttributedString.Key.font: UIFont(name: "HelveticaNeue", size: 24)!, NSAttributedString.Key.foregroundColor: UIColor.black]
        
        let titleString = NSAttributedString(string: action, attributes: titleAttributes)
        let messageAttributes = [NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-Light", size: 16)!, NSAttributedString.Key.foregroundColor: UIColor.darkGray]
        let messageString = NSAttributedString(string: message, attributes: messageAttributes)
        alert.setValue(titleString, forKey: "attributedTitle")
        alert.setValue(messageString, forKey: "attributedMessage")
        
        alert.addAction(UIAlertAction(title: "понял-принял",
                                      style: .default,
                                      handler: nil ))
        self.present(alert, animated: true)
            
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

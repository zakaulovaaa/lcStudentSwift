//
//  PersonalCard.swift
//  lc_student
//
//  Created by Дарья Закаулова on 14.05.2020.
//  Copyright © 2020 Дарья Закаулова. All rights reserved.
//

import UIKit

final class PersonalCardItems: NSObject {
    var name, data: String
    init( name: String, data: String ) {
        self.name = name
        self.data = data
        super.init()
    }
}

func getItemsData() -> [ PersonalCardItems ] {
    let user = UserSettings.userModel
    var answer: [ PersonalCardItems ] =
    [
        PersonalCardItems(name: "email", data: user?.email ?? "упс, проблемы"),
        PersonalCardItems(name: "Фамилия", data: (user?.lastName)!),
        PersonalCardItems(name: "Имя", data: (user?.firstName)!),
        PersonalCardItems(name: "Отчество", data: (user?.middleName)!)
    ]
    let groups: [ Groups ] = UserSettings.userModel.studentsGroup ?? []
    
    for group in groups {
        answer.append( PersonalCardItems(name: "Учебная группа", data: group.name) )
    }
    
    return answer
}


class PersonalCard: UITableViewController {

    let items: [PersonalCardItems] = getItemsData();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.rowHeight = 100.0
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return items.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellPersonalCard", for: indexPath)
        
        if let nameLabel = cell.viewWithTag(100) as? UILabel {
            nameLabel.text = items[ indexPath.row ].name
        }
        
        if let dataLabel = cell.viewWithTag(101) as? UILabel {
            dataLabel.text = items[ indexPath.row ].data
        }
        return cell
    }
    
    @IBAction func toMenu(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            let action = self.items[ indexPath.row ].name
            
        
            if ( action == "Учебная группа" ) {
                let alert = UIAlertController(title: self.items[ indexPath.row ].data,
                                              message: "НЕ ТЫКАЙ НА МЕНЯ",
                                              preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "понял-принял",
                                              style: .default,
                                              handler: nil ))
                        
                self.present(alert, animated: true)
            }
            
        }
    
    //ToGroupPersonalCard

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

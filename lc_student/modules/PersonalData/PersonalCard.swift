//
//  PersonalCard.swift
//  lc_student
//
//  Created by Дарья Закаулова on 14.05.2020.
//  Copyright © 2020 Дарья Закаулова. All rights reserved.
//

import UIKit

//класс для описания описания данных для ячейки
final class PersonalCardItems: NSObject {
    var name, data: String
    init( name: String, data: String ) {
        self.name = name
        self.data = data
        super.init()
    }
}

//для создания массива с данными для ячеек
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
    //добавляем в список первую группу
    for group in groups {
        answer.append( PersonalCardItems(name: "Учебная группа", data: group.name) )
        break
    }
    return answer
}

class PersonalCard: UITableViewController {

    let items: [PersonalCardItems] = getItemsData()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.rowHeight = 80.0
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    //отрисовка ячеек
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //группы отрисовываем другим типом ячеек
        if (items[ indexPath.row ].name == "Учебная группа") {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CellPersonalCardGroup", for: indexPath)
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CellPersonalCard", for: indexPath)
            if let nameLabel = cell.viewWithTag(100) as? UILabel {
                nameLabel.text = items[ indexPath.row ].name
            }
            if let dataLabel = cell.viewWithTag(101) as? UILabel {
                dataLabel.text = items[ indexPath.row ].data
            }
            return cell
        }
    }
    
    //обработка нажатия на ячейку
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            let action = self.items[ indexPath.row ].name
            
            if ( action == "Учебная группа" ) {
                let cell = tableView.dequeueReusableCell(withIdentifier: "CellPersonalCardGroup", for: indexPath)
                let groups: [ Groups ] = UserSettings.userModel.studentsGroup ?? []
                if (groups.count > 1) {
                    performSegue(withIdentifier: "toGroupPersonalCard", sender: nil)
                } else {
                    var data: String = ""
                    if let dataLabel = cell.viewWithTag(101) as? UILabel {
                        data = dataLabel.text!
                    }
                    let alert = UIAlertController(title: data,
                                                  message: "Я ТУТ ОДНА",
                                                  preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "понял-принял",
                                                  style: .default,
                                                  handler: nil ))
                    self.present(alert, animated: true)
                }
            }
    }
    
    @IBAction func toMenu(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
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

import UIKit

final class MenuItems: NSObject {
    var name: String
    
    init( name: String ) {
        self.name = name
        
        super.init()
    }
    
}

let menuItems = [ MenuItems(name: "Верификация"),           //Только не верифицированным
                  MenuItems(name: "Личная карточка"),       //только верифицированным
                  MenuItems(name: "Объявления"),            //только верифицированным
                  MenuItems(name: "Расписание"),            //всем (убрать)
                  MenuItems(name: "Деканат"),               //только верифицированным
                  MenuItems(name: "Домашние задания"),      //только верифицированным
                  MenuItems(name: "Посещаемость"),          //только верифицированным
                  MenuItems(name: "Настройки")              //всем
                ]

class MenuTable: UITableViewController {
    
    var items: [MenuItems] = menuItems

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }


    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuCell", for: indexPath)
        
        let item = items[indexPath.row] as MenuItems
        cell.textLabel?.text = item.name

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let action = self.items[ indexPath.row ].name
        
        if (action == "Настройки") {
            performSegue( withIdentifier: "MenuToSettings", sender: nil )
            
        }
        if (action == "Верификация") {
            performSegue(withIdentifier: "ToVerification", sender: nil)
        }
        
//        print( self.items[indexPath.row].name )
//        print(self.[indexPath.row])
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

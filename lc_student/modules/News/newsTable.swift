//
//  newsTable.swift
//  lc_student
//
//  Created by Дарья Закаулова on 24.05.2020.
//  Copyright © 2020 Дарья Закаулова. All rights reserved.
//

import UIKit

//потом для фильтра понадобится
class requestParameters {
    var type, year, month, tag: String
    var currentPage: Int
    
    init(type: String, year: String, month: String, tag: String, currentPage: Int) {
        self.type = type
        self.year = year
        self.month = month
        self.tag = tag
        self.currentPage = currentPage
    }
}

class newsTable: UITableViewController {
    
    //изначально массив новостей пустой
    var newsItems: [News] = []
    var numPage = 1, totalPage = 1
    
//    let ADDRESS: String = "http://192.168.1.185:8000/" // ДЛЯ ДИМЫ
    let ADDRESS: String = "http://localhost:8000/" //ДЛЯ ДАШИ
    
    //тело запроса
    var jsonObject: [ String: Any ] = [
        "type": "default",
        "year": "all",
        "month": "all",
        "tag": "all"
    ]
    
    //проверять не обновляемся ли мы сейчас
    var fetchingMore = false
    
    //получаем картинку по ссылке
    func getImg(link: String) -> UIImage? {
        let url = URL(string: link)
        if let data = try? Data(contentsOf: url!)
        {
            return UIImage(data: data)
        }
        return nil
    }
    
    //добавление новостей в массив с новостями
    //deadline чтоб красивенько вертелся refresh
    @objc func getNews(deadline: Double) {
        //чтоб не пытался отрисовать, пока не заполнил массив с данными
        DispatchQueue.main.asyncAfter(deadline: .now() + deadline, execute: {
            //делаем запрос
            self.jsonObject["current_page"] = self.numPage
            let jsonRequest: [ String: Any ] = requestMain(urlStr: "\(self.ADDRESS)news_module/", jsonBody: self.jsonObject)

            if let status = jsonRequest[ "status" ] as? Bool {
                if ( status ) {
                    if let totalPage_ = Int(jsonRequest["total_pages_amount"] as? String ?? "0") {
                        self.totalPage = totalPage_
                    }
                    if let newsDictionary = jsonRequest[ "news_array" ] as? [String: [String: Any]] {
                        for (_, news) in newsDictionary {
                            //создаем новую новость
                            let newNews = News(
                                title: news["news_title"] as! String,
                                description: news["news_short_text"] as! String,
                                mainImage: self.getImg(link: news["news_main_img"] as! String)!,
                                linkAllImage: news["news_img_gallery"] as! [String],
                                mainText: news["news_main_text"] as! String,
                                datePublish: news["news_pub_date"] as! String,
                                tag: news["news_tag"] as! String
                            )
                            self.newsItems.append( newNews )
                        }
                    }
                }
            }
            //обновляем данные
            self.tableView.reloadData()
            //отключаем вертелку
            self.refreshControl?.endRefreshing()
        })
    }
    
    //функция для обновления (при оттягивании таблички вниз вызывается)
    @objc func updateNews() {
        DispatchQueue.main.async {
            self.numPage = 1
            //очищаем уже имеющиеся данные
            self.newsItems = []
            
            self.getNews( deadline: 1.0 )
        }
    }
    
    @IBOutlet var tableViewNews: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        numPage = 1
        
        getNews(deadline: 0.0)
        
        //наводим красоту
        self.tableViewNews.backgroundColor = ViewAppearance.backgroundColor
        
        //исправляем размер ячеек
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = CGFloat(44.0)
        
        //меняем цвет разделителя
        tableView.separatorColor = .lightGray
        
        //создаем рефреш
        refreshControl = UIRefreshControl()
        refreshControl?.attributedTitle = NSAttributedString(string: "Идет обновление...")
        refreshControl?.addTarget(self, action: #selector(self.updateNews), for: UIControl.Event.valueChanged)
        tableView.addSubview( refreshControl! )
        tableView.tableFooterView?.isHidden = true
        
        //обновляем данные
        tableView.reloadData()
        
        //для подгрузки данных
        let loadingNib = UINib(nibName: "LoadingCell", bundle: nil)
        
    }
    
    func beginFetch() {
        fetchingMore = true
//        print("begin!!!!!!")
        tableView.reloadSections(IndexSet(integer: 1 ), with: .none)
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0, execute: {
            
            self.getNews(deadline: 1.0)
            
//            var newItems: [String] = []
//            for i in self.arr.count...self.arr.count + 12 {
//                newItems.append("\(self.text) \(i)")
//            }
//            self.arr.append( contentsOf: newItems )
            self.fetchingMore = false
//            self.tableView.reloadData()
        })
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
            let offsetY = scrollView.contentOffset.y
            let contentHeight = scrollView.contentSize.height
            if offsetY > contentHeight - scrollView.frame.height {
                
                if (!fetchingMore) {
                    self.numPage += 1
                    if (self.numPage <= self.totalPage) {
                        beginFetch()
                    }
                }
            }
        }
    

    // MARK: - Table view data source

    //тут говорим сколько типов ячеек будет использоваться
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    //размер таблицы
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 {
            return newsItems.count
        } else if section == 1 && fetchingMore {
            return 1
        }
        return 0
    }

    //отрисовываем ячейки
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if (indexPath.section == 0) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "newsCell", for: indexPath)
            
            //наводим красоту
            cell.backgroundColor = ViewAppearance.backgroundColor
            
            if (indexPath.row >= newsItems.count) {
                return cell
            }
            
            //вводим данные
            if let tag = cell.viewWithTag(100) as? UILabel {
                tag.text = newsItems[ indexPath.row ].tag
            }
            if let date = cell.viewWithTag(101) as? UILabel {
                date.text = newsItems[ indexPath.row ].datePublish
            }
            if let title = cell.viewWithTag(155) as? UITextView {
                title.text = newsItems[ indexPath.row ].title
            }
            if let description = cell.viewWithTag(103) as? UITextView {
                description.text = newsItems[ indexPath.row ].description
            }
            if let img = cell.viewWithTag(104) as? UIImageView {
                img.heightAnchor.constraint(equalToConstant: 200.0).isActive = true
                img.image = newsItems[indexPath.row].mainImage
            }

            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "LoadingCell", for: indexPath)
            
            if let spinner = cell.viewWithTag(777) as? UIActivityIndicatorView {
                spinner.startAnimating()
            }
            cell.backgroundColor = ViewAppearance.backgroundColor
            return cell
        }
        
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //чтоб при нажатии светилось и гасло сразу
        tableView.deselectRow(at: indexPath, animated: true)
            
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

//
//  Verification.swift
//  lc_student
//
//  Created by Дмитрий Загузин on 08.05.2020.
//  Copyright © 2020 Дарья Закаулова. All rights reserved.
//

import UIKit

class Verification: UIViewController, UITextFieldDelegate {
    
    let ADDRESS: String = "http://192.168.1.185:8000/" // ДЛЯ ДИМЫ
    
//    let ADDRESS: String = "http://localhost:8000/" //ДЛЯ ДАШИ
    func printUserModel(user: UserModel) {
        print( "\n\n\nemail = \(user.email) \nlastName = \(user.lastName!) \nfirstName = \(user.firstName!) \nmiddleName = \(user.middleName!) \nisVerified = \(user.isVerified)" )
    }

    @IBOutlet weak var dataField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var secondNameField: UITextField!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var middleNameField: UITextField!
    @IBOutlet weak var passportField: UITextField!
    
    
    let datePicker = UIDatePicker()
    override func viewDidLoad() {
        super.viewDidLoad()
        //Заполняем поле с почтой по умолчанию
        emailField.text = UserSettings.userModel.email
        
        //В поле с водом текста присваиваем дата пикер, сразу будет вылазить спинер с датой
        dataField.inputView = datePicker
        //устанавливаем формат спинера
        datePicker.datePickerMode = .date
        //установка языка дат по языку системы
        let localeID = Locale.preferredLanguages.first
        datePicker.locale = Locale(identifier: localeID!)
        
        //делаем тулбар с кнопкой Done для скрытия поля
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneAction))
        //двигаем его вправо
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        //В черную полосу над дата пикером пихаем пространство и кнопку done
        toolbar.setItems([flexSpace, doneButton], animated: true)
        
        //пихаем тулбар на место
        dataField.inputAccessoryView = toolbar
        
        //Изменяем дату в поле при любом изменении
        datePicker.addTarget(self, action: #selector(dateChange), for: .valueChanged)
        
        //Закрываем поле с вводом даты при нажатии на любое место
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapGesutureDone))
        self.view.addGestureRecognizer(tapGesture)
    }
    //Функция которая берет дату с пикера и закрывает коле выбора даты
    @objc func doneAction(){
        getDateFromPicker()
        view.endEditing(true)
    }
    //Функция смены даты (Это для того, чтобы менялась всегда при любом изменении)
    @objc func dateChange() {
        getDateFromPicker()
    }
    //Функция закрытия колеса даты (При нажатии вне поля выбора)
    @objc func tapGesutureDone() {
        view.endEditing(true)
    }
    
    //Привод даты из спинера к нужному формату
    func getDateFromPicker() {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy.MM.dd"
        dataField.text = formatter.string(from: datePicker.date)
    }
   
    
    @IBAction func toMenu(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    //Нажатие кнопки Верификация
    @IBAction func sendToVerification(_ sender: Any) {
        //Я тут сразу инфу поставил, потому что заебался вводить данные по сто тыщ раз
        let jsonObject: [String: Any] = [
            "email":                    emailField.text!,
            
            "surname":                 "Верхозин",
            "name":                    "Илья",
            "middle_name":             "Андреевич",
            "date_of_birth":           "19970621",
            "last_numbers_passport":   "7595"
            
//            "surname":                 secondNameField.text!,
//            "name":                    nameField.text!,
//            "middle_name":             middleNameField.text!,
//            "date_of_birth":           dataField.text!.replacingOccurrences(of: ".", with: ""),
//            "last_numbers_passport":   passportField.text!
            
        ]
        let jsonRequest: [String : Any] = requestMain(
           urlStr: ADDRESS + "verification/",
           jsonBody: jsonObject
        )
        
        //Это для вылезания алерта
        let alert = UIAlertController(title: "Статус верификации", message: "Данные были отправлены", preferredStyle: .alert)
        
        if let status_auth = jsonRequest[ "status" ]! as? Bool {
            if ( status_auth ) {
                //Здесь добавляем отчет в алерте
                alert.addAction(UIAlertAction(title: "Успех!", style: .default, handler: nil))
                var lastName = "", firstName = "", middleName = ""
                
                //Создаем массив в котором будет список групп, принадлежащих юзеру
                var groupArray:[Group] = []
                var isVerified: Bool = false
                
                if let cnt = jsonRequest[ "last_name" ] as? String {
                    lastName = cnt
                }
                if let cnt = jsonRequest[ "first_name" ] as? String {
                    firstName = cnt
                }
                if let cnt = jsonRequest[ "middle_name" ] as? String {
                    middleName = cnt
                }
                if let cnt = jsonRequest[ "is_verificated" ] as? Bool {
                    isVerified = cnt
                }
                
                /**
                 *Так как у нас в студентах лежит массив групп, то
                 *1) Развертываем как массив словарей
                 *2) Вытаскиваем первый элемент
                 *3) Создаем экземпляр класса Group
                 *4) Вставляем в массив групп
                 *5) Удаляем первый элемент
                 *
                 *Скорее всего нельзя изменять элемент так в теле,
                 *но это самое простое и эффективное решение
                */
                if var qq = jsonRequest[ "students" ] as? [[String:Any]] {
                    while (true) {
                        if (qq.count == 0) {
                            break;
                        }
                        let group: Group = Group(name: qq.first?["group_name"] as! String,
                                                 id:  qq.first?["id_ZK_1C"] as! String,
                                                 degreeProgram: qq.first?["degree_program"] as! String,
                                                 faculty: qq.first?["faculty_name"] as! String
                        )
                        groupArray.append(group)
                        qq.remove(at: 0)
                    }
                }
                

                
                
                //UserSettings.userModel.email
                let user: UserModel = UserModel( email: UserSettings.userModel.email,
                                                 isVerified: isVerified,
                                                 lastName: lastName,
                                                 firstName: firstName,
                                                 middleName: middleName,
                                                 studentsGroup: groupArray )
                
                UserSettings.userModel = user
                
                printUserModel(user: UserSettings.userModel)
                
            }
        }
        self.present(alert, animated: true)
        

        
    }
    
}

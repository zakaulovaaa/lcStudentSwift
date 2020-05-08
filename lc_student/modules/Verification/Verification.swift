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
        emailField.text = UserSettings.email
        
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
        let jsonObject: [String: Any] = [
            "email":                    emailField.text!,
            "surname":                  secondNameField.text!,
            "name":                     nameField.text!,
            "middle_name":              middleNameField.text!,
            "date_of_birth":            dataField.text!.replacingOccurrences(of: ".", with: ""),
            "last_numbers_passport":    passportField.text!
        ]
        let jsonRequest: [String : Any] = requestMain(
           urlStr: ADDRESS + "who_is/",
           jsonBody: jsonObject
        )
        //Это для вылезания алерта
        let alert = UIAlertController(title: "Статус верификации", message: "Данные были отправлены", preferredStyle: .alert)
        if let status_auth = jsonRequest[ "status" ]! as? Bool {
            if ( status_auth ) {
                
                alert.addAction(UIAlertAction(title: "Успех!", style: .default, handler: nil))
                
            } else {
                alert.addAction(UIAlertAction(title: "Провал :(", style: .default, handler: nil))
            }
        }
        self.present(alert, animated: true)
        

        
    }
    
}

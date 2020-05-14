//
//  CellPersonalDataGroup.swift
//  lc_student
//
//  Created by Дарья Закаулова on 14.05.2020.
//  Copyright © 2020 Дарья Закаулова. All rights reserved.
//

import UIKit

class CellPersonalDataGroup: UITableViewCell {

    var groups: [ Groups ] = UserSettings.userModel.studentsGroup ?? []
    var timer = Timer()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        //отрисовываем начальное значение ячейки
        decreaseTimer();
        if (groups.count > 1) {
            //добавляем стрелочку
            self.accessoryType = .disclosureIndicator
            //запускаем таймер
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(CellPersonalDataGroup.decreaseTimer), userInfo: nil, repeats: true)
        }
    }
    //функция для отрисочки ячейки
    @objc func decreaseTimer(){
        let cell = self
        if let dataLabel = cell.viewWithTag(101) as? UILabel {
            let date = Date()
            let calendar = Calendar.current
            let seconds = calendar.component(.second, from: date)
            dataLabel.text = ( groups[ seconds % groups.count ].name )
        }
    }
    //это от класса функция
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}

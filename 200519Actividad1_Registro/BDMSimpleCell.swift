//
//  BDMSimpleCell.swift
//  200519Actividad1_Registro
//
//  Created by Victor Hugo Benitez Bosques on 22/05/19.
//  Copyright © 2019 Victor Hugo Benitez Bosques. All rights reserved.
//

import UIKit

protocol BDMSimpleCellDelegate {
    func shareAction()
}
class BDMSimpleCell: UITableViewCell {
    
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblSubtitle: UILabel!
    @IBOutlet weak var lblThird : UILabel!
    @IBOutlet weak var lblFourt : UILabel!
    @IBOutlet weak var btnShare: UIButton!{
        didSet{
            
            btnShare.isHidden = true
        }
    }
    
    
    var objSecurity : DataSecurity?{
        didSet{
            
            guard let obj = objSecurity else { return }
            
            if obj.bCobranza{

                if obj.strSubtitle == "Jefe"{
                    self.backgroundColor = UIColor.blue
                    lblTitle.textColor = UIColor.white
                    lblSubtitle.textColor = UIColor.white
                    lblFourt.textColor = UIColor.white
                }else{
                    btnShare.isHidden = false
                    btnShare.setImage(UIImage(named: "mapa"), for: .normal)
                }
                
               
                lblTitle.text = obj.strTitle
                lblSubtitle.text = obj.strSubtitle
                lblFourt.text = obj.strFourData
                
               
            }else{
                lblTitle.text = obj.strTitle
                lblSubtitle.text = "Fecha Nac: \(obj.strSubtitle ?? "")   Edad: \(calculeAge(strBirthDate: obj.strSubtitle) ?? 0)"
                lblThird.text = obj.strThirdData
                lblFourt.text = obj.strFourData
                
            }
           
            
            
        }
    }
    
    var delegate : BDMSimpleCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    @IBAction func btnShare(_ sender: UIButton) {
        
        delegate?.shareAction()
        
    }
    
    func calculeAge( strBirthDate : String?) -> Int?{
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyy"
        let now = Date()
        let calendar = Calendar.current

        
        if let birth = strBirthDate, let dateBirth = dateFormatter.date(from: birth ){
            
            
            btnShare.isHidden = !checkBirth(dteBorth: dateBirth)
            
            let age = calendar.dateComponents([.year], from: dateBirth, to: now)
            return age.year
        }
        
        return nil

    }
    
    func checkBirth( dteBorth : Date) -> Bool{
        
        if getWeekdayORMonth(dte: Date(), bWeekday: false) == getWeekdayORMonth(dte: dteBorth, bWeekday: false){
            
            if let semanaHoy = getWeekdayORMonth(dte: Date(), bWeekday: true), let semanaCumple = getWeekdayORMonth(dte: dteBorth, bWeekday: true) {
                
                return semanaHoy == semanaCumple
            }
            
            
        }
        
        return false
        
        
    }
    
    func getWeekdayORMonth(dte : Date, bWeekday : Bool)-> Int?{
        let calendar = Calendar.current
        if bWeekday{
            return calendar.dateComponents([.weekday, .day, .weekOfMonth], from: dte).weekOfMonth
        }else{
            return calendar.dateComponents([.month], from: dte).month

        }
    }
    
    
}

extension Date {
    static func -(recent: Date, previous: Date) -> (month: Int?, day: Int?, hour: Int?, minute: Int?, second: Int?) {
        let day = Calendar.current.dateComponents([.day], from: previous, to: recent).day
        let month = Calendar.current.dateComponents([.month], from: previous, to: recent).month
        let hour = Calendar.current.dateComponents([.hour], from: previous, to: recent).hour
        let minute = Calendar.current.dateComponents([.minute], from: previous, to: recent).minute
        let second = Calendar.current.dateComponents([.second], from: previous, to: recent).second
        
        return (month: month, day: day, hour: hour, minute: minute, second: second)
    }
    
}

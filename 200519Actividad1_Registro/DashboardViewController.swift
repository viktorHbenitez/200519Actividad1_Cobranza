//
//  DashboardViewController.swift
//  200519Actividad1_Registro
//
//  Created by Victor Hugo Benitez Bosques on 20/05/19.
//  Copyright © 2019 Victor Hugo Benitez Bosques. All rights reserved.
//

import UIKit

class DashboardViewController: UIViewController {

    var arrEmployees : [User]?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationController?.setNavigationBarHidden(true,  animated: true)
        
    
        
    }
    
    
    

    @IBAction func btnEmplyeeAction(_ sender: UIButton) {
        performSegue(withIdentifier: "employee", sender: nil)
    }
    
    
    @IBAction func btnCrobanzaAction(_ sender: UIButton) {
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationVC = segue.destination as? EmployeViewController{
            destinationVC.arrEmployees = arrEmployees
            
        }
    }
}



struct DataSecurity {
    var strTitle : String?
    var strSubtitle : String?
    var imgCustom : UIImage?
    
    init(strTitle : String?, strSubtitle : String? , imgCustom : UIImage? = nil) {
        
        if let strTitle = strTitle{
            self.strTitle = strTitle
            
        }
        if let strSubtitle = strSubtitle{
            self.strSubtitle = strSubtitle
            
        }
        if let imgSend = imgCustom{
            self.imgCustom = imgSend
            
        }
    }
}


class BDMSimpleCell: UITableViewCell {
    
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblSubtitle: UILabel!
    
    @IBOutlet weak var imgGeneric: UIImageView!
    
    @IBOutlet weak var cnLyWidthImg: NSLayoutConstraint!
    var objSecurity : DataSecurity?{
        didSet{
            
            guard let obj = objSecurity else { return }
            
            lblTitle.text = obj.strTitle
            lblSubtitle.text = obj.strSubtitle
            
            if let img = obj.imgCustom{
                imgGeneric.image = img
                cnLyWidthImg.constant = 25
                self.updateConstraintsIfNeeded()
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
}



class STConfigurationSecurityTableVC: UIViewController {
    
    @IBOutlet weak var tblTableView : UITableView!{
        didSet{
            tblTableView.delegate = self
            tblTableView.dataSource = self
            tblTableView.separatorStyle = .none
            tblTableView.showsVerticalScrollIndicator = false
            tblTableView.showsHorizontalScrollIndicator = false
        }
    }
    
    var arrElements : [DataSecurity]?{
        didSet{
            tblTableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.title = "Title"
        
    }
    
    private func setupTableView(){
        
        tblTableView.tableFooterView = UIView()
        
        tblTableView.register(UINib(nibName: "SimpleCell", bundle: nil), forCellReuseIdentifier: "SimpleCell")
       
        
        
    }
    
    internal func selectedElement( indexPath : IndexPath){
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        selectedElement(indexPath: indexPath)
    }
    
}

extension STConfigurationSecurityTableVC : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrElements?.count ?? 0
        
    }
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0{
            guard let objet  = arrElements?[indexPath.row] else { return UITableViewCell() }
            
            if let cell = tableView.dequeueReusableCell(withIdentifier: "SimpleCell", for: indexPath) as? BDMSimpleCell{
                
                cell.objSecurity = objet
                
                return cell
                
            }
        }
        
        return UITableViewCell()
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
        
    }
    
    
    
    
}

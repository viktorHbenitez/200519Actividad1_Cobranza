//
//  DashboardViewController.swift
//  200519Actividad1_Registro
//
//  Created by Victor Hugo Benitez Bosques on 20/05/19.
//  Copyright © 2019 Victor Hugo Benitez Bosques. All rights reserved.
//

import UIKit

class DashboardViewController: UIViewController {

    var arrEmployees : [Empleado]?
    var empleadoSElected = Empleado()
    
    @IBOutlet weak var lblWelcome: UILabel!
    @IBOutlet weak var btnlogout: UIButton!{
        didSet{
            btnlogout.isHidden = false
        }
    }
    @IBOutlet weak var btnEdit: UIButton!{
        didSet{
            btnEdit.isHidden = false
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        lblWelcome.text = "Bienvenido \(empleadoSElected.fullName ?? "")"
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true,  animated: true)

    }
    
   
    
    
    @IBAction func btnEditAction(_ sender: UIButton) {
        performSegue(withIdentifier: "edit", sender: nil)
        
        
    }
    

    @IBAction func btnEmplyeeAction(_ sender: UIButton) {
        performSegue(withIdentifier: "employee", sender: nil)
    }
    
    
    @IBAction func btnCrobanzaAction(_ sender: UIButton) {
        performSegue(withIdentifier: "cobranza", sender: nil)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationVC = segue.destination as? EmployeViewController{
            destinationVC.arrEmployees = arrEmployees
            
        }
        if let destinationVC = segue.destination as? CobranzaViewController{
//            destinationVC.arrUser = arrEmployees
        }
        
        if let destinationVC = segue.destination as? RegisterViewController{
            destinationVC.bEditer = true
            destinationVC.empleado = empleadoSElected
        }
    }
    
    @IBAction func btnLogout(_ sender: UIButton) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
}

struct DataSecurity {
    var strTitle : String?
    var strSubtitle : String?
    var strThirdData: String?
    var strFourData : String?
    var bCobranza : Bool
    
    var imgCustom : UIImage?
    
    init(strTitle : String?, strSubtitle : String? , strThird : String?, strFourData : String?,  imgCustom : UIImage? = nil, bCobranza : Bool = false) {
        
        if let strTitle = strTitle{
            self.strTitle = strTitle
            
        }
        if let strSubtitle = strSubtitle{
            self.strSubtitle = strSubtitle
            
        }
        if let data = strThird{
            self.strThirdData = data
        }
        
        if let data = strFourData{
            self.strFourData = data
        }
        
        if let imgSend = imgCustom{
            self.imgCustom = imgSend
            
        }
        self.bCobranza = bCobranza
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
    
    func btnShareAction(){}

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
                cell.delegate = self
                
                return cell
                
            }
        }
        
        return UITableViewCell()
        
    }
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
        
    }
    
    
    
}

extension STConfigurationSecurityTableVC : BDMSimpleCellDelegate{
    func shareAction() {
        btnShareAction()
    }
    
    
}

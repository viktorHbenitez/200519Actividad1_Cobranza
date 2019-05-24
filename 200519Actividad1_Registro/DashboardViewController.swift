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
    
    @IBOutlet weak var btnlogout: UIButton!{
        didSet{
            btnlogout.isHidden = false
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        arrEmployees = [User]()
        // Do any additional setup after loading the view.
        self.addUser(name: "viktor", email: "Viktor@hotmail.com", contraseña: "12345", fechaNacimiento: "20/01/1945", telefono: "1234565", numEmpleado: "11", strAddress: "Montes Urales 470, Lomas - Virreyes, Lomas de Chapultepec, 11000 Ciudad de México", strCompany: "Oracle", job : BDMJobStatus.jefe, latitud: 19.442380, longitud: -99.144119)
        self.addUser(name: "Eduardo", email: "eduardo@hotmail.com", contraseña: "12345", fechaNacimiento: "20/05/1987", telefono: "1234565", numEmpleado: "1", strAddress: "Villa panamerica 11525", strCompany: "Red Hat Mexico", job: .usuario, latitud: 19.443604, longitud: -99.133143)
        self.addUser(name: "Maco", email: "maco@hotmail.com", contraseña: "333", fechaNacimiento: "20/05/1987", telefono: "1234565", numEmpleado: "1", strAddress: "Miguel Hidalgo 11525", strCompany: "Red Hat Mexico", job: .usuario, latitud: 19.435372, longitud: -99.148338)
        
        self.addUser(name: "hugo", email: "hugo@hotmail.com", contraseña: "12345", fechaNacimiento: "20/05/1992", telefono: "1234565", numEmpleado: "22", strAddress: "Calle Río Lerma 232, Cuauhtémoc, 06500 Ciudad de México", strCompany: "Red Hat Mexico", job : BDMJobStatus.jefe, latitud: 19.424672, longitud: -99.160985)
        self.addUser(name: "Manuel", email: "manuel@hotmail.com", contraseña: "111111", fechaNacimiento: "20/05/1987", telefono: "1234565", numEmpleado: "2", strAddress: "Villa panamerica 11525", strCompany: "Red Hat Mexico", job: .usuario, latitud: 19.441432, longitud: -99.159807)
        self.addUser(name: "Benito", email: "benito@hotmail.com", contraseña: "111111", fechaNacimiento: "20/05/1987", telefono: "1234565", numEmpleado: "2", strAddress: "Villa panamerica 11525", strCompany: "Red Hat Mexico", job: .usuario, latitud: 19.424672, longitud: -99.160985)
        
        // 19.442380, -99.144119
        // 19.443604, -99.133143
        // 19.435372, -99.148338
        // 19.441432, -99.159807
        // 19.424672, -99.160985
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true,  animated: true)

    }
    
    func addUser(name : String, email : String, contraseña : String, fechaNacimiento : String?, telefono : String, numEmpleado : String, strAddress : String? = nil , strCompany : String? = nil, job : BDMJobStatus, latitud : Double, longitud : Double){
        let dummyUser = User(name: name, email: email, contraseña: contraseña, numeroEmpledo: numEmpleado, fechaNacimiento: fechaNacimiento ?? "", telefono: telefono, strAddress: strAddress, strCompany: strCompany, job: job, latitud: latitud, longitud : longitud)
        
        arrEmployees?.append(dummyUser)
        
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
            destinationVC.arrUser = arrEmployees
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

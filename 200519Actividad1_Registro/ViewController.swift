//
//  ViewController.swift
//  200519Actividad1_Registro
//
//  Created by Victor Hugo Benitez Bosques on 20/05/19.
//  Copyright © 2019 Victor Hugo Benitez Bosques. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var txfUserLogin: UITextField!{
        didSet{
            txfUserLogin.delegate = self
        }
    }
    
    @IBOutlet weak var txfDrossapLogin: UITextField!{
        didSet{
            txfDrossapLogin.delegate = self
        }
    }
    var dummyUser : User?
    
    var arrUser : [User]?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        arrUser = [User]()
        
        self.addUser(name: "viktor", email: "Viktor@hotmail.com", contraseña: "12345", fechaNacimiento: "nose", telefono: "1234565", numEmpleado: "111111")
        self.addUser(name: "hugo", email: "hugo@hotmail.com", contraseña: "111111", fechaNacimiento: "nose", telefono: "1234565", numEmpleado: "111111")
        

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        txfUserLogin.text = ""
        txfDrossapLogin.text = ""
        
    }
    
    func addUser(name : String, email : String, contraseña : String, fechaNacimiento : String?, telefono : String, numEmpleado : String){
        let dummyUser = User(name: name, email: email, contraseña: contraseña, numeroEmpledo: numEmpleado, fechaNacimiento: fechaNacimiento ?? "", telefono: telefono)
        
        arrUser?.append(dummyUser)
        
    }

    
    
    var strDrossap : String?
    var strUserLogin : String?
    var bFoundUser = false
    @IBAction func btnLogin(_ sender: UIButton) {
        
        bFoundUser = false
        
        for user in arrUser!{
            if !bFoundUser{
                if user.strDrossap == strDrossap && (user.strEmail == strUserLogin || user.strName == strUserLogin){
                    bFoundUser = true
                }
            }
        }
        
        if bFoundUser {
            performSegue(withIdentifier: "dashboard", sender: nil)

        }else{
            let alert = UIAlertController(title: "Actividad 1", message: "El usario no se encuentra registrado, favor de verificar sus credenciales", preferredStyle: .alert)
            
            let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
            
            alert.addAction(ok)
            
            self.present(alert, animated: true, completion: nil)
        }
        
    }
    
    func addAlert(strTitle : String?, strMessage : String?, bSuccess : Bool = false){
        let alert = UIAlertController(title: strTitle, message: strMessage, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default, handler: { (_) in
            
            if bSuccess{
                print("HOla hola")
                
            }
        })
        alert.addAction(ok)
        self.present(alert, animated: true, completion: nil)
    }
    
    var strUserForgot : String?
    @IBAction func btnForgotDrossap(_ sender: UIButton) {
        
        //1. Create the alert controller.
        let alert = UIAlertController(title: "Actividad 1", message: "Enter a text", preferredStyle: .alert)
        
        //2. Add the text field. You can configure it however you need.
        alert.addTextField(configurationHandler: { (textField) -> Void in
            textField.text = ""
        })
        
        //3. Grab the value from the text field, and print it when the user clicks OK.
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (action) -> Void in
            if let textField = alert?.textFields?.first{
                
                // validate name and email
                self.strUserForgot = textField.text
                if self.validateUser(strUser: self.strUserForgot ?? ""){
                    print("Usuario registrado", self.strUserForgot ?? "")
                }else{
                    print("usuario no registrado", self.strUserForgot ?? "")
                    self.addAlert(strTitle: "Actividad 1", strMessage: "El usuario \(self.strUserForgot ?? "") no se encuentra registrado")
                }
            }
        }))
        
        // 4. Present the alert.
        self.present(alert, animated: true, completion: nil)
    }
    
    func  validateUser(strUser : String) -> Bool{
        for user in arrUser!{
            if !bFoundUser{
                if (user.strEmail == strUser || user.strName == strUser){
                    return true
                }
            }
        }
        return false
    }
    
    @IBAction func btnSingUp(_ sender: UIButton) {
        
        performSegue(withIdentifier: "registro", sender: nil)
        
    }
    var userRegister : User?
    @IBAction func unwindToThisViewController(segue: UIStoryboardSegue) {
        
        arrUser = nil
        if let sourceViewController = segue.source as? RegisterViewController {
            userRegister = sourceViewController.userRegister
            
            arrUser = [User]()
            createDummyData()
            
            self.addUser(name: userRegister?.strName ?? "", email: userRegister?.strEmail ?? "", contraseña: userRegister?.strDrossap ?? "", fechaNacimiento: "", telefono: userRegister?.strPhone ?? "", numEmpleado: userRegister?.strNumEmployee ?? "")
        }
        
    }
    
    
    func createDummyData(){
        self.addUser(name: "viktor", email: "Viktor@hotmail.com", contraseña: "12345", fechaNacimiento: "nose", telefono: "1234565", numEmpleado: "111111")
        self.addUser(name: "hugo", email: "hugo@hotmail.com", contraseña: "111111", fechaNacimiento: "nose", telefono: "1234565", numEmpleado: "111111")
        
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinanationVC = segue.destination as? DashboardViewController{
            destinanationVC.arrEmployees = arrUser
        }
    }
}

extension ViewController : UITextFieldDelegate{
    
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if textField == txfDrossapLogin{
            strDrossap = txfDrossapLogin.text
        }
        if textField == txfUserLogin{
            strUserLogin = txfUserLogin.text
        }
    }
    
}


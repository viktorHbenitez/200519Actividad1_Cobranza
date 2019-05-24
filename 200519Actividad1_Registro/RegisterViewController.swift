//
//  RegisterViewController.swift
//  200519Actividad1_Registro
//
//  Created by Victor Hugo Benitez Bosques on 20/05/19.
//  Copyright © 2019 Victor Hugo Benitez Bosques. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {
    
    @IBOutlet weak var txfName: UITextField!
    @IBOutlet weak var txfPhoneNumber: UITextField!
    @IBOutlet weak var txfEmail: UITextField!
    
    @IBOutlet weak var txfPassword: UITextField!
    @IBOutlet weak var txfPasswordConfirmation: UITextField!
    
    @IBOutlet weak var txfBirdthDay: UITextField!
    @IBOutlet weak var swGender: UISwitch!
    @IBOutlet weak var swPrivacy: UISwitch!
    
    
    @IBOutlet weak var lblMessagePassword: UILabel!
    @IBOutlet weak var lblMessagePrivacy: UILabel!
    
    @IBOutlet weak var lblMessageAllFields: UILabel!
    @IBOutlet weak var btnRegister: UIButton!
    
    var userRegister : User?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    
    @IBAction func btnRegister(_ sender: UIButton) {
        resetLablesMessage()
        // Validate iquals password
        let bIqualsPass = txfPassword.text == txfPasswordConfirmation.text && txfPassword.text?.count ?? 0 > 0 && txfPasswordConfirmation.text?.count ?? 0 > 0
        
        // Validate all fields
        let bValidAllFileds = txfName.text?.count ?? 0 > 0 && txfEmail.text?.count ?? 0 > 0 && txfPassword.text?.count ?? 0 > 0 && txfPasswordConfirmation.text?.count ?? 0 > 0 && txfBirdthDay.text?.count ?? 0 > 0
        
        if swPrivacy.isOn{
            
            if bValidAllFileds{
                
                print("All fields Completed")
                
                if bIqualsPass {
                    
                    lblMessageAllFields.backgroundColor = #colorLiteral(red: 0.1960784346, green: 0.3411764801, blue: 0.1019607857, alpha: 1)
                    lblMessageAllFields.textColor = UIColor.white
                    lblMessageAllFields.text = "Usuario registrado correctamente"
                    
//                    setDataUser()
                    
                    
                    self.addAlert(strTitle: "Actividad 1", strMessage: "Usuario registrado correctamente ", bSuccess: true)
                    
                }else{
                    lblMessagePassword.text = " la confirme de la  contraseñas debe ser iguales"
                    print("Confirme contraseñas")
                    
                }
            }else{
                print("you need to write all fields ")
                
                lblMessageAllFields.text = "Necesita llenar todos los campos (excepto opcionales)"
            }
            
            
        }else {
            
            lblMessagePrivacy.text = "Necesita Aceptar las condiciones de uso"
            print("Necesita aceptar las politicas de privacidad")
        }
        
        
        
    }
    
    func addAlert(strTitle : String?, strMessage : String?, bSuccess : Bool = false){
        let alert = UIAlertController(title: strTitle, message: strMessage, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default, handler: { (_) in
            
            if bSuccess{
                DispatchQueue.main.async {
                    self.btnLogionPressed()

                }
            }
        })
        alert.addAction(ok)
        self.present(alert, animated: true, completion: nil)
    }
    
    
    
    
//    func setDataUser(){
//
//        userRegister = User(name: txfName.text!, email: txfEmail.text!, contraseña: txfPassword.text!, numeroEmpledo: "337133", fechaNacimiento: "Nose", telefono: txfPhoneNumber.text!)
//
//    }
    
    
    @IBAction func btnLogionPressed() {
        performSegue(withIdentifier: "unwindSegue", sender: userRegister)
    }
    
    func resetLablesMessage() {
        lblMessagePrivacy.text = ""
        lblMessagePassword.text = ""
        lblMessageAllFields.text = ""
    }
    
    
}

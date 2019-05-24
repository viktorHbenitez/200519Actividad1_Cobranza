//
//  RegisterViewController.swift
//  200519Actividad1_Registro
//
//  Created by Victor Hugo Benitez Bosques on 20/05/19.
//  Copyright © 2019 Victor Hugo Benitez Bosques. All rights reserved.
//

import UIKit
import CoreData

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
    @IBOutlet weak var btnRegister: UIButton!{
        didSet{
//            loadViewIfNeeded()
            btnRegister.setTitle(bEditer ? "Editar" : "Registrar", for: .normal)
        }
    }
    
    var arrEmpleado = [Empleado]()
    var empleado : Empleado?
    var bEditer = false
    var strTitle : String?
    
    private let appDelegate = UIApplication.shared.delegate as! AppDelegate
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    var identifierUser = 0
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.title = bEditer ? "Editar usuario" : "Registrarse"
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        setUpPickerIntoTxf()
        
        if arrEmpleado.count > 0{
            for employee in arrEmpleado{
                
                if let ident = employee.identifier{
                    identifierUser = 1
                    identifierUser +=  Int(ident) ?? 0
                }
                
            }
        }
        if let empledoEditado = empleado{
            txfName.text = empledoEditado.fullName
            txfEmail.text = empledoEditado.email
            txfPhoneNumber.text = String(empledoEditado.phoneNumber)
            txfPassword.text = empledoEditado.drowssap
            txfPasswordConfirmation.text = empledoEditado.drowssap
        }
        
    }
    
    func setUpPickerIntoTxf() {
        
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor.blue
        toolBar.sizeToFit()
        
        
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.plain, target: self, action: #selector(ViewController.donePicker))
        
        
        toolBar.setItems([doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        txfName.inputAccessoryView = toolBar
        txfPhoneNumber.inputAccessoryView = toolBar
        txfPassword.inputAccessoryView = toolBar
        txfEmail.inputAccessoryView = toolBar
        txfBirdthDay.inputAccessoryView = toolBar
        txfPasswordConfirmation.inputAccessoryView = toolBar
    }
    
    @objc func donePicker() {
        txfName.resignFirstResponder()
        txfPhoneNumber.resignFirstResponder()
        txfPassword.resignFirstResponder()
        txfEmail.resignFirstResponder()
        txfBirdthDay.resignFirstResponder()
        txfPasswordConfirmation.resignFirstResponder()
        
    }
   
    
   
    
    private func refresh() {
        do {
            arrEmpleado = try context.fetch(Empleado.fetchRequest())
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
    func addEmployee(){
        let empleado = Empleado(entity: Empleado.entity(), insertInto: context)
        empleado.identifier = String(identifierUser)
        empleado.fullName = txfName.text?.trimmingCharacters(in: .whitespaces)
        empleado.adress = txfEmail.text
        empleado.email = txfEmail.text
        //        empleado.dateBirth = txfBirdthDay.text
        empleado.phoneNumber = Int16(txfPhoneNumber.text ?? "0") ?? 0
        empleado.drowssap = txfPassword.text?.trimmingCharacters(in: .whitespaces)
        appDelegate.saveContext()
        lblMessageAllFields.text = "Usuario registrado correctamente"

    }
    
    private func updateUser(){
        guard let empleadoSelected = empleado, let identifier = empleadoSelected.identifier  else {return}
        let request = Empleado.fetchRequest() as NSFetchRequest<Empleado>
        request.predicate = NSPredicate(format: "identifier = %@", identifier)
        
        do {
            let results = try context.fetch(request)
            let objectUpdate = results[0] as NSManagedObject
            
           
            objectUpdate.setValue(txfName.text?.trimmingCharacters(in: .whitespaces), forKey: "fullName")
            objectUpdate.setValue(txfEmail.text, forKey: "adress")
            objectUpdate.setValue(txfEmail.text, forKey: "email")
//            objectUpdate.setValue(txt_Address.text!, forKey: "dateBirth")
            objectUpdate.setValue(txfPassword.text?.trimmingCharacters(in: .whitespaces), forKey: "drowssap")
            
            appDelegate.saveContext()
            txfName.text = ""
            txfPhoneNumber.text = ""
            txfEmail.text = ""
            txfPasswordConfirmation.text = ""
            txfPassword.text = ""
            txfBirdthDay.text = ""
            lblMessageAllFields.text = "Update User"
            
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
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

                    if bEditer{
                        updateUser()
                    }else{
                        addEmployee()
                    }

                    self.addAlert(strTitle: "Actividad 1", strMessage: (bEditer) ? "Usuario Editado correctamente" : "Usuario Registrado Corectamente", bSuccess: true)

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
    
    @IBAction func btnLogionPressed() {
        performSegue(withIdentifier: "unwindSegue", sender: nil)
    }
    
    func resetLablesMessage() {
        lblMessagePrivacy.text = ""
        lblMessagePassword.text = ""
        lblMessageAllFields.text = ""
    }
    
    
}

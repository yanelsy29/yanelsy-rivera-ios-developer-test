//
//  MenuViewController.swift
//  Hugo Test
//
//  Created by yanelsy rivera on 10/22/20.
//

import UIKit

class MenuViewController: UIViewController {
    
    private var viewModel: MenuViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = MenuViewModel(view: self)
    }
    
    @IBSegueAction func registerCheckIn(_ coder: NSCoder) -> UIViewController? {
        return RegistrationDateViewController(coder: coder, mode: .checkIn)
    }
    
    @IBSegueAction func registerCheckOut(_ coder: NSCoder) -> UIViewController? {
        return RegistrationDateViewController(coder: coder, mode: .checkOut)
    }
    
    @IBSegueAction func oficialViewSegue(_ coder: NSCoder) -> RegistrationCarViewController? {
        return RegistrationCarViewController(coder: coder, type: .oficial)
    }
    
    @IBSegueAction func residentViewSegue(_ coder: NSCoder) -> RegistrationCarViewController? {
        return RegistrationCarViewController(coder: coder, type: .resident)
    }

    
    @IBAction func resetRecordAction() {
        let action = UIAlertAction(title: "Continuar", style: .default) { (action) in
            self.viewModel.resetRecord()
        }
        let alertController = UIAlertController(title: "Eliminar Estancias", message: "¿Desea eliminar todas las estancias?", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Cancelar", style: .cancel, handler: nil))
        alertController.addAction(action)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
}

extension MenuViewController: MenuView {
    
    func presentMessageAlertView(_ title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    
}

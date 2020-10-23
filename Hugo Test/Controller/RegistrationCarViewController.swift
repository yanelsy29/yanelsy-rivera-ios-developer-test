//
//  RegistrationCarViewController.swift
//  Hugo Test
//
//  Created by yanelsy rivera on 10/23/20.
//

import UIKit

class RegistrationCarViewController: BaseViewController {
    
    @IBOutlet weak var numberPlateTextField: UITextField!
    @IBOutlet weak var titleLabel: UILabel!
    var type: CarType = .oficial
    fileprivate var viewModel: RegisterCarViewModel!
    
    init?(coder: NSCoder, type: CarType) {
       self.type = type
       super.init(coder: coder)
    }

    required init?(coder: NSCoder) {
       fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = RegisterCarViewModel(view: self)
        
        if type == .oficial {
            titleLabel.text = "Dar de alta vehículo oficial"
        } else {
            titleLabel.text = "Dar de alta vehículo residente"
        }
    }
    
    
    @IBAction func saveCarAction() {
        viewModel.saveCar(plateNumber: numberPlateTextField.text, type: type)
    }
    
}

extension RegistrationCarViewController: RegisterCarView {
    
    func registerCarSuccess() {
        numberPlateTextField.text = ""
        let alertController = UIAlertController(title: "Registro exitoso", message: "Su número de placa fue registrado" , preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    func presentMessageAlertView(_ message: String) {
        
        let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
        self.present(alertController, animated: true, completion: nil)
    
    }
    
    
    
}

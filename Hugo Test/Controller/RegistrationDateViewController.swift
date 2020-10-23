//
//  ViewController.swift
//  Hugo Test
//
//  Created by yanelsy rivera on 10/20/20.
//

import UIKit
import CoreData

public enum DateRegisternMode {
    case checkIn
    case checkOut
}

class RegistrationDateViewController: BaseViewController {
    
    @IBOutlet weak var numberPlateTextField: UITextField!
    @IBOutlet weak var titleLabel: UILabel!
    private var viewModel: RegisterDateViewModel!
    var mode: DateRegisternMode = .checkIn
    
    init?(coder: NSCoder, mode: DateRegisternMode) {
       self.mode = mode
       super.init(coder: coder)
    }

    required init?(coder: NSCoder) {
       fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = RegisterDateViewModel(view: self)
        
        if mode == .checkIn {
            titleLabel.text = "Registro de entrada de vehiculos"
        } else {
            titleLabel.text = "Registro de salida de vehiculos"
        }
        
    }

    @IBAction func registerDate(_ sender: Any) {
        if mode == .checkIn {
            viewModel.checkInCar(plateNumber: numberPlateTextField.text)
        } else {
            viewModel.checkOutCar(plateNumber: numberPlateTextField.text)
        }
    }
    
}

extension RegistrationDateViewController: RegisterDateView {
    func displayParkingPrice(_ price: Double) {
        let alertController = UIAlertController(title: "Importe a Pagar", message: String(format: "$%.2f", price) , preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    
    func registerDateSuccess() {
        numberPlateTextField.text = ""
        let alertController = UIAlertController(title: "Registro exitoso", message: "Se registro la fecha de estacionamiento" , preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    func presentMessageAlertView(_ message: String) {
        
        let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
        self.present(alertController, animated: true, completion: nil)
    
    }
}

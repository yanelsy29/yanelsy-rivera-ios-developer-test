//
//  CarRegisterViewModel.swift
//  Hugo Test
//
//  Created by yanelsy rivera on 10/22/20.
//

import UIKit
import CoreData

protocol RegisterCarView {
    func registerCarSuccess()
    func presentMessageAlertView(_ message: String)
}
 
class RegisterCarViewModel: NSObject {
    
    private var view: RegisterCarView!
    private var appDelegate = UIApplication.shared.delegate as! AppDelegate
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    init(view: RegisterCarView) {
        self.view = view
    }
    
    private func registerCar(plateNumber: String, type: CarType) {
        let car = Car(context: context)
        car.type = type.rawValue
        car.numberPlate = plateNumber
        
        if appDelegate.saveContextSuccess() {
            view.registerCarSuccess()
        } else {
            view.presentMessageAlertView("¡Ups algo ocurrio!. Por favor intente nuevamente")
        }
        
    }
    
    private func fetchCar(plateNumber: String) -> Car? {
        let predicate = NSPredicate(format: "numberPlate = %@", argumentArray: [plateNumber])
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Car")
        request.predicate = predicate

        do {
            let result = try context.fetch(request) as? [Car]
        
            if let list = result, list.count > 0 {
                return list[0]
            }
            
            return nil
          
        } catch let error {
            print(error.localizedDescription)
           return nil
        }
    }
    
    func saveCar(plateNumber: String?, type: CarType) {
        guard let plate = plateNumber else {
            view.presentMessageAlertView("Introduzca un número de placa válido")
            return
        }
        
        if let _ = fetchCar(plateNumber: plate) {
            view.presentMessageAlertView("El vehículo ya se encuentra registrado")
        } else {
            registerCar(plateNumber: plate, type: type)
        }
    }
    
}

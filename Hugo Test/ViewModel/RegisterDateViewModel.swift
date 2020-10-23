//
//  CarRegisterViewModel.swift
//  Hugo Test
//
//  Created by yanelsy rivera on 10/22/20.
//

import UIKit
import CoreData

protocol RegisterDateView {
    func displayParkingPrice(_ price: Double)
    func registerDateSuccess()
    func presentMessageAlertView(_ message: String)
}
 
class RegisterDateViewModel: NSObject {
    
    private var view: RegisterDateView!
    private var appDelegate = UIApplication.shared.delegate as! AppDelegate
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    init(view: RegisterDateView) {
        self.view = view
    }
    
    private func registerCar(plateNumber: String, type: CarType) {
        let car = Car(context: context)
        car.type = type.rawValue
        car.numberPlate = plateNumber
        
        let park = Parking(context: context)
        park.dateIn = Date()
        car.addToParkings(park)
        
        if appDelegate.saveContextSuccess() {
            view.registerDateSuccess()
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
    
    private func fetchLastCheckInParking(plateNumber: String) -> Parking? {
        let predicate =  NSPredicate(format: "car.numberPlate == %@", plateNumber)
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Parking")
        request.predicate = predicate

        do {
            let result = try context.fetch(request) as? [Parking]
            let list = result?.filter({$0.dateOut == nil})
            if list != nil, list!.count > 0 {
                return list![0]
            }
            
            return nil
          
        } catch let error {
            print(error.localizedDescription)
           return nil
        }
    }
    
    func checkInCar(plateNumber: String?) {
        guard let plate = plateNumber else {
            view.presentMessageAlertView("Introduzca un número de placa válido")
            return
        }
        
        if let car = fetchCar(plateNumber: plate) {
            let park = Parking(context: context)
            park.dateIn = Date()
            car.addToParkings(park)
            view.registerDateSuccess()
        } else {
            registerCar(plateNumber: plate, type: .nonResident)
        }
    }
    
    func checkOutCar(plateNumber: String?) {
        guard let plate = plateNumber else {
            view.presentMessageAlertView("Introduzca un número de placa válido")
            return
        }
        
        if let parking = fetchLastCheckInParking(plateNumber: plate) {
            let currentDate = Date()
            let minutes = getMinutesDifferenceFromTwoDates(start: parking.dateIn!, end: currentDate)
            let price = Double(minutes) * 0.5
            
            parking.setValue(currentDate, forKey: "dateOut")
            parking.setValue(minutes, forKey: "parkingTimeMinutes")
            parking.setValue(price, forKey: "price")

            if appDelegate.saveContextSuccess() {
                let type = CarType(rawValue: parking.car!.type)
                if type == .nonResident {
                    view.displayParkingPrice(price)
                } else {
                    view.registerDateSuccess()
                }
            } else {
                view.presentMessageAlertView("¡Ups algo ocurrio!. Por favor intente nuevamente")
            }
            
        } else {
            view.presentMessageAlertView("El número de placa no posee una entrada")
        }
    }
    
    private func getMinutesDifferenceFromTwoDates(start: Date, end: Date) -> Int
       {

           let diff = Int(end.timeIntervalSince1970 - start.timeIntervalSince1970)

           let hours = diff / 3600
           let minutes = (diff - hours * 3600) / 60
           return minutes
       }
    
}

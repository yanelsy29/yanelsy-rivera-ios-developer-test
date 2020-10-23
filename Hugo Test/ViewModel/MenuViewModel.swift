//
//  MenuViewModel.swift
//  Hugo Test
//
//  Created by yanelsy rivera on 10/23/20.
//

import UIKit
import CoreData

protocol MenuView {
    func presentMessageAlertView(_ title: String, message: String)
}

class MenuViewModel: NSObject {
    
    private var view: MenuView!
    private var appDelegate = UIApplication.shared.delegate as! AppDelegate
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    init(view: MenuView) {
        self.view = view
    }
    
    func resetRecord() {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Parking")
        
        let result = try? context.fetch(request)
        if let list = result {
            for object in list {
                context.delete(object as! NSManagedObject)
            }
        }
       
        if appDelegate.saveContextSuccess() {
            view.presentMessageAlertView("Alerta", message: "Estancias almacenadas han sido eliminadas")
        } else {
            view.presentMessageAlertView("Error", message: "¡Ups algo ocurrio!. Por favor intente nuevamente")

        }
        
    }
}

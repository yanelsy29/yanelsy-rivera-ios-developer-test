//
//  ResidentPaymentListViewModel.swift
//  Hugo Test
//
//  Created by yanelsy rivera on 10/23/20.
//

import UIKit
import CoreData

protocol ResidentPaymentListView {
    func reloadView()
}

class ResidentPaymentListViewModel: NSObject {
    
    private var view: ResidentPaymentListView!
    private var appDelegate = UIApplication.shared.delegate as! AppDelegate
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    private var parkingListDict: Dictionary = [String:[Parking]]()
    
    init(view: ResidentPaymentListView) {
        self.view = view
    }
    
    func getParkingList() {
        let list = fetchResidentParking()
        parkingListDict = Dictionary(grouping: list, by: {$0.car!.numberPlate})
        view.reloadView()
    }
    
    private func fetchResidentParking() -> [Parking] {
        let predicate =  NSPredicate(format: "car.type = %@ && price > 0", argumentArray: ["Residente"])
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Parking")
        request.predicate = predicate

        do {
            let result = try context.fetch(request) as? [Parking]
            if let list = result, list.count > 0 {
                return list
            }
            
            return []
          
        } catch let error {
            print(error.localizedDescription)
           return []
        }
    }

    func numberOfSection() -> Int {
        let groupNames = parkingListDict.keys.sorted()
        return groupNames.count
    }
    
    func keyAtSection(_ section: Int) -> String {
        let groupNames = parkingListDict.keys.sorted()
        return groupNames[section]
    }
    
    func rowsAtSection(_ section: Int) -> [Parking] {
        let groupNames = parkingListDict.keys.sorted()
        
        return parkingListDict[groupNames[section]] ?? []
    }
    
    func stringFromDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM 'at' hh:mm a"
        
        return formatter.string(from: date)
    }
    
    func totalPriceBySection(_ section: Int) -> Double {
        let groupNames = parkingListDict.keys.sorted()
        let items = parkingListDict[groupNames[section]] ?? []
        var totalPrice = 0.0
        
        for item in items {
            totalPrice += item.price
        }
        
        return totalPrice
    }
}

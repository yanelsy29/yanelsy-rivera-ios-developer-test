//
//  ResidentPaymentListViewController.swift
//  Hugo Test
//
//  Created by yanelsy rivera on 10/23/20.
//

import UIKit

class ResidentPaymentTableViewHeaderCell: UITableViewCell {
    @IBOutlet var plateLabel: UILabel!
    
}

class ResidentPaymentTableViewFooterCell: UITableViewCell {
    @IBOutlet var totalPriceLabel: UILabel!
    
}

class ResidentPaymentTableViewCell: UITableViewCell {
    @IBOutlet var dateInLabel: UILabel!
    @IBOutlet var dateOutLabel: UILabel!
    @IBOutlet var timeMinuteLabel: UILabel!
    @IBOutlet var priceLabel: UILabel!
    
}

class ResidentPaymentListViewController: BaseViewController {
    
    @IBOutlet var residentTableView: UITableView!
    
    private var viewModel: ResidentPaymentListViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = ResidentPaymentListViewModel(view: self)
        viewModel.getParkingList()
    }
}

extension ResidentPaymentListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.rowsAtSection(section).count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSection()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = viewModel.rowsAtSection(indexPath.section)[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! ResidentPaymentTableViewCell
        
        if let dateIn = item.dateIn {
            cell.dateInLabel.text = viewModel.stringFromDate(dateIn)
        }
         
        if let dateOut = item.dateOut {
            cell.dateOutLabel.text = viewModel.stringFromDate(dateOut)
        }
        
        cell.timeMinuteLabel.text = String(format: "%i minutes", item.parkingTimeMinutes)
        cell.priceLabel.text = String(format: "$%.2f", item.price)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = tableView.dequeueReusableCell(withIdentifier: "header") as! ResidentPaymentTableViewHeaderCell
        cell.plateLabel.text = viewModel.keyAtSection(section)
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let cell = tableView.dequeueReusableCell(withIdentifier: "footer") as? ResidentPaymentTableViewFooterCell
        cell?.totalPriceLabel.text = String(format: "$%.2f", viewModel.totalPriceBySection(section))
        return cell!
    }
    
}


extension ResidentPaymentListViewController: ResidentPaymentListView {
    
    func reloadView() {
        residentTableView.reloadData()
    }
}

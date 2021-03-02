//
//  GreenViewController.swift
//  PrivateBankAPI
//
//  Created by Track Ensure on 2021-03-02.
//

import UIKit
import PromiseKit
import NVActivityIndicatorView

class GreenViewController: UIViewController, StoryboardInitializable {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var selectDateInPicker: UIDatePicker!
    
    
    let cellIdentifier = "cellIdentifier"
    var byDay: CurrensyExchange?
    var selectedDay: Date?
    var indicator: NVActivityIndicatorView?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.selectDateInPicker.preferredDatePickerStyle = .wheels
        self.selectDateInPicker.datePickerMode = .date
        
        self.selectDateInPicker.addTarget(self, action: #selector(self.dateChanged), for: .valueChanged)
        self.selectedDay = self.selectDateInPicker.date
        
        let center = CGRect(x: self.view.bounds.midX-20, y: self.view.bounds.midY-20, width: 40, height: 40)
        self.indicator = NVActivityIndicatorView(frame: center, type: .ballSpinFadeLoader, color: .blue, padding: 0)
        self.view.addSubview(self.indicator!)
        
        self.fetchRequestByDay(selectedDay: self.selectedDay!)
    }
    
    func fetchRequestByDay(selectedDay: Date) {
        self.indicator?.startAnimating()
        firstly { Provider.requestByDate(date: selectedDay) }.done { [weak self] (response) in
            self?.byDay = response
//            print(self?.byDay)
            self?.tableView.reloadData()
            self?.indicator?.stopAnimating()
        }.catch { (error) in
            debugPrint(error.localizedDescription)
            self.indicator?.stopAnimating()
            
        }
    }
    
    @objc func dateChanged() {
        self.selectedDay = self.selectDateInPicker.date
        self.fetchRequestByDay(selectedDay: self.selectedDay!)
        print(self.selectDateInPicker.date)
    }
}

extension GreenViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.byDay?.exchangeRate.count ?? 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: self.cellIdentifier, for: indexPath)

        if let cell = tableView.dequeueReusableCell(withIdentifier: self.cellIdentifier, for: indexPath) as? CustomTableViewCell {
            if let currency = self.byDay?.exchangeRate[indexPath.row].currency, let saleRateNB = self.byDay?.exchangeRate[indexPath.row].saleRateNB {
                cell.currencyLabel.text = currency
                cell.safeRateNBLabel.text = String(saleRateNB)
            }
            return cell
        }
//        if let saleRateNB = self.byDay?.exchangeRate[indexPath.row].saleRateNB {
//            cell.textLabel?.text = String(saleRateNB)
//        }
//        return cell
        return UITableViewCell()
    }
}

//
//  ViewController.swift
//  PrivateBankAPI
//
//  Created by Track Ensure on 2021-03-02.
//

import UIKit
import PromiseKit

class ViewController: UIViewController, StoryboardInitializable {
    
    var today: CurrensyExchange?
    var byDay: CurrensyExchange?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.fetchRequestToday()
        
        let today = Date()
        let yestarday = Calendar.current.date(byAdding: .day, value: -1, to: today)
        
        self.fetchRequestByDay(selectedDay: yestarday!)
    }

    func fetchRequestToday() {
        firstly { Provider.requestToday() }.done { [weak self] (response) in
            self?.today = response
//            print(self?.today)
        }.catch { (error) in
            debugPrint(error.localizedDescription)
        }
    }
    
    func fetchRequestByDay(selectedDay: Date) {
        firstly { Provider.requestByDate(date: selectedDay) }.done { [weak self] (response) in
            self?.byDay = response
//            print(self?.byDay)
        }.catch { (error) in
            debugPrint(error.localizedDescription)
        }
    }
    @IBAction func goToGreenVC(_ sender: Any) {
        AppCoordinator.shared.push(.greenVC)
    }
}


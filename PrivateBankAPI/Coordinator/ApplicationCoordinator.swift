//
//  ApplicationCoordinator.swift
//  PrivateBankAPI
//
//  Created by Track Ensure on 2021-03-02.
//

import Foundation
import UIKit

class AppCoordinator: NSObject {
    static let shared = AppCoordinator()
    
    private var currentNavigator: UINavigationController?
    
    func start(with window: UIWindow) {
        let startVC = self.instantiate(.root)
        
        self.currentNavigator = UINavigationController(rootViewController: startVC)
        
        window.rootViewController = self.currentNavigator
        window.makeKeyAndVisible()
    }
    
    
    func push(_ controller: AppViewController, animated: Bool = true) {
      let vc = instantiate(controller)
      currentNavigator?.pushViewController(vc, animated: animated)
    }
    
    private func instantiate(_ controller: AppViewController) -> UIViewController {
        switch controller {
        case .root:
            return ViewController.createFromStoryboard()
        case .greenVC:
            return GreenViewController.createFromStoryboard()
        }
    }
}

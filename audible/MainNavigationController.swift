//
//  MainNavigationController.swift
//  audible
//
//  Created by Luiz Alfredo Diniz Hammerli on 03/05/17.
//  Copyright © 2017 Luiz Alfredo Diniz Hammerli. All rights reserved.
//

import UIKit

class MainNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        
        if (isLogged()){
        
            let homeViewController = HomeViewController()
            self.viewControllers = [homeViewController]
            
        }else{
            perform(#selector(showLoginViewController), with: self, afterDelay: 0.0)
        }
    }
    
    func showLoginViewController(){
        
        let loginViewController = LoginViewController()
        
        self.present(loginViewController, animated: true, completion: {
        
        })
    }
    
    func isLogged()->Bool{
    
        return UserDefaults.standard.isLoggedIn()
    }
}

//
//  UserDefaultsHelpers.swift
//  audible
//
//  Created by Luiz Alfredo Diniz Hammerli on 07/05/17.
//  Copyright © 2017 Luiz Alfredo Diniz Hammerli. All rights reserved.
//

import Foundation

extension UserDefaults{

    enum UserDefaultsKeys: String {
        case isLoggedIn
    }
    
    func setUserLoggedIn(_ value:Bool){
    
       self.set(value, forKey: UserDefaultsKeys.isLoggedIn.rawValue)
        self.synchronize()
    }
    
    func isLoggedIn()->Bool{
    
        return self.bool(forKey: UserDefaultsKeys.isLoggedIn.rawValue)
    }
}

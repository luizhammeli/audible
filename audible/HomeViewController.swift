//
//  HomeViewController.swift
//  audible
//
//  Created by Luiz Alfredo Diniz Hammerli on 03/05/17.
//  Copyright © 2017 Luiz Alfredo Diniz Hammerli. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    let homeImageView: UIImageView = {
        
        let imageView = UIImageView()
        imageView.image = UIImage(named: "home")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        //imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    lazy var signOutButton:UIBarButtonItem = {
        
        let barButton = UIBarButtonItem(title: "SignOut", style: .plain, target: self, action: #selector(signOut))
        
        return barButton
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.navigationItem.title = "Audible"
        self.navigationItem.leftBarButtonItem = signOutButton
        addSubviews()
        setUpViews()
    }
    
    func addSubviews(){
    
        self.view.addSubview(homeImageView)
    }
    
    func setUpViews(){
    
        homeImageView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        homeImageView.topAnchor.constraint(equalTo: self.view.topAnchor, constant:64).isActive = true
        homeImageView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        homeImageView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
    }
    
    func signOut(){
    
        UserDefaults.standard.setUserLoggedIn(false)
        self.present(LoginViewController(), animated: true, completion: nil)
    }
}

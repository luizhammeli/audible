//
//  LoginCell.swift
//  audible
//
//  Created by Luiz Alfredo Diniz Hammerli on 27/04/17.
//  Copyright © 2017 Luiz Alfredo Diniz Hammerli. All rights reserved.
//

import UIKit

class LoginCell: UICollectionViewCell {
    
    weak var loginContollerDelegate: LoginControllerDelegate?
    
    let logoImageVIew:UIImageView = {
        
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "logo")
        
        return imageView
        
    }()
    
    let emailTextField:leftPaddedTextField = {
    
        let textField = leftPaddedTextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Enter email"
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.layer.borderWidth = 1
        textField.keyboardType = .emailAddress
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .none
        return textField
        
    }()
    
    let passwordTextField:leftPaddedTextField = {
        
        let textField = leftPaddedTextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Enter password"
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.layer.borderWidth = 1
        textField.isSecureTextEntry = true
        textField.keyboardType = .emailAddress
        textField.autocapitalizationType = .none
        return textField
        
    }()
    
    lazy var loginButton: UIButton = {
    
        let button = UIButton(type: .system)
        button.setTitle("Login", for: .normal)
        button.backgroundColor = UIColor.orange
        button.setTitleColor(UIColor.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(login), for: .touchUpInside)
        return button
    }()
    
    override init(frame: CGRect){
        
        super.init(frame:frame)
        addSubviews()
        setUpViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    fileprivate func setUpViews(){
    
        logoImageVIew.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        logoImageVIew.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -130).isActive = true
        logoImageVIew.widthAnchor.constraint(equalToConstant: 170).isActive = true
        logoImageVIew.heightAnchor.constraint(equalToConstant: 170).isActive = true
        
        emailTextField.topAnchor.constraint(equalTo: logoImageVIew.bottomAnchor, constant: 0).isActive = true
        emailTextField.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -25).isActive = true
        emailTextField.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 25).isActive = true
        emailTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 15).isActive = true
        passwordTextField.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -25).isActive = true
        passwordTextField.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 25).isActive = true
        passwordTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        loginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 15).isActive = true
        loginButton.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -25).isActive = true
        loginButton.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 25).isActive = true
        loginButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
    }
    
    fileprivate func addSubviews() {
        
        self.addSubview(logoImageVIew)
        self.addSubview(emailTextField)
        self.addSubview(passwordTextField)
        self.addSubview(loginButton)
    }
    
    func login(){
    
        guard let delegate = loginContollerDelegate else{return}
        
        delegate.finishLogin()
    }
}

class leftPaddedTextField:UITextField{

    override func textRect(forBounds bounds: CGRect) -> CGRect {
        
        return CGRect(x: bounds.origin.x + 10, y: bounds.origin.y, width: bounds.width - 8, height: bounds.height)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        
        return CGRect(x: bounds.origin.x + 10, y: bounds.origin.y, width: bounds.width - 8, height: bounds.height)
    }
}

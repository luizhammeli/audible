//
//  ViewController.swift
//  audible
//
//  Created by Luiz Alfredo Diniz Hammerli on 22/04/17.
//  Copyright © 2017 Luiz Alfredo Diniz Hammerli. All rights reserved.
//

import UIKit

protocol LoginControllerDelegate:class {
    func finishLogin()
}

class LoginViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, LoginControllerDelegate{

    let cellId = "cellId"
    let loginCellId = "loginCellId"
    var pageControlBottomAnchor: NSLayoutConstraint?
    var skipButtomTopAnchor: NSLayoutConstraint?
    var nextButtomTopAnchor: NSLayoutConstraint?
    
    lazy var collectionView:UICollectionView = {
    
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        collectionView.backgroundColor = UIColor.white
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    let pages:[Page] = {
    
        let firstPage = Page(title: "Share a great listen", message: "It's free to send your books to the people in your life. Every recipient's first book is on us.", imageName: "page1")
        let secondPage = Page(title: "Send from your library", message: "Tap the More menu next to any book. Choose \"Send this Book\"", imageName: "page2")
        let thirdPage = Page(title: "Send from the player", message: "Tap the More menu in the upper corner. Choose \"Send this Book\"", imageName: "page3")
        
        return [firstPage, secondPage, thirdPage]
        
    }()
    
    lazy var pageContol: UIPageControl = {
        
        let pc = UIPageControl()
        pc.translatesAutoresizingMaskIntoConstraints = false
        pc.pageIndicatorTintColor = UIColor.lightGray
        pc.currentPageIndicatorTintColor = UIColor(red: 247/255, green: 154/255, blue: 27/255, alpha: 1)
        pc.numberOfPages = self.pages.count + 1
        return pc
    }()
    
    let skipButton: UIButton = {
        
        let button = UIButton(type: .system)
        button.setTitle("Skip", for: .normal)
        button.setTitleColor(UIColor(red: 247/255, green: 154/255, blue: 27/255, alpha: 1), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(skipToLoginPage), for: .touchUpInside)
        return button
        
    }()
    
    lazy var nextButton: UIButton = {
        
        let button = UIButton(type: .system)
        button.setTitle("Next", for: .normal)
        button.setTitleColor(UIColor(red: 247/255, green: 154/255, blue: 27/255, alpha: 1), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(nextPage), for: .touchUpInside)
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        observeKeyboardNotifications()
        addSubviews()
        collectionView.frame = view.frame
        setupCollectionViewConstraints()
        registerCell()
        setUpViews()
    }
    
    fileprivate func registerCell(){
    
        collectionView.register(PageCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.register(LoginCell.self, forCellWithReuseIdentifier: loginCellId)
    }
    
    func setupCollectionViewConstraints(){
        
        collectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        collectionView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        collectionView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        collectionView.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return pages.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.item == pages.count{
        
            let loginCell = self.collectionView.dequeueReusableCell(withReuseIdentifier: loginCellId, for: indexPath) as! LoginCell
            
            loginCell.loginContollerDelegate = self
            
            return loginCell
        }
        
        let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! PageCell
        
        cell.page = pages[indexPath.row]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: view.frame.width, height: view.frame.height)
    }
    
    func addSubviews(){
        self.view.addSubview(collectionView)
        self.view.addSubview(pageContol)
        self.view.addSubview(skipButton)
        self.view.addSubview(nextButton)
    }
    
    func setUpViews(){
    
        pageControlBottomAnchor = pageContol.bottomAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: -15)
        pageControlBottomAnchor?.isActive = true
        pageContol.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        pageContol.widthAnchor.constraint(equalToConstant: 10).isActive = true
        pageContol.heightAnchor.constraint(equalToConstant: 2).isActive = true
        
        //
        skipButtomTopAnchor = skipButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 7)
        skipButtomTopAnchor?.isActive = true
        skipButton.leftAnchor.constraint(equalTo: collectionView.leftAnchor).isActive = true
        skipButton.widthAnchor.constraint(equalToConstant: 70).isActive = true
        skipButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        //
        nextButtomTopAnchor = nextButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 7)
        nextButtomTopAnchor?.isActive = true
        nextButton.rightAnchor.constraint(equalTo: collectionView.rightAnchor, constant: 5).isActive = true
        nextButton.widthAnchor.constraint(equalToConstant: 80).isActive = true
        nextButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        let currentPage = Int(targetContentOffset.pointee.x / self.view.frame.width)
        self.pageContol.currentPage = currentPage
        removeTopButtons()
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        self.view.endEditing(true)
    }
    
    fileprivate func observeKeyboardNotifications(){
    
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    func keyboardShow(){
    
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            
            let yValue:CGFloat = UIDevice.current.orientation.isLandscape ? -115: -50
            
            self.view.frame = CGRect(x: 0, y: yValue, width: self.view.frame.width, height: self.view.frame.height)
            
        }, completion: nil)
    }
    
    func keyboardWillHide(){
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            
            self.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
            
        }, completion: nil)
    }
    
    func nextPage(){
    
        let indexPath = IndexPath(item: self.pageContol.currentPage + 1, section: 0)
        self.collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        
        self.pageContol.currentPage += 1
        
        if (self.pageContol.currentPage == self.pages.count){
        
            removeTopButtons()
        }
        
    }
    
    func skipToLoginPage(){
        
        //let indexPath = IndexPath(item: self.pages.count, section: 0)
        //self.collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        
        self.pageContol.currentPage = self.pages.count - 1
        nextPage()
        //removeTopButtons()
    }
    
    func removeTopButtons(){
    
        if (pageContol.currentPage == self.pages.count){
            
            pageControlBottomAnchor?.isActive = false
            pageControlBottomAnchor = pageContol.bottomAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 40)
            pageControlBottomAnchor?.isActive = true
            
            nextButtomTopAnchor?.isActive = false
            nextButtomTopAnchor = nextButton.topAnchor.constraint(equalTo: view.topAnchor, constant: -40)
            nextButtomTopAnchor?.isActive = true
            
            skipButtomTopAnchor?.isActive = false
            skipButtomTopAnchor = skipButton.topAnchor.constraint(equalTo: view.topAnchor, constant: -40)
            skipButtomTopAnchor?.isActive = true
            
        }else{
            
            pageControlBottomAnchor?.isActive = false
            pageControlBottomAnchor = pageContol.bottomAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: -15)
            pageControlBottomAnchor?.isActive = true
            
            nextButtomTopAnchor?.isActive = false
            nextButtomTopAnchor = nextButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 7)
            nextButtomTopAnchor?.isActive = true
            
            skipButtomTopAnchor?.isActive = false
            skipButtomTopAnchor = skipButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 7)
            skipButtomTopAnchor?.isActive = true
        }
        
        UIView.animate(withDuration: 0.4, delay: 0, options: .curveEaseOut, animations: {
            
            self.view.layoutIfNeeded()
            
        }, completion: nil)
    }
    
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        
        self.collectionView.collectionViewLayout.invalidateLayout()
        let indexPath = IndexPath(item: self.pageContol.currentPage, section: 0)
        
        DispatchQueue.main.async {
            
            self.collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
            
            self.collectionView.reloadData()
        }
    }
    
    func finishLogin(){
    
        let rootViewController = UIApplication.shared.keyWindow?.rootViewController
        
        guard let mainNavigationController = rootViewController as? MainNavigationController else {return}
        
        let homeViewController = HomeViewController()
        mainNavigationController.viewControllers = [homeViewController]
        UserDefaults.standard.setUserLoggedIn(true)
        
        self.dismiss(animated: true, completion: nil)
    }
}


//
//  PageCell.swift
//  audible
//
//  Created by Luiz Alfredo Diniz Hammerli on 22/04/17.
//  Copyright © 2017 Luiz Alfredo Diniz Hammerli. All rights reserved.
//

import UIKit

class PageCell: UICollectionViewCell {

    var page: Page? {
    
        didSet{
        
            guard let page = page else{
                return
            }
            
            var imageName = page.imageName
            
            if (UIDevice.current.orientation.isLandscape){
            
                imageName += "_landscape"
            }
            
            imageView.image = UIImage(named: imageName)
            
            let color = UIColor(white: 0.2, alpha: 1)
            
            let attributedText = NSMutableAttributedString(string: page.title, attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 20, weight: UIFontWeightMedium), NSForegroundColorAttributeName:color])
            
            attributedText.append( NSMutableAttributedString(string:"\n\n \(page.message)", attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 14), NSForegroundColorAttributeName:color]))
            
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = .center
            
            let lenght = attributedText.string.characters.count
            attributedText.addAttribute(NSParagraphStyleAttributeName, value: paragraphStyle, range: NSRange(location: 0, length: lenght))
            
            textView.attributedText = attributedText
        }
    }
    
    let imageView: UIImageView = {
    
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.image = UIImage(named: "page1")
        iv.clipsToBounds = true
        iv.contentMode = .scaleAspectFill
        return iv
        
    }()
    
    let textView:UITextView = {
    
        let tv = UITextView()
        tv.backgroundColor = UIColor.white
        tv.text = "Text"
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.contentInset = UIEdgeInsets(top: 24, left: 0, bottom: 0, right: 0)
        tv.isEditable = false
        
        return tv
    }()
    
    let lineSeparator: UIView = {
    
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(white: 0.9, alpha: 1)
        
        return view
    }()
    
    
    override init(frame: CGRect){
    
        super.init(frame:frame)
        setUpViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpViews(){
        
        self.addSubview(imageView)
        self.addSubview(textView)
        self.addSubview(lineSeparator)

        imageView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        imageView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        imageView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 2.1/3).isActive = true
        
        lineSeparator.topAnchor.constraint(equalTo: textView.topAnchor).isActive = true
        lineSeparator.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        lineSeparator.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        lineSeparator.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        textView.topAnchor.constraint(equalTo: imageView.bottomAnchor).isActive = true
        textView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16).isActive = true
        textView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16).isActive = true
        textView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.75/3).isActive = true        
    }
}

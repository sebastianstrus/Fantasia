//
//  MainMenuVC.swift
//  Fantasia
//
//  Created by Sebastian Strus on 2019-01-31.
//  Copyright © 2019 Sebastian Strus. All rights reserved.
//

import UIKit

class MainMenuVC: UIViewController {

    
    let backgroundIV: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.image = UIImage(named: "blur_background")
        return iv
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
    }
    
    func setupViews() {
        let stackView = createStackView(views: [emailTextField, passwordTextField, loginButton, cancelButton])
        addSubview(backgroundImageView)
        addSubview(stackView)
        backgroundImageView.setAnchor(top: self.topAnchor,
                                      leading: self.leadingAnchor,
                                      bottom: self.bottomAnchor,
                                      trailing: self.trailingAnchor,
                                      paddingTop: 0,
                                      paddingLeft: 0,
                                      paddingBottom: 0,
                                      paddingRight: 0)
        
        stackView.setAnchor(top: nil,
                            leading: nil,
                            bottom: nil,
                            trailing: nil,
                            paddingTop: 0,
                            paddingLeft: 0,
                            paddingBottom: 0,
                            paddingRight: 0,
                            width: self.frame.width - (Device.IS_IPHONE ? 60 : 300),
                            height: Device.IS_IPHONE ? 190 : 380)
        stackView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        stackView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
    }
}


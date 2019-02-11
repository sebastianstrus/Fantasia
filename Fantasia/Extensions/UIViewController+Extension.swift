//
//  UIViewController+Extension.swift
//  Fantasia
//
//  Created by Sebastian Strus on 2019-02-11.
//  Copyright © 2019 Sebastian Strus. All rights reserved.
//

import UIKit

extension UIViewController {

    //handle keyboard
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func showMessage(_ message: String?, withTitle title: String?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK".localized, style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true)
    }

}

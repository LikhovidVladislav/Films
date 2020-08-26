//
//  ShowAlert + UIViewController.swift
//  FIlmsTest
//
//  Created by Влад Лиховид on 17.06.2020.
//  Copyright © 2020 Влад Лиховид. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func showAlert(alertText: String, alertMessage: String) {
        let alert = UIAlertController(title: alertText, message: alertMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

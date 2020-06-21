//
//  Util.swift
//  BackPac
//
//  Created by roy2020 on 2020/06/20.
//  Copyright © 2020 muzcity. All rights reserved.
//

import UIKit

typealias VOID_HANDLER = (()->())?
typealias INT_HANDLER = ((Int)->())?

func ShowAlert(_ parentViewController:UIViewController,
               title: String,
               message: String,
               cancelTitle : String?,
               okTitle : String = "확인",
               cancelHandler : VOID_HANDLER,
               okHandler : VOID_HANDLER) {
    
    let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
    
    if let cancel = cancelTitle {
        let action = UIAlertAction(title: cancel, style: UIAlertAction.Style.cancel) { (action) in
            
            alertController.dismiss(animated: false, completion: nil)
            
            cancelHandler?()
        }
        
        alertController.addAction(action)
    }
    
    
    let action = UIAlertAction(title: okTitle, style: UIAlertAction.Style.default) { (action) in
        
        alertController.dismiss(animated: false, completion: nil)
        
        okHandler?()
    }
    
    alertController.addAction(action)
    
    parentViewController.present(alertController, animated: true, completion: nil)
    
    
}


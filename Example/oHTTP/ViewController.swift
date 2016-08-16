//
//  ViewController.swift
//  oHTTP
//
//  Created by Diego Louli on 08/11/2016.
//  Copyright (c) 2016 Diego Louli. All rights reserved.
//

import UIKit
import oHTTP
import Alamofire

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        Alamofire.request(.GET, "https://google.com.br").authorizedResponse { (req, res, data, error) in
            print(res)
        }
    }
}


//
//  ViewController.swift
//  button
//
//  Created by Taku Funakoshi on 2019/10/24.
//  Copyright © 2019 Taku Funakoshi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var image: UIImageView!
    
    @IBOutlet weak var button: UIButton!
    
    @IBAction func imageButtonPush(_ sender: Any) {

    let image = UIImage(named: "stars")
    let state = UIControl.State.normal

    button.setImage(image, for: state)
    
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        _ = UIImage(named: "swlogo")
    }


}


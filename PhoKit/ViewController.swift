//
//  ViewController.swift
//  PhoKit
//
//  Created by formathead on 2018. 6. 5..
//  Copyright © 2018년 formathead. All rights reserved.
//

import UIKit

class ViewController: UIViewController
{

    @IBOutlet weak var imageView: UIImageView!
    
    var image:UIImage = UIImage()
    
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        imageView.image = image
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


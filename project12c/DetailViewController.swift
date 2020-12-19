//
//  DetailViewController.swift
//  project12c
//
//  Created by Tigran on 12/19/20.
//  Copyright © 2020 Tigran. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet var image: UIImageView!
    
    var path:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let path = path {
            image.image = UIImage(contentsOfFile: path)
        }
        
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

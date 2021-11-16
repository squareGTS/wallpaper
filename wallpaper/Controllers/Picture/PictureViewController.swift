//
//  PictureViewController.swift
//  wallpaper
//
//  Created by Maxim Bekmetov on 28.10.2021.
//

import UIKit

class PictureViewController: UIViewController {
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var information: UITextView!
    
    static var imageURL = String()
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
       
        image.sd_setImage(with: URL(string: PictureViewController.imageURL), placeholderImage: UIImage(named: "placeHolder"))
    }
}

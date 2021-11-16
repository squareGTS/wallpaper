//
//  CollectionViewCell.swift
//  wallpaper
//
//  Created by Maxim Bekmetov on 28.10.2021.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    static let reuseIdentifier = "GalleryCell"
    
    @IBOutlet weak var information: UITextView!
    @IBOutlet weak var image: UIImageView!
    
    func configure(imageURL: String, text: String) {
        
        image.sd_setImage(with: URL(string: imageURL), placeholderImage: UIImage(named: "placeHolder"))
        information.text = text
        
        if image.sd_imageProgress.isIndeterminate {
            print(timeWhenDownloaded())

        }
    }
    
    func timeWhenDownloaded() -> String {
        let formater = DateFormatter()
        formater.timeStyle = .medium
        formater.dateStyle = .long
        
        return formater.string(from: Date())
    }

}

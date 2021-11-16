//
//  GalleryCollectionViewController.swift
//  wallpaper
//
//  Created by Maxim Bekmetov on 28.10.2021.
//

import UIKit
import SwiftyJSON

class GalleryCollectionViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var networkingService = NetworkingService()
    
    var dataJSON: [JSON] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        networkingService.delegate = self
    }
}

extension GalleryCollectionViewController: NetworkingServiceDelegate {
    
    func didUpdate(_ networkingService: NetworkingService) {
        networkingService.fetchData()
        self.dataJSON = networkingService.dataJSON
        collectionView.reloadData()
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }

}


extension GalleryCollectionViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PictureViewController") as? PictureViewController {
            PictureViewController.imageURL = self.dataJSON[indexPath.row]["largeImageURL"].stringValue
            
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // return the number of items
        return self.dataJSON.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.reuseIdentifier, for: indexPath) as? CollectionViewCell else { return UICollectionViewCell() }
        
        // Configure the cell
        cell.configure(imageURL: self.dataJSON[indexPath.row]["largeImageURL"].stringValue, text: self.dataJSON[indexPath.row].description)
        return cell
    }
}

extension GalleryCollectionViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.frame.size.width), height: collectionView.frame.size.height)
    }
}

//
//  NetworkingService.swift
//  wallpaper
//
//  Created by Maxim Bekmetov on 30.10.2021.
//

import Foundation
import Alamofire
import SwiftyJSON
import SDWebImage

protocol NetworkingServiceDelegate: AnyObject {
    func didUpdate(_ networkingService: NetworkingService)
    func didFailWithError(error: Error)
}

class NetworkingService {
    
    weak var delegate: NetworkingServiceDelegate?
    
    var url = "https://pixabay.com/api/?key=24078629-ca080ca72957529b2716c8f8d&q=red+cars&image_type=photo"
    var dataJSON = [JSON]()
    
    func fetchData() {
        
        AF.request(url, method: .get).responseJSON { (response) in
            switch response.result {
            case .success:
                if response.response?.statusCode == 200 {
                    guard let result = response.value else { return }
                    self.dataJSON = JSON(result)["hits"].arrayValue
                }
                
            case .failure(_): break
            }
        }
    }
    
}

//
//  Constant.swift
//  PixabayTEST
//
//  Created by Даурен on 02.02.2022.
//

import Foundation
import UIKit

struct Constant {
    
    //MARK: -API
    static let APIKey = "25511688-c1a02d1cc5c3dbdbdbd0568be"
    static let itemsPerPage = 69
    static let previewSize = "_295x166.jpg"
    
    struct API {
        static let videoAPI = "https://pixabay.com/api/videos/?key=\(Constant.APIKey)&per_page=\(Constant.itemsPerPage)&q="
        static let photoAPI = "https://pixabay.com/api/?key=\(Constant.APIKey)&per_page=\(Constant.itemsPerPage)&q="
        static let vidPreview = "https://i.vimeocdn.com/video/"
    }
    
    //MARK: -Colors

    static let cellBackgroundColor: UIColor = UIColor(red: 237/255, green: 248/255, blue: 235/255, alpha: 1)
}

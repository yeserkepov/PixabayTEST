//
//  Manager.swift
//  PixabayTEST
//
//  Created by Даурен on 02.02.2022.
//

import Foundation

class Manager {
    
    static let shared = Manager()
    
    func fetchPhoto(with search: String, complition: @escaping ([PhotoModel]) -> Void?) {
        guard let url = URL(string: Constant.API.photoAPI + search) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if error == nil, let data = data {
                do {
                    let photoData = try? JSONDecoder().decode(PhotoMain.self, from: data)
                    if let photoData = photoData {
                        var photoArray:[PhotoModel] = []
                        for i in 0..<photoData.hits!.count {
                            photoArray.append(PhotoModel(
                                tags: photoData.hits![i].tags,
                                previewURL: photoData.hits![i].previewURL,
                                largeImageURL: photoData.hits![i].largeImageURL))
                        }
                        complition(photoArray)
                    }
                }
            }
        }.resume()
    }
    
    func fetchVideo(with search: String, complition: @escaping ([VideoModel]) -> Void?) {
        guard let url = URL(string: Constant.API.videoAPI + search) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if error == nil, let data = data {
                do {
                    let videoData = try? JSONDecoder().decode(VideoMain.self, from: data)
                    if let videoData = videoData {
                        var videoArray:[VideoModel] = []
                        for i in 0..<videoData.hits!.count {
                            videoArray.append(VideoModel(
                                tags: videoData.hits![i].tags,
                                preview: Constant.API.vidPreview + videoData.hits![i].picture_id! + Constant.previewSize,
                                url: videoData.hits![i].videos?.medium?.url))
                        }
                        print(videoArray)
                        complition(videoArray)
                    }
                } 
            }
        }.resume()
    }
}

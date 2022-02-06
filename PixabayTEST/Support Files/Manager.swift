//
//  Manager.swift
//  PixabayTEST
//
//  Created by Даурен on 02.02.2022.
//

import Foundation
import UIKit

enum Animate {
    case animateIn
    case animateOut
}

class Manager {
    
    static let shared = Manager()
    
    func animatePopUp(popup: UIView, background: UIView, animate: Animate) {
        background.addSubview(popup)
        switch animate {
        case .animateIn:
            popup.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
            popup.alpha = 0
            popup.center = background.center
            
            UIView.animate(withDuration: 0.3) {
                popup.transform = CGAffineTransform(scaleX: 1, y: 1)
                popup.alpha = 1
            }
        case .animateOut:
            UIView.animate(withDuration: 0.3) {
                popup.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
                popup.alpha = 0
            } completion: { _ in
                popup.removeFromSuperview()
            }
        }
    }
    
    func configurePopUpImage(image : UIImageView, with model: PhotoModel) {
        guard let url = URL(string: model.largeImageURL!) else { return }
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else { return }
            DispatchQueue.main.async {
                let picture = UIImage(data: data)
                image.image = picture
            }
        }.resume()
    }
    
    //TODO: should try to implement
    
//    func playVideo(with playerVC: AVPlayerViewController,from model: VideoModel) {
//        guard let url = URL(string: model.preview!) else { return }
//        DispatchQueue.main.async {
//            playerVC.player = AVPlayer(url: url)
//        }
//    }
    
    
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

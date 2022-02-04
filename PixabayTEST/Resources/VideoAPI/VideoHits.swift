//
//  VideoHits.swift
//  PixabayTEST
//
//  Created by Даурен on 02.02.2022.
//

import Foundation

struct VideoHits: Decodable {
    let tags: String?
    let picture_id: String?
    let videos: VideoSize?
}

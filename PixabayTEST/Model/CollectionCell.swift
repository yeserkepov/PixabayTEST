//
//  CollectionCell.swift
//  PixabayTEST
//
//  Created by Даурен on 02.02.2022.
//

import UIKit

class CollectionCell: UICollectionViewCell {
    
    @IBOutlet weak var imageViewOutlet: UIImageView!
    @IBOutlet weak var labelOutlet: UILabel!
    @IBOutlet weak var playButtonOutlet: UIButton!
    
    static let identifier = "CollectionCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "CollectionCell", bundle: nil)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        self.contentView.backgroundColor = Constant.cellBackgroundColor
        self.layer.cornerRadius = 10
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageViewOutlet.image = nil
        labelOutlet.text = nil
    }
    
    @IBAction func playButtonPressed(_ sender: UIButton) {
        print("button pressed")
    }
    
    public func configure(with model: PhotoModel) {
        playButtonOutlet.isHidden = true
        guard let url = URL(string: model.previewURL!) else { return }
        URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let data = data, error == nil else { return }
            DispatchQueue.main.async {
                let image = UIImage(data: data)
                self?.imageViewOutlet.image = image
                self?.labelOutlet.text = model.tags?.tagTrimmer()
            }
        }.resume()
    }
    
    public func configure(with model: VideoModel) {
        guard let url = URL(string: model.preview!) else { return }
        URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let data = data, error == nil else { return }
            DispatchQueue.main.async {
                let image = UIImage(data: data)
                self?.imageViewOutlet.image = image
                self?.labelOutlet.text = model.tags?.tagTrimmer()
                self?.playButtonOutlet.isHidden = false
            }
        }.resume()
    }
}

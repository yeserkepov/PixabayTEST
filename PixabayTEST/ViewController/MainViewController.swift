//
//  ViewController.swift
//  PixabayTEST
//
//  Created by Даурен on 01.02.2022.
//

import UIKit
import AVKit
import AVFoundation

class MainViewController: UIViewController, UIPopoverPresentationControllerDelegate {
    
    @IBOutlet weak var collectionViewOutlet: UICollectionView!
    @IBOutlet weak var searchBarOutlet: UISearchBar!
    @IBOutlet weak var segmentedControlOutlet: UISegmentedControl!
    
    private var photoData: [PhotoModel] = []
    private var videoData: [VideoModel] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    @IBAction func segmentDidChanged(_ sender: UISegmentedControl) {
        collectionViewOutlet.reloadData()
    }
    

    
  
    private func configure() {
        let layout = UICollectionViewFlowLayout()
        let size = CGFloat((collectionViewOutlet.frame.width - 10)/2)
        layout.itemSize = CGSize(width: size, height: size)
        collectionViewOutlet.collectionViewLayout = layout
        collectionViewOutlet.backgroundColor = .clear
        collectionViewOutlet.register(CollectionCell.nib(), forCellWithReuseIdentifier: CollectionCell.identifier)
        collectionViewOutlet.dataSource = self
        collectionViewOutlet.delegate = self
        searchBarOutlet.delegate = self
    }
}

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        var itemCount = 0
        if segmentedControlOutlet.selectedSegmentIndex == 0 {
            itemCount = 0
            itemCount = photoData.count
        }
        else if segmentedControlOutlet.selectedSegmentIndex == 1 {
            itemCount = 0
            itemCount = videoData.count
        }
        return itemCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionCell.identifier, for: indexPath) as? CollectionCell else { return UICollectionViewCell() }
        //TODO: -to Manager
        if segmentedControlOutlet.selectedSegmentIndex == 0 {
            cell.configure(with: photoData[indexPath.row])
        } else if segmentedControlOutlet.selectedSegmentIndex == 1 {
            cell.configure(with: videoData[indexPath.row])
        }
        
        //TODO: -will it work?
        //segmentedControlOutlet.selectedSegmentIndex == 0 ? cell.configure(with: photoData[indexPath.row]) : cell.configure(with: videoData[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = CGFloat((collectionViewOutlet.frame.width - 10)/2)
        return CGSize(width: size, height: size)
    }
//
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        <#code#>
//    }
}

extension MainViewController: UISearchBarDelegate, UISearchDisplayDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let searchText = searchBar.text?.trim()
        if segmentedControlOutlet.selectedSegmentIndex == 0 {
            Manager.shared.fetchPhoto(with: searchText ?? "") { [weak self] data in
                DispatchQueue.main.async {
                    self?.photoData = data
                    self?.collectionViewOutlet.reloadData()
                }
            }
        } else if segmentedControlOutlet.selectedSegmentIndex == 1 {
            Manager.shared.fetchVideo(with: searchText ?? "") { [weak self] data in
                DispatchQueue.main.async {
                    self?.videoData = data
                    self?.collectionViewOutlet.reloadData()
                }
            }
        }
    }
}

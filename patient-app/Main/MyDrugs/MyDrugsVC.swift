//
//  MyDrugsVC.swift
//  patient-app
//
//  Created by Elliott Brunet on 12.07.19.
//  Copyright © 2019 Elliott Brunet. All rights reserved.
//

import UIKit

class MyDrugsVC: UIViewController {
    
    @IBOutlet weak var newsCollectionView: UICollectionView!
    @IBOutlet weak var drugsTableView: UITableView!
    
    var titles = ["Title 1", "Title 2", "Title 3","Title 1", "Title 2", "Title 3","Title 1", "Title 2", "Title 3"]
    
    var drugs = ["drug 1", "drug 2", "drug 3", "drug 1", "drug 2", "drug 3"]

    override func viewDidLoad() {
        super.viewDidLoad()

        registerNib()
    }

    func registerNib() {
        let nib = UINib(nibName: NewsCell.nibName, bundle: nil)
        newsCollectionView?.register(nib, forCellWithReuseIdentifier: NewsCell.reuseIdentifier)
       
        if let flowLayout = self.newsCollectionView?.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.estimatedItemSize = CGSize(width: 1, height: 1)
        }
    }
}

extension MyDrugsVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return drugs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = drugsTableView.dequeueReusableCell(withIdentifier: "DrugsCell", for: indexPath) as! DrugsCell
        cell.name.text = drugs[indexPath.row]
        return cell
    }
    
    
}

extension MyDrugsVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return titles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = newsCollectionView.dequeueReusableCell(withReuseIdentifier: NewsCell.reuseIdentifier, for: indexPath) as? NewsCell {
            let title = titles[indexPath.row]
            cell.configureCell(title: title)
            return cell
        }
        return UICollectionViewCell()
    }
}

extension MyDrugsVC: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let cell: NewsCell = Bundle.main.loadNibNamed(NewsCell.nibName, owner: self, options: nil)?.first as? NewsCell
            else {return CGSize.zero}
        
        cell.configureCell(title: titles[indexPath.row])
        cell.setNeedsLayout()
        cell.layoutIfNeeded()
        let size: CGSize = cell.contentView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
        return CGSize(width: size.height, height: size.height)
    }
}

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
    
    let newsImageNames = ["news1.png", "news2.png", "news3.png", "news4.png"]
    let newsTitles = [
        "Citalopram Adjunctive to Stimulant May Be Effective for Youth With Chronic Irritability",
        "Adding citalopram to stimulants may benefit youth with severe irritability",
        "Citalopram May Reduce Negative Symptoms in First Episode Schizophrenia",
        "Global Citalopram Hydrobromide Market Forecast, Trend, Marketing Channels, Major Industry Participants And Strategies To 2024"
    ]
    let newsLinks = ["https://www.psychiatryadvisor.com/home/topics/child-adolescent-psychiatry/citalopram-adjunctive-to-stimulant-may-be-effective-for-youth-with-chronic-irritability/","https://www.healio.com/psychiatry/pediatrics/news/online/%7B25a6b1b7-b385-4bec-85aa-c7494393e5dc%7D/adding-citalopram-to-stimulants-may-benefit-youth-with-severe-irritability","https://www.psychiatryadvisor.com/home/schizophrenia-advisor/citalopram-may-reduce-negative-symptoms-in-first-episode-schizophrenia/","https://www.firstnewscolumnist.com/2019/07/03/global-citalopram-hydrobromide-market-maia-research-report/"]
    
    let drugsName = ["Aspirine", "Merckopram", "Citalopram", "Adderall"]
    let drugsRisk = [0,3,2,5]
    let drugsOnTrial = [false, true, false, false]

    override func viewDidLoad() {
        super.viewDidLoad()

        registerNib()
    }

    func registerNib() {
        let nib = UINib(nibName: NewsCell.nibName, bundle: nil)
        newsCollectionView?.register(nib, forCellWithReuseIdentifier: NewsCell.reuseIdentifier)
       
        if let flowLayout = self.newsCollectionView?.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.estimatedItemSize = CGSize(width: 0, height: 0)
        }
    }
}

extension MyDrugsVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return drugsName.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = drugsTableView.dequeueReusableCell(withIdentifier: "DrugsCell", for: indexPath) as! DrugsCell
        cell.name.text = drugsName[indexPath.row]
        let image = UIImage(named: drugsName[indexPath.row])
        cell.molecularImage.image = image
        
        if !drugsOnTrial[indexPath.row] {
            cell.onTrialIndicator.isHidden = true
            cell.attentionSign.isHidden = true
            cell.takeSurveyButton.isHidden = true
        }
        
        cell.delegate = self
        
        return cell
    }
    
    
}

extension MyDrugsVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return newsTitles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = newsCollectionView.dequeueReusableCell(withReuseIdentifier: NewsCell.reuseIdentifier, for: indexPath) as? NewsCell {
            let title = newsTitles[indexPath.row]
            let image = newsImageNames[indexPath.row]
            cell.configureCell(title: title, coverImage: image)
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

        let title = newsTitles[indexPath.row]
        let image = newsImageNames[indexPath.row]
        cell.configureCell(title: title, coverImage: image)
        
        cell.setNeedsLayout()
        cell.layoutIfNeeded()
        let size: CGSize = cell.contentView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
        return CGSize(width: size.width, height: 120)
    }
}

extension MyDrugsVC: TakeSurveyDelegate {
    func takeSurvey() {
        performSegue(withIdentifier: "showSurvey", sender: nil)
    }
}

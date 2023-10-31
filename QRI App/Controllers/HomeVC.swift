//
//  HomeVC.swift
//  QRI App
//
//  Created by Mazhar on 02/06/2021.
//

import UIKit
struct Services {
    var name:String?
    var image: String?
}

class HomeVC: UIViewController,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UICollectionViewDelegate {
    // MARK: - IBOutlets
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var servicesCV:
        UICollectionView!
    // MARK: - Variables
    var currentPage: Int = 0
    var myServices = [Services(name: "Testing\nServices", image: "menu tile_testing services"),Services(name: "Calibration\nServices", image: "menu tile_calibration services"),Services(name: "Proficiency testing\nServices", image: "menu tile_proficient testing"),Services(name: "Other\nServices", image: "menu tile_other services")]
   
    // MARK: - View life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        configurePackageCollectionView()
    }
    //MARK: - Button actions
    
    @IBAction func notificationBtnPressed(_ sender: Any) {
        let vc = allStoryBoards.NotificationsVC
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
    @IBAction func menuBtnPressed(_ sender: Any) {
        let vc = allStoryBoards.MenuVC
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
    // MARK: - Collectionview methods and delegates
    private func configurePackageCollectionView() {
        DispatchQueue.main.async {
            self.servicesCV.delegate = self
            self.servicesCV.dataSource = self
            let flowLayout = UPCarouselFlowLayout()
            flowLayout.itemSize = CGSize(width: mainScreenSize.width / 1.8, height: self.servicesCV.frame.size.height)
            flowLayout.scrollDirection = .horizontal
            flowLayout.sideItemScale = 0.8
            flowLayout.sideItemAlpha = 1.0
            flowLayout.spacingMode = .fixed(spacing: 6.0)
            self.servicesCV.collectionViewLayout = flowLayout
            self.servicesCV.reloadData()
        }
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return  myServices.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //self.downloadFiles()
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ServicesCVC", for: indexPath as IndexPath) as! ServicesCVC
        cell.contentView.layer.cornerRadius = 15
        cell.contentView.clipsToBounds = true
        let serviceObj = myServices[indexPath.row]
        cell.populateDate(myService: serviceObj)
        return cell
        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        var slug = ""
        if indexPath.row == 0 {
            slug = "testing-services"
            
        }
        else if indexPath.row == 1 {
            slug = "calibration-services"
            
        }
        else if indexPath.row == 2 {
            slug = "pt-services"
            
        }
        else {
            slug = "other-services"
        }
        
        let vc = allStoryBoards.ServicesVC
        vc.modalPresentationStyle = .fullScreen
        vc.slug = slug
        self.present(vc, animated: true, completion: nil)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let layout = self.servicesCV.collectionViewLayout as! UPCarouselFlowLayout
        let pageSide = (layout.scrollDirection == .horizontal) ? self.pageSize.width : self.pageSize.height
        let offset = (layout.scrollDirection == .horizontal) ? scrollView.contentOffset.x : scrollView.contentOffset.y
        currentPage = Int(floor((offset - pageSide / 2) / pageSide) + 1)
       // let pageNumber = round(scrollView.contentOffset.x / scrollView.frame.size.width)
        pageControl.currentPage = Int(currentPage)
    }
    
    fileprivate var pageSize: CGSize {
        let layout = self.servicesCV.collectionViewLayout as! UPCarouselFlowLayout
        var pageSize = layout.itemSize
        if layout.scrollDirection == .horizontal {
            pageSize.width += layout.minimumLineSpacing
        } else {
            pageSize.height += layout.minimumLineSpacing
        }
        return pageSize
    }
    
}

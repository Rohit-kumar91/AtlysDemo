//
//  ViewController.swift
//  AtlysDemoProject
//
//  Created by Rohit Kumar on 18/09/24.
//

import UIKit

final class ViewController: UIViewController {
  
  // MARK: - Defaults
  struct Defaults {
    static let itemHeight: CGFloat = 250
    static let itemWidth: CGFloat = 250
    static let collectionViewHeight: CGFloat = 250
    static let pageControlHeight: CGFloat = 10
  }
  
  // MARK: - Properties
  private var imageArray = [#imageLiteral(resourceName: "img1"), #imageLiteral(resourceName: "img2"), #imageLiteral(resourceName: "img3"), #imageLiteral(resourceName: "img4")]
  private let cellIdentifier = "carouselCell"
  
  private let carouselCollectionView: UICollectionView = {
    let layout = CarouselFlowLayout()
    layout.itemSize = CGSize(width: Defaults.itemWidth, height: Defaults.itemHeight)
    
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    collectionView.translatesAutoresizingMaskIntoConstraints = false
    collectionView.backgroundColor = .white
    collectionView.showsHorizontalScrollIndicator = false
    collectionView.decelerationRate = .fast
    return collectionView
  }()
  
  private var pageControl: UIPageControl = {
    let pageControl = UIPageControl()
    pageControl.translatesAutoresizingMaskIntoConstraints = false
    pageControl.currentPage = 0
    pageControl.pageIndicatorTintColor = .lightGray
    pageControl.currentPageIndicatorTintColor = .black
    return pageControl
  }()
  
  // MARK: - View LifeCycle Method
  override func viewDidLoad() {
    super.viewDidLoad()
    carouselCollectionView.delegate = self
    carouselCollectionView.dataSource = self
    carouselCollectionView.register(CarouselCell.self, forCellWithReuseIdentifier: cellIdentifier)
    view.addSubview(carouselCollectionView)
    
    pageControl.numberOfPages = imageArray.count
    view.addSubview(pageControl)
    setupConstraints()
  }
  
  // MARK: - Private Function
  // MARK: - Auto Layout Setup
  private func setupConstraints() {
    // CollectionView Constraints
    NSLayoutConstraint.activate([
      carouselCollectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      carouselCollectionView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
      carouselCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      carouselCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      carouselCollectionView.heightAnchor.constraint(equalToConstant: Defaults.collectionViewHeight)
    ])
    
    // PageControl Constraints
    NSLayoutConstraint.activate([
      pageControl.topAnchor.constraint(equalTo: carouselCollectionView.bottomAnchor, constant: Defaults.pageControlHeight),
      pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor)
    ])
  }
}

// MARK: - UICollectionViewDataSource
extension ViewController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return imageArray.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as? CarouselCell else {
      return UICollectionViewCell()
    }
    
    cell.imageView.image = imageArray[indexPath.row]
    return cell
  }
}

// MARK: - UICollectionViewDelegate, UIScrollViewDelegate
extension ViewController: UICollectionViewDelegate, UIScrollViewDelegate {
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    // Cell Selection.
  }
  
  func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
    let visibleRect = CGRect(origin: self.carouselCollectionView.contentOffset, size: self.carouselCollectionView.bounds.size)
    let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
    if let visibleIndexPath = self.carouselCollectionView.indexPathForItem(at: visiblePoint) {
      self.pageControl.currentPage = visibleIndexPath.row
    }
  }
}

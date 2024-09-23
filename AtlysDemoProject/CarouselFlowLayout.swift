//
//  CarouselFlowLayout 2.swift
//  AtlysDemoProject
//
//  Created by Rohit Kumar on 22/09/24.
//
import UIKit

final class CarouselFlowLayout: UICollectionViewFlowLayout {
  
  // MARK: - Properties
  private let itemScaleFactor: CGFloat = 0.7
  private let spacing: CGFloat = -50
  
  override func prepare() {
    super.prepare()
    scrollDirection = .horizontal
    minimumLineSpacing = spacing // Negative spacing for overlap
    let inset = (collectionView!.bounds.width - itemSize.width) / 2
    sectionInset = UIEdgeInsets(top: 0, left: inset, bottom: 0, right: inset)
  }
  
  // MARK: - UICollectionViewLayoutAttributes
  override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
    let attributesArray = super.layoutAttributesForElements(in: rect)
    guard let collectionView = collectionView else { return attributesArray }
    
    let centerX = collectionView.contentOffset.x + collectionView.bounds.width / 2
    
    attributesArray?.forEach { attributes in
      let distanceFromCenter = abs(attributes.center.x - centerX)
      let scale = max(1 - (distanceFromCenter / collectionView.bounds.width) * (1 - itemScaleFactor), itemScaleFactor)
      attributes.transform = CGAffineTransform(scaleX: scale, y: scale)
      attributes.zIndex = Int(scale * 100)
    }
    return attributesArray
  }
  
  override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
    return true
  }
  
  override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint,
                                    withScrollingVelocity velocity: CGPoint) -> CGPoint {
    guard let collectionView = collectionView else { return proposedContentOffset }
    
    let collectionViewBounds = collectionView.bounds
    let halfWidth = collectionViewBounds.size.width / 2
    let proposedContentOffsetCenterX = proposedContentOffset.x + halfWidth
    
    let attributesArray = layoutAttributesForElements(in: collectionViewBounds)
    
    let closest = attributesArray?.sorted {
      abs($0.center.x - proposedContentOffsetCenterX) < abs($1.center.x - proposedContentOffsetCenterX)
    }.first ?? UICollectionViewLayoutAttributes()
    
    let targetContentOffset = CGPoint(x: closest.center.x - halfWidth, y: proposedContentOffset.y)
    return targetContentOffset
  }
}

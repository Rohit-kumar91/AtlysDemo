//
//  CarouselCell.swift
//  AtlysDemoProject
//
//  Created by Rohit Kumar on 22/09/24.
//

import UIKit

final class CarouselCell: UICollectionViewCell {
  
  // MARK: - Properties
  let imageView: UIImageView = {
    let imgView = UIImageView()
    imgView.contentMode = .scaleAspectFill
    imgView.clipsToBounds = true
    imgView.translatesAutoresizingMaskIntoConstraints = false
    return imgView
  }()
  
  // MARK: - init
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    contentView.addSubview(imageView)
    NSLayoutConstraint.activate([
      imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
      imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
      imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
      imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
    ])
    
    contentView.layer.cornerRadius = 15
    contentView.layer.masksToBounds = true
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

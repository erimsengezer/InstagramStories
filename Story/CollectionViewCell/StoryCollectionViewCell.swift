//
//  StoryCollectionViewCell.swift
//  Story
//
//  Created by Erim Şengezer on 11.08.2022.
//

import UIKit

class StoryCollectionViewCell: UICollectionViewCell {

    
    @IBOutlet weak var imageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureView()
    }
    
    private func configureView() {
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = imageView.frame.width / 2
    }
    
    func configureCell(imageString: String) {
        imageView.image = UIImage(named: imageString)
    }

}

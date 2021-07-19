//
//  ImagePickerCollectionViewCell.swift
//  ImageScreensApp
//
//  Created by Viacheslav Markov on 13.07.2021.
//

import UIKit

class ImagePickerCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    
    static let identifier = "ImagePickerCollectionViewCell"
    
//    override func awakeFromNib() {
//        super.awakeFromNib()
//        setupPickerView()
//    }

    static func nib() -> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    func configure(with image: UIImage) {
        imageView.image = image
    }
    
//    private func setupPickerView(with list: [String]) {
//
//        let reusablePickerViewModel = ReusablePickerViewModel(with: list,
//                                                              at: (widthView: Float(contentView.bounds.width * 0.4),
//                                                                   heightView: Float(contentView.bounds.height * 0.4)),
//                                                              numberOfComponents: 2)
//
//        imagePickerView.configure(reusablePickerViewModel: reusablePickerViewModel)
//    }
}

//
//  ImageView.swift
//  ImageScreensApp
//
//  Created by Viacheslav Markov on 12.07.2021.
//

import UIKit

class ImageView: UIView {
    
    private let imageView = UIImageView()

    func configure(with image: UIImage) -> UIView {
        let imageView = ImageView()
        imageView.imageView.image = image
        return imageView
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupImageView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupImageView()
    }
    
    private func setupImageView() {
        addSubview(imageView)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            imageView.heightAnchor.constraint(equalTo: heightAnchor),
            imageView.widthAnchor.constraint(equalTo: widthAnchor)
        ])
        
        imageView.contentMode = .scaleAspectFit
    }    
}

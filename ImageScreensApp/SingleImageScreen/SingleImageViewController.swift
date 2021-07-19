//
//  MainViewController.swift
//  ImageScreensApp
//
//  Created by Viacheslav Markov on 12.07.2021.
//

import UIKit

class SingleImageViewController: UIViewController {

    @IBOutlet var imagePickerView: ReusablePickerView!
    
    var singleImageViewModel = SingleImageViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupPickerView()
    }

    private func setupPickerView() {
        
        let reusablePickerViewModel = ReusablePickerViewModel(with: singleImageViewModel.listImageString,
                                                              at: (widthView: Float(view.bounds.width * 0.8),
                                                                   heightView: Float(view.bounds.height * 0.8)),
                                                              numberOfComponents: 1)
        
        imagePickerView.configure(reusablePickerViewModel: reusablePickerViewModel)
        
    }
}


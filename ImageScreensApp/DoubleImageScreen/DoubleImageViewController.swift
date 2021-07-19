//
//  DoubleImageViewController.swift
//  ImageScreensApp
//
//  Created by Viacheslav Markov on 12.07.2021.
//

import UIKit

class DoubleImageViewController: UIViewController {
    
    @IBOutlet weak var doublePickerView: ReusablePickerView!
    
    var doubleImageViewModel = DoubleImageViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupPickerView()
    }
    
    private func setupPickerView() {
        
        let reusablePickerViewModel = ReusablePickerViewModel(with: doubleImageViewModel.listImageString,
                                                              at: (widthView: Float(view.bounds.width * 0.4),
                                                                   heightView: Float(view.bounds.height * 0.4)),
                                                              numberOfComponents: 2)
        
        doublePickerView.configure(reusablePickerViewModel: reusablePickerViewModel)
    }
}

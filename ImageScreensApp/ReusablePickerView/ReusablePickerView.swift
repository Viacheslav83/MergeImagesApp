//
//  ReusablePickerView.swift
//  ImageScreensApp
//
//  Created by Viacheslav Markov on 12.07.2021.
//

import UIKit

class ReusablePickerView: UIPickerView {
    
    var reusablePickerViewModel: ReusablePickerViewModel!
    private let loopingMargin: Int = 100

    var imageView = ImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupPickerView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupPickerView()
    }
    
    func configure(reusablePickerViewModel: ReusablePickerViewModel) {
        self.reusablePickerViewModel = reusablePickerViewModel
    }
    
    private func setupPickerView() {
        
        addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            imageView.heightAnchor.constraint(equalTo: heightAnchor),
            imageView.widthAnchor.constraint(equalTo: widthAnchor)
        ])

        self.delegate = self
        self.dataSource = self
    }
}

extension ReusablePickerView: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let index = reusablePickerViewModel.indexedLoop(at: row)
        guard let image = UIImage(named: reusablePickerViewModel.list[index]) else { return UIView() }
        return imageView.configure(with: image)
    }
    
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return CGFloat(reusablePickerViewModel?.getSizePickerView().widthView ?? 0)
    }

    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return CGFloat(reusablePickerViewModel?.getSizePickerView().heightView ?? 0)
    }
}

extension ReusablePickerView: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return reusablePickerViewModel?.getNumberOfComponents() ?? 0
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return loopingMargin * reusablePickerViewModel.getNumberRowsInComponent()
    }
}

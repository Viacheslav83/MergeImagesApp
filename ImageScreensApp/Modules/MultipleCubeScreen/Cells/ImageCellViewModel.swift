//
//  ImageCellViewModel.swift
//  ImageScreensApp
//
//  Created by Viacheslav Markov on 30.07.2021.
//

import UIKit

class ImageCellViewModel {
    
    var selectedCellIndex: Int
    var currentImageName: String
    var listImageNames = [String]()
    
    var currentImageIndex = -1
    private var nextImageNameIndex: Int = -1
    
    init(imageName: String, cellIndex: Int, listNames: [String]) {
        currentImageName = imageName
        selectedCellIndex = cellIndex
        listImageNames = listNames
    }
    
    private func getCurrentIndexImage() {
        currentImageIndex = listImageNames.firstIndex(of: currentImageName) ?? -1
    }
    
    func getNextIndexImage() -> Int {
        getCurrentIndexImage()
        nextImageNameIndex = listImageNames.getNextIndex(currentImageIndex)
        return nextImageNameIndex
    }
    
    func getPreviousIndexImage() -> Int {
        getCurrentIndexImage()
        nextImageNameIndex = listImageNames.getPreviousIndex(currentImageIndex)
        return nextImageNameIndex
    }
    
    func setCurrentImageName() {
        currentImageName = listImageNames[nextImageNameIndex]
    }
}

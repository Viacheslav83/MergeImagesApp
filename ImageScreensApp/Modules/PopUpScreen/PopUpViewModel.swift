//
//  PopUpViewModel.swift
//  ImageScreensApp
//
//  Created by Viacheslav Markov on 22.07.2021.
//

import Foundation

class PopUpViewModel {
    
    let originListImageNames: [String]
    var selectedImageName: String
    var cellIndex: Int
    
    var nextImageNameIndex = -1
    private var currentImageIndex = -1
    
    init(selectedImageString: String, indexCell: Int, originImageStringList: [String]) {
        self.cellIndex = indexCell
        self.selectedImageName = selectedImageString
        self.originListImageNames = originImageStringList
    }
    
    private func getCurrentImageIndex() {
        currentImageIndex = originListImageNames.firstIndex(of: selectedImageName) ?? -1
    }
    
    func getNextImageIndex() -> Int {
        getCurrentImageIndex()
        nextImageNameIndex = originListImageNames.getNextIndex(currentImageIndex)
        return nextImageNameIndex
    }
    
    func getPreviousImageIndex() -> Int {
        getCurrentImageIndex()
        nextImageNameIndex = originListImageNames.getPreviousIndex(currentImageIndex)
        return nextImageNameIndex
    }
    
    func setCurrentImageName() {
        selectedImageName = originListImageNames[nextImageNameIndex]
    }
}

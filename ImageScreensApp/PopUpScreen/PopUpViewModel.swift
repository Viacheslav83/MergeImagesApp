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
    private var nextIndexImageName: Int?
    var indexCell: Int
    
    init(selectedImageString: String, indexCell: Int, originImageStringList: [String]) {
        self.indexCell = indexCell
        self.selectedImageName = selectedImageString
        self.originListImageNames = originImageStringList
    }
    
    func setImageString(with imageString: String) {
        selectedImageName = imageString
    }
    
    func setNextIndex(with index: Int) -> Int {
        nextIndexImageName = index
        return nextIndexImageName ?? 0
    }
}

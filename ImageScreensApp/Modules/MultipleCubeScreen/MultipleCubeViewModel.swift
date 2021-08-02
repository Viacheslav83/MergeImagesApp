//
//  MultipleCubeViewModel.swift
//  ImageScreensApp
//
//  Created by Viacheslav Markov on 22.07.2021.
//

import Foundation

class MultipleCubeViewModel {
    
    var originListImageNames: [String]
    var listImageNames: [String]
    var selectedIndexCell: Int?
    
    private var list = ListImageRepository()
    
    init () {
        originListImageNames = list.avatar
        listImageNames = list.avatar.shuffled()
    }
    
    func setNewImage(with imageName: String) {
        if let index = selectedIndexCell {
            listImageNames[index] = imageName
        }
    }
    
    func setIndexCell(at indexCell: Int) {
        selectedIndexCell = indexCell
    }
    
    func isEqualTwoArrays() -> Bool {
        return originListImageNames == listImageNames
    }
    
    private func setNewListImageNames(with list: [String]) {
        originListImageNames = list
        listImageNames = list.shuffled()
    }
    
    func getNumberOfLines() -> Int {
        let count = sqrt(Double(originListImageNames.count))
        return Int(count)
    }
    
    func setListImageNames(with index: Int) {
        listImageNames = []
        switch index {
        case 0:
            setNewListImageNames(with: list.avatar)
        case 1:
            setNewListImageNames(with: list.pyramid)
        case 2:
            setNewListImageNames(with: list.redCharlie)
        case 3:
            setNewListImageNames(with: list.redCube)
        default: break
        }
    }
    
    func getFullImage(at index: Int) -> String {
        var imageName = ""
        switch index {
        case 0:
            imageName = "avatar"
        case 1:
            imageName = "pyramid"
        case 2:
            imageName = "redCharlie"
        case 3:
            imageName = "redCube"
        default: break
        }
        return imageName
    }
}

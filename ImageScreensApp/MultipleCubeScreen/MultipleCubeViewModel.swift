//
//  MultipleCubeViewModel.swift
//  ImageScreensApp
//
//  Created by Viacheslav Markov on 22.07.2021.
//

import Foundation

class MultipleCubeViewModel {
    
    var originImageStringList = ["avatar_part_001", "avatar_part_002", "avatar_part_003",
                                 "avatar_part_004", "avatar_part_005", "avatar_part_006",
                                 "avatar_part_007", "avatar_part_008", "avatar_part_009"]
    var imageStringList = [String]()
    var selectedIndexCell: Int?
    
    init () {
        imageStringList = originImageStringList.shuffled()
    }
    
    func setNewImage(with imageName: String) {
        if let index = selectedIndexCell {
            imageStringList[index] = imageName
        }
    }
    
    func setIndexCell(at index: Int) {
        selectedIndexCell = index
    }
    
//    func setIndexImage(at index: Int) {
//        selectedIndexImage = index
//    }
}

//
//  PopUpViewModel.swift
//  ImageScreensApp
//
//  Created by Viacheslav Markov on 22.07.2021.
//

import Foundation

class PopUpViewModel {
    
    let imageStringList = ["avatar_part_001", "avatar_part_002", "avatar_part_003",
                           "avatar_part_004", "avatar_part_005", "avatar_part_006",
                           "avatar_part_007", "avatar_part_008", "avatar_part_009"]
    var selectedImageString: String
    var nextIndex: Int?
    var indexCell: Int
    
    init(selectedImageString: String, indexCell: Int) {
        self.indexCell = indexCell
        self.selectedImageString = selectedImageString
    }
    
    func setImageString(with imageString: String) {
        selectedImageString = imageString
    }
    
    func setNextIndex(with index: Int) -> Int {
        nextIndex = index
        return nextIndex ?? 0
    }
}

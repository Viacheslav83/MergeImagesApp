//
//  CollectionImageViewModel.swift
//  ImageScreensApp
//
//  Created by Viacheslav Markov on 14.07.2021.
//

import Foundation

class CollectionImageViewModel {
    
    let leftListImageString = ["img1", "img2", "img3", "img4", "img5", "img6", "img7", "img8"]
    let rightListImageString = ["img8", "img7", "img6", "img5", "img4", "img3", "img2", "img1"]
    
    func indexedLoop(at index: Int, list: [String]) -> Int {
        return index > (list.count - 1) ? index % (list.count - 1) : index
      }
}

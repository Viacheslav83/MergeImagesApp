//
//  Extension+Array.swift
//  ImageScreensApp
//
//  Created by Viacheslav Markov on 26.07.2021.
//

import Foundation

extension Array {
    func getNextIndex(_ index: Int) -> Int {
        let newIndex = index + 1
        return newIndex == self.count ? 0 : newIndex
    }
    
    func getPreviousIndex(_ index: Int) -> Int {
        let newIndex = index - 1
        return newIndex == -1 ? self.count - 1 : newIndex
    }
    
//    func setRandomArray() -> [Element] {
//        return self.randomElement() as! [Element]
//    }
}

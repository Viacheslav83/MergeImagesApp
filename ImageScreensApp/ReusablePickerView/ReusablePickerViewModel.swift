//
//  ReusablePickerViewModel.swift
//  ImageScreensApp
//
//  Created by Viacheslav Markov on 13.07.2021.
//

import Foundation

class ReusablePickerViewModel {
    
    var list = [String]()
    var numberOfComponents: Int
    var size: (widthView: Float, heightView: Float)
    
    init (with list: [String],
          at size: (widthView: Float, heightView: Float),
          numberOfComponents: Int)
    {
        self.list = list
        self.size = size
        self.numberOfComponents = numberOfComponents
    }
    
    func getNumberRowsInComponent() -> Int {
        return list.count
    }
    
    func getNumberOfComponents() -> Int {
        return numberOfComponents
    }
    
    func getSizePickerView() -> (widthView: Float, heightView: Float) {
        return size
    }
    
    func indexedLoop(at row: Int) -> Int {
        return row > (list.count - 1) ? row % (list.count - 1) : row
      }
}

//
//  TimerData.swift
//  CoreDataPublicClassTest
//
//  Created by Paul Krakow on 1/26/21.
//
// This file creates dummy data for the test


import Foundation
import Combine

class TimerData : ObservableObject {
    
    // @Published property allows objects to be observed from views elsewhere in the project
    @Published var timeCount = 0
    var timer : Timer?
    
    init() {
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(timerDidFire), userInfo: nil, repeats: true)
    }
    
    @objc func timerDidFire() {
        timeCount += 1
    }
    
    func resetCount() {
        timeCount = 0
    }
}

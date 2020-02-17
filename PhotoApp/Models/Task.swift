//
//  Task.swift
//  PhotoApp
//
//  Created by Hernandez, Ronald on 2/16/20.
//  Copyright © 2020 Ronaldoh1. All rights reserved.
//

import Foundation

enum Priority: Int {
    
    case high
    case medium
    case low
    
}

struct Task {
    
    let title: String
    let priority: Priority
    
}

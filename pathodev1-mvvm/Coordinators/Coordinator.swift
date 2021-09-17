//
//  Coordinator.swift
//  pathodev1-mvvm
//
//  Created by erdem öden on 25.08.2021.
//

import Foundation
import UIKit
enum Event{
    case TableCellSelected
}
protocol Coordinator:AnyObject{
    var ChildCoordinators:[Coordinator]{ get }
    func Start()
}

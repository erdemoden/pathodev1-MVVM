//
//  DetailsVControllerVModel.swift
//  pathodev1-mvvm
//
//  Created by erdem öden on 16.08.2021.
//

import Foundation
import CoreData
import UIKit
class DetailsVModel
{
    //MARK: - Variables
    var CoreDProcess = CoreDProcessDetail()
    var HarryData:HarryMod?
    var FavArray:[Favourites]?
    var Coordinator:DetailsCoordinator?
    init(HarryData:HarryMod,FavArray:[Favourites]) {
        self.HarryData = HarryData
        self.FavArray = FavArray
    }
    // MARK: - Result function for determine the heartbut image in detailsvcontroller when clicked the button
    func Result(Name:String) -> Int{
        return CoreDProcess.UpDateFavs(Name: Name)
    }
    func Disappear(){
        Coordinator?.DidFinished()
    }
}

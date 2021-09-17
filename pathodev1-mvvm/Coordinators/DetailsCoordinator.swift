//
//  DetailsCoordinator.swift
//  pathodev1-mvvm
//
//  Created by erdem öden on 7.09.2021.
//

import Foundation
import UIKit
class DetailsCoordinator : Coordinator{
    var ChildCoordinators: [Coordinator] = []
    var ParentCoordinator:MainCoordinator?
    let NavigationController:UINavigationController
    let HarryData : HarryMod?
    var FavArray :[Favourites];
    init(navigationcontroller:UINavigationController,HarryData:HarryMod,FavArray:[Favourites]) {
        self.NavigationController = navigationcontroller
        self.HarryData = HarryData
        self.FavArray = FavArray
    }
    func Start() {
        let StoryBoard = UIStoryboard(name: "Details", bundle: .main);
        let DetailsVC = StoryBoard.instantiateViewController(identifier: "tosecondvc") as! DetailsVController
        DetailsVC.DetailsViewModel = DetailsVModel(HarryData: HarryData!, FavArray: FavArray)
        DetailsVC.Delegate = NavigationController.viewControllers[0] as! ViewController
        DetailsVC.DetailsViewModel?.Coordinator = self
        NavigationController.pushViewController(DetailsVC, animated: true)
    }
    func DidFinished(){
        ParentCoordinator?.ChildDidFinished(self)
    }
    
}


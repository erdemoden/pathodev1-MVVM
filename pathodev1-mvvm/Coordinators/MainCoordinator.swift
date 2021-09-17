//
//  MainCoordinator.swift
//  pathodev1-mvvm
//
//  Created by erdem öden on 7.09.2021.
//

import Foundation
import UIKit
protocol GoingBackFromDetails{
    func UpdateTable();
}
class MainCoordinator:Coordinator{
    var Delegate : GoingBackFromDetails!
    var ChildCoordinators: [Coordinator] = []
    let NavigationController:UINavigationController
    init(NavigationController:UINavigationController) {
        self.NavigationController = NavigationController
    }
    func Start() {
        let StoryBoard = UIStoryboard(name: "Main", bundle: .main)
        let ViewController = StoryBoard.instantiateViewController(identifier: "Main") as! ViewController
        ViewController.VModel.Coordinator = self
        NavigationController.setViewControllers([ViewController], animated: false)
    }
    // MARK: - Starting the DetailsCorrdinator
    func startAddEvent(HarryData:HarryMod,FavArray:[Favourites]){
        let DetailsCoordinator = DetailsCoordinator(navigationcontroller: NavigationController, HarryData: HarryData, FavArray: FavArray)
        DetailsCoordinator.ParentCoordinator = self
        ChildCoordinators.append(DetailsCoordinator)
        DetailsCoordinator.Start()
    }
    // MARK: - Deleting Child Coordinator From ChildCoordinators Array
    func ChildDidFinished(_ ChildCoordinator:Coordinator){
        if let index = ChildCoordinators.firstIndex(where: { coordinator -> Bool in
            return ChildCoordinator === coordinator
        })
        {
            ChildCoordinators.remove(at: index)
        }
    }
    
    
}

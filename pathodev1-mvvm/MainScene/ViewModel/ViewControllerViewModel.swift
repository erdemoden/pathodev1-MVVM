//
//  HarryViewModel.swift
//  pathodev1-mvvm
//
//  Created by erdem öden on 14.08.2021.
//

import Foundation
import CoreData
import UIKit
protocol UpdateTableView{
    func ReloadTableView()
}
class VControllerVModel{
    
    // MARK: - Models
    var HarryArray = [HarryMod]()
    var FavArray = [Favourites]()
    
    // MARK: - Other Variables
    var Proto:UpdateTableView!
    var CoreDProcess = CoreDProcessMain()
    var Coordinator:MainCoordinator?
    //DESCRIPTION: - Functions For ViewController Class
    // MARK: - Function for updating table when app is opening
    func ApiCall(){
        let Url = URL(string: "http://hp-api.herokuapp.com/api/characters")!
        let Request = URLSession.shared.dataTask(with: Url){(Data,Response,Error) in
            if(Error != nil){
                print("olmadı")
                // viewcontroller alert
            }
            else{
                if(Data != nil){
                    do{
                        self.HarryArray = try JSONDecoder().decode([HarryMod].self, from: Data!)
                        DispatchQueue.main.async { [self] in
                            self.FavArray = CoreDProcess.FavarayUpdate()
                            Proto.ReloadTableView()
                        }
                    }
                    catch{
                        print("error")
                    }
                }
            }
        }
        Request.resume()
    }
    
    // MARK: - Clicked Function for heart button on the cell
    func Clicked(Index:Int = -1,Character:String = ""){
        if(Index != -1){
            self.FavArray.remove(at: Index);
            CoreDProcess.DeleteFav(Character: Character)
        }
        else{
            let Fav = Favourites(Character: Character);
            FavArray.append(Fav);
            CoreDProcess.AddNewFav(Character: Character)
        }
    }
}


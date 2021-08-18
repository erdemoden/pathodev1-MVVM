//
//  HarryViewModel.swift
//  pathodev1-mvvm
//
//  Created by erdem öden on 14.08.2021.
//

import Foundation
import CoreData
import UIKit
class VControllerVModel{
    
    // MARK: - Models
var HarryArray = [HarryMod]()
var FavArray = [Favourites]()

 // MARK: - Other Variables
    let AppDelegate:AppDelegate!
    let Context:NSManagedObjectContext!
    
    //MARK: - init()
    init() {
        self.AppDelegate = UIApplication.shared.delegate as? AppDelegate
        self.Context = self.AppDelegate.persistentContainer.viewContext
    }
    
    //DESCRIPTION: - Functions For ViewController Class
    // MARK: - Function for updating table when app is opening
    func ApiCall(completed: @escaping ()->()){
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
                        let Fetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Favs")
                        Fetch.returnsObjectsAsFaults = false
                        do{
                            let Results = try self.Context.fetch(Fetch)
                            for Result in Results as![NSManagedObject]{
                                if(Result.value(forKey: "image") != nil){
                                    let Forward = Favourites(Character: (Result.value(forKey: "image") as! String))
                                    self.FavArray.append(Forward)
                                }
                            }
                        }
                        catch{
                            print("error")
                            
                        }
                        completed()
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
        let Entity = NSEntityDescription.insertNewObject(forEntityName: "Favs", into: Context);
        
        if(Index != -1){
        self.FavArray.remove(at: Index);
        let Fetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Favs")
        Fetch.predicate = NSPredicate(format: "image == %@", Character)
                    Fetch.returnsObjectsAsFaults = false
                do{
                        let Results = try Context.fetch(Fetch)
                        for Result in Results as! [NSManagedObject]{
                            Context.delete(Result)
                        }
                        do{
                            try Context.save()
                        }
                        catch{
                            print("error")
                        }
                    }
                    catch{
                        print("error")
                    }
        }
        else{
            let Fav = Favourites(Character: Character);
            FavArray.append(Fav);
            Entity.setValue(Character, forKey: "image")
            
            do{
                try Context.save()
            }
            catch{
                print("error")
            }
        }
    }
}


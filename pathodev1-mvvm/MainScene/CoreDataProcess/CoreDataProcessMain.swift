//
//  CoreDataProcess.swift
//  pathodev1-mvvm
//
//  Created by erdem öden on 24.08.2021.
//

import Foundation
import CoreData
import UIKit
class CoreDProcessMain {
    // MARK: - Appdelegate And Context one init for initialize them
    let AppDelegate:AppDelegate!
    let Context:NSManagedObjectContext!
    init() {
        self.AppDelegate = UIApplication.shared.delegate as? AppDelegate
        self.Context = AppDelegate.persistentContainer.viewContext
    }
    // MARK: - Updating FavOurites model in ViewControllerViewModel
    func FavarayUpdate() -> [Favourites]{
        var Favs = [Favourites]()
        let Fetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Favs")
        Fetch.returnsObjectsAsFaults = false
        do{
            let Results = try self.Context.fetch(Fetch)
            for Result in Results as![NSManagedObject]{
                if(Result.value(forKey: "image") != nil){
                    let Forward = Favourites(Character: (Result.value(forKey: "image") as! String))
                    Favs.append(Forward)
                }
            }
        }
        catch{
            print("error")
            
        }
        return Favs
        
    }
    // MARK: - Deleting Character From Core Data
    func DeleteFav(Character:String){
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
    // MARK: - Adding Character To Core Data As Favourite Character
    func AddNewFav(Character:String){
        let Entity = NSEntityDescription.insertNewObject(forEntityName: "Favs", into: Context);
        Entity.setValue(Character, forKey: "image")
        do{
            try Context.save()
        }
        catch{
            print("error")
        }
    }
}

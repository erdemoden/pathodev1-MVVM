//
//  CoreDataProcessDetail.swift
//  pathodev1-mvvm
//
//  Created by erdem öden on 27.08.2021.
//
import Foundation
import CoreData
import UIKit
class CoreDProcessDetail {
    let AppDelegate:AppDelegate!
    let Context:NSManagedObjectContext!
    init() {
        self.AppDelegate = UIApplication.shared.delegate as? AppDelegate
        self.Context = AppDelegate.persistentContainer.viewContext
    }
    // MARK: - Updating Coredata When Heartbut Clicked In Details ViewController
    func UpDateFavs(Name:String) -> Int{
        let Fetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Favs")
        Fetch.predicate = NSPredicate(format: "image == %@",Name)
        do{
            let Results = try self.Context.fetch(Fetch)
            
            if(Results.count > 0){
                for Result in Results as! [NSManagedObject]{
                    self.Context.delete(Result)
                }
                do{
                    try self.Context.save()
                }
                catch{
                    print("error")
                }
                return Results.count
            }
            else{
                let Entity = NSEntityDescription.insertNewObject(forEntityName: "Favs", into: self.Context)
                Entity.setValue(Name, forKey: "image")
                do{
                    try self.Context.save()
                }
                catch{
                    print("error")
                }
                return 0
            }
            
        }
        catch{
            print("Error")
        }
        return 0
    }
    
}

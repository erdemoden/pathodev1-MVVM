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
    let AppDelegate:AppDelegate!
    let Context:NSManagedObjectContext!
    // MARK: - init()
    init() {
        self.AppDelegate = UIApplication.shared.delegate as! AppDelegate
        self.Context = self.AppDelegate.persistentContainer.viewContext
    }
    
    
    // MARK: - Result function for determine the heartbut image in detailsvcontroller when clicked the button
    func Result(Name:String) -> Int{
        do{
            let Fetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Favs")
            Fetch.predicate = NSPredicate(format: "image == %@",Name)
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
            
    }
        catch{
            print("error")
        }
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

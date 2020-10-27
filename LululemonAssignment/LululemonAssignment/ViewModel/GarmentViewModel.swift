//
//  GarmentViewModel.swift
//  LululemonAssignment
//
//  Created by Eugene Berezin on 10/27/20.
//

import Foundation
import CoreData
import UIKit

class GarmentViewModel {
    var garmentsList: [Garments] = []
    
    init() {}
    
    func saveData(garmentName:String){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        let userEntity = NSEntityDescription.entity(forEntityName: "Garment", in: managedContext)!
        let user = NSManagedObject(entity: userEntity, insertInto: managedContext)
        user.setValue(Date(), forKey: "createdDate")
        user.setValue(garmentName, forKey: "garmentName")
        do {
            try managedContext.save()
            
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    func retrieveData() {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Garment")
        do {
            garmentsList = [Garments]()
            let result = try managedContext.fetch(fetchRequest)
            for data in result as! [NSManagedObject] {
                var garment = Garments()
                garment.garmentName = data.value(forKey: "garmentName") as! String
                garment.addedDate = data.value(forKey: "createdDate") as! Date
                garmentsList.append(garment)
            }
            
        } catch {
            print(error)
        }
    }
}




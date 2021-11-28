//
//  CoreDataWrapper.swift
//  Zivame
//
//  Created by Rabi on 28/11/21.
//

import Foundation
import UIKit
import CoreData

public class CoreDataWrapper {
    
    init() {}
        
    func add(_ product: Product) {
        
        if isExist(name: product.name ?? "") { return }
        
        let delegate = UIApplication.shared.delegate as! AppDelegate
        let context = delegate.persistentContainer.viewContext
        
        if let entity = NSEntityDescription.entity(forEntityName: "Cart", in: context) {
            let productObject = NSManagedObject(entity: entity, insertInto: context)
            productObject.setValue(product.name, forKey: "name")
            productObject.setValue(product.imageURL, forKey: "imageURL")
            productObject.setValue(product.rating, forKey: "rating")
            productObject.setValue(product.price, forKey: "price")

            do {
               try context.save()
              } catch {
               debugPrint("Failed saving")
            }
        }
    }
    
    func isExist(name: String) -> Bool {
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Cart")
        fetchRequest.predicate = NSPredicate(format: "name = %@", name)
        
        let delegate = UIApplication.shared.delegate as! AppDelegate
        let context = delegate.persistentContainer.viewContext
        
        guard let result = try? context.fetch(fetchRequest) else { return false }
        return result.count > 0 ? true : false
        
    }

    
    func getCartItems() -> [Product] {
        let fetchRequest: NSFetchRequest<Cart> = Cart.fetchRequest()
        let delegate = UIApplication.shared.delegate as! AppDelegate
        let context = delegate.persistentContainer.viewContext
        let result = try? context.fetch(fetchRequest)
        var products : [Product] = []
        for item in result  ?? [] {
            let product = Product.init(name: item.name, price: item.price, imageURL: item.imageURL, rating: Int(item.rating))
            products.append(product)
        }
        return products
    }
    
    func delete(_ product: Product) {
        let delegate = UIApplication.shared.delegate as! AppDelegate
        let context = delegate.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Cart")
        fetchRequest.predicate = NSPredicate.init(format: "name == %@", product.name ?? "")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        do {
            try context.execute(deleteRequest)
        } catch  {
            debugPrint(error.localizedDescription)
        }

    }
    
    func emptyCart() {
        let delegate = UIApplication.shared.delegate as! AppDelegate
        let context = delegate.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Cart")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        do {
            try context.execute(deleteRequest)
        } catch  {
            debugPrint(error.localizedDescription)
        }
    }
    
    
}

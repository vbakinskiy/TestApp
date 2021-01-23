//
//  ProductEntity+CoreDataProperties.swift
//  
//
//  Created by Vyacheslav Bakinskiy on 1/22/21.
//
//

import Foundation
import CoreData


extension ProductEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ProductEntity> {
        return NSFetchRequest<ProductEntity>(entityName: "ProductEntity")
    }

    @NSManaged public var name: String?
    @NSManaged public var price: String?
    @NSManaged public var descript: String?
    @NSManaged public var productId: String?
    @NSManaged public var imageUrl: String?

}

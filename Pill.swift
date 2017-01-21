//
//  Pill.swift
//  SimpillPage
//
//  Created by Mason Swofford on 4/19/16.
//  Copyright © 2016 Mason Swofford. All rights reserved.
//

import UIKit

class Pill: NSObject, NSCoding {
    
    // MARK: Properties
    
    var name: String
    var instructions: String
    var dispensionTime: Date?
    var pillsRemaining: Int8
    
    // MARK: Archiving Paths
    
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("pills")
    
    // MARK: Types
    
    struct PropertyKey {
        static let nameKey = "name"
        static let  instructionsKey = "instructions"
        static let dispensionTimeKey = "dispensionTime"
        static let pillsRemainingKey = "pillsRemaining"
    }
    
    // MARK: Initialization
    
    init? (name: String, instructions: String, dispensionTime: Date?, pillsRemaining: Int8)
    {
        self.name = name
        self.instructions = instructions
        self.dispensionTime = dispensionTime
        self.pillsRemaining = pillsRemaining
        
        super.init()
        
        if ( name.isEmpty || pillsRemaining < 0)
        {
            return nil
        }
    }
    
    // MARK: NSCoding
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: PropertyKey.nameKey)
        aCoder.encode(instructions, forKey: PropertyKey.instructionsKey)
        aCoder.encode(dispensionTime, forKey: PropertyKey.dispensionTimeKey)
        aCoder.encode(Int(pillsRemaining), forKey: PropertyKey.pillsRemainingKey)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let name = aDecoder.decodeObject(forKey: PropertyKey.nameKey) as! String
        
        // Because photo is an optional property of Meal, use conditional cast.
        let instructions = aDecoder.decodeObject(forKey: PropertyKey.instructionsKey) as! String
        
        let dispensionTime = aDecoder.decodeObject(forKey: PropertyKey.dispensionTimeKey) as? Date
        
        let pillsRemaining = aDecoder.decodeInteger(forKey: PropertyKey.pillsRemainingKey)
        
        // Must call designated initializer.
        self.init(name: name, instructions: instructions, dispensionTime: dispensionTime, pillsRemaining: Int8(pillsRemaining))
    }
    
    
}

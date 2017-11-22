//
//  RealmViewController.swift
//  Swift4Playground
//
//  Created by Munesada Yohei on 2017/11/22.
//  Copyright © 2017 Munesada Yohei. All rights reserved.
//

/*
    Realm Sample.
 
    References:
        - https://github.com/realm/realm-cocoa
        - https://realm.io/docs/swift/latest/
        - https://qiita.com/okitsutakatomo/items/9134c5fa8bd4384a2acf (Japanese)
 
    Install (Using CocoaPods):
        - pod 'RealmSwift'
 */


import UIKit
import RealmSwift

class RealmViewController: UIViewController {
    
    override func viewDidLoad() {
        self.title = "Realm Sample"
        self.view.backgroundColor = UIColor.white
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        useRealm()
    }
    
    func useRealm() {
        
        // Migration Sample.
        realmMigration()
        
        let myDog = Dog()
        myDog.name = "Reon"
        myDog.age = 0
        
        // Get the defaul Realm.
        let realm = try! Realm()
        
        // Find.
        let puppies = realm.objects(Dog.self).filter("age <= 1")
        print("puppies count = \(puppies.count)")  // 0
        
        // Save.
        try! realm.write {
            realm.add(myDog)
        }
        
        // Queries are updated in realtime.
        print("puppies count = \(puppies.count)")  // 1
        
        // Query and update from any thread.
        DispatchQueue(label: "background").async {
            autoreleasepool {
                let realm = try! Realm()
                let aDog = realm.objects(Dog.self).filter("age == 0").first
                try! realm.write {
                    aDog?.age = 1
                }
            }
        }
    }
    
    func realmMigration() {
     
        let config = Realm.Configuration(
            // Set the new schema version.
            // This must be greater than the previous.
            // If you've never set a schema version before, the vesion is 0.
            schemaVersion: 3,
            
            // Set the block which will be called automatically when opening a Realm
            // with a schema version lower than the one set above.
            migrationBlock: {migration, oldSchemaVersion in
                // Do anything for data migration.
                if (oldSchemaVersion < 3) {
                    // Do data paching.
                    migration.enumerateObjects(ofType: Dog.className(), { oldObject, newObject in
                        newObject!["createdAt"] = Date()
                    })
                }
            }
        )
        
        // Thell Realm to use this new configuration object for the default.
        Realm.Configuration.defaultConfiguration = config
    }
}


class Dog: Object {
    @objc dynamic var name = ""
    @objc dynamic var age = 0
    @objc dynamic var createdAt = Date()
}

























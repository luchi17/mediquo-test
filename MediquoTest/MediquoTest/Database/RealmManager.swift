//
//  DatabaseManager.swift
//  MediquoTest
//
//  Created by Mariluz Parejo on 25/1/22.
//

import UIKit
import RealmSwift

class RealmManager: RealmOperations {
    
    private var realm: Realm!
    
    private let schemaVersion: UInt64 = 4
    
    static var shared = RealmManager()
    
    private func configureRealm() {
        do {
            realm = try Realm(configuration: realmConfig())
        } catch {
            print(error)
            fatalError("Unable to create an instance of Realm")
        }
    }
    
    init() {
        self.configureRealm()
    }
    
    func realmConfig() -> Realm.Configuration {
        return Realm.Configuration(schemaVersion: self.schemaVersion, migrationBlock: { (migration, oldSchemaVersion) in
            if oldSchemaVersion < 2 {
                var config = self.realmConfig()
                config.deleteRealmIfMigrationNeeded = true
            }
        })
    }
    
    func add<T: Object>(_ object: T) {
        
        DispatchQueue.main.async {
            if self.realm.isInWriteTransaction {
                return
            } else {
                do {
                    try self.realm.write({
                        self.realm.add(object, update: .modified)
                    })
                } catch {
                    return
                }
            }
        }
    }
    
    func add<S: Sequence>(_ objects: S) where S.Iterator.Element: Object {
        DispatchQueue.main.async {
            if self.realm.isInWriteTransaction {
                return
            } else {
                do {
                    try self.realm.write({
                        self.realm.add(objects, update: .all)
                    })
                } catch {
                    return
                }
            }
        }
    }
    
    
    func read<T: Object>(fromEntity entity: T.Type) -> [T] {
        
        let results: Results<T> = realm.objects(entity)
        return Array(results)
    }
    
    func read<T: Object>(fromEntity entity: T.Type, predicate:  ((T) throws -> Bool)) -> [T] {
        
        var results: [T] = []
        results = try! self.realm.objects(entity).filter(predicate)
        return results
    }
    
    func delete(_ object: Object) {
        do {
            try realm.write({
                realm.delete(object)
            })
        } catch {
            return
        }
    }
    
    func cleanDatabase() {
        
        do {
            try realm.write({
                realm.deleteAll()
            })
        } catch {
            return
        }
    }
    
    func update<T: Object>(_ object: T, predicate: ((T) throws -> Bool)?) {
        
        var objects = self.read(fromEntity: T.self)
        
        guard let predicate = predicate else { return }
        
        do {
            
            objects = try objects.filter(predicate)
            
            try realm.write({
                if var first = objects.first {
                    first = object
                    realm.add(first, update: .modified)
                }
            })
        } catch {
            return
        }
    }
}


protocol RealmOperations {
    
    func add<T: Object>(_ object: T)
    
    func add<S: Sequence>(_ objects: S) where S.Iterator.Element: Object
    
    func read<T: Object>(fromEntity entity: T.Type) -> [T]
    
    func read<T: Object>(fromEntity entity: T.Type, predicate: @escaping ((T) throws -> Bool)) -> [T] 
    
    func delete(_ object: Object)
    
    func cleanDatabase()
    
    func update<T: Object>(_ object: T, predicate: ((T) throws -> Bool)?)
}

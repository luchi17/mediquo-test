//
//  DatabaseManager.swift
//  MediquoTest
//
//  Created by Mariluz Parejo on 25/1/22.
//

import UIKit
import RealmSwift

class RealmManager: RealmOperations {
    
    private let schemaVersion: UInt64 = 4
    
    static var shared = RealmManager()
    
    init() {
    }
    
    private func realmInstance() -> Realm {
        
        do {
            let newRealm = try Realm()
            return newRealm
            
        } catch {
            print(error)
            fatalError("Unable to create an instance of Realm")
        }
    }
    
    
    func write<T: Object>(_ object: T? = nil, completion: @escaping ((Realm, T?) -> Void)) {
        
        DispatchQueue.main.sync {
            autoreleasepool {
                let currentRealm = realmInstance()
                if currentRealm.isInWriteTransaction {
                    return
                } else {
                    do {
                        try currentRealm.write {
                            completion(currentRealm, object)
                        }
                    } catch {
                        return
                    }
                }
            }
        }
    }
    
    func add<T: Object>(_ object: T) {
        self.write { (realmInstance, _) in
            realmInstance.add(object, update: .all)
        }
    }
    
    func add<S: Sequence>(_ objects: S) where S.Iterator.Element: Object {
        self.write { (realmInstance, _) in
            realmInstance.add(objects, update: .all)
        }
    }
    
    
    func read<T: Object>(fromEntity entity: T.Type) -> [T] {
        let results: Results<T> = self.realmInstance().objects(entity)
        return Array(results)
    }
    
    func read<T: Object>(fromEntity entity: T.Type, predicate:  ((T) throws -> Bool)) -> [T] {
        let objects = try! realmInstance().objects(entity).filter(predicate)
        return objects
    }
    
    func delete(_ object: Object) {
        self.write(object) { (realmInstance, newObject) in
            guard let newObject = newObject, !newObject.isInvalidated else {
                return
            }
            realmInstance.delete(newObject)
        }
    }
    
    func cleanDatabase() {
        self.write() { (realmInstance, newObject) in
            guard let newObject = newObject, !newObject.isInvalidated else {
                return
            }
            realmInstance.deleteAll()
        }
    }
    
    func update<T: Object>(_ object: T, completion: @escaping ((T) -> Void)) {
        guard !object.isInvalidated else {
            return
        }
        
        self.write(object) { (realmInstance, newObject) in
            guard let newObject = newObject, !newObject.isInvalidated else {
                return
            }
            completion(newObject)
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
    
    func update<T: Object>(_ object: T, completion: @escaping ((T) -> Void))
}

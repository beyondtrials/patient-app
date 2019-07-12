//
//  DBHandler.swift
//  tak
//
//  Created by Elliott Brunet on 13/01/2017.
//  Copyright © 2017 Elliott Brunet. All rights reserved.
//

import Foundation
import RealmSwift

class DBHandler {
    
    private let uiRealm = try! Realm()
    static let sharedInstance = DBHandler()
    
    private init() {}
    
    func createSharingEvent(text: String) {
        
//        let sharingEvent = SharingEvent(
//            timestamp: Date() as NSDate,
//            type: "Health Date",
//            numberOfElmentsShared: "3 Daten",
//            sharingWithPerson: "Dr Marten",
//            dateStart: Date() as NSDate,
//            dateEnd: Date() as NSDate,
//            sharing: "true")
//
//        do {
//            try saveSharingEvent(item: sharingEvent)
//        } catch {
//            print("couldn't save tak, not good :)")
//        }
    }
    
//    fileprivate func saveSharingEvent(item: SharingEvent) throws {
//        try? uiRealm.write { () -> Void in uiRealm.add(item) ; print("Event saved")}
//    }
//    
//    func getSharingEvents() throws -> [SharingEvent] {
//        return Array(uiRealm.objects(SharingEvent.self)
//                .filter("sharing = 'true'")
//                .sorted(byKeyPath: "timestamp", ascending: false))
//    }
//    
//    func updateToStopSharingState(sharingEvent: SharingEvent) {
//        try? uiRealm.write { () -> Void in sharingEvent.sharing = "false" ; print("Event updated")}
//    }
//    
}

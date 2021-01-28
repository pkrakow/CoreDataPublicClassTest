//
//  HabitCoreData.swift
//  CoreDataPublicClassTest
//
//  Created by Paul Krakow on 1/25/21.
//

import CoreData

class Order: ObservableObject {
    @Published var items = [String]()
}


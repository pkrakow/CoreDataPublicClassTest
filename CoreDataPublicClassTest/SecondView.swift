//
//  SecondView.swift
//  CoreDataPublicClassTest
//
//  Created by Paul Krakow on 1/26/21.
//

import SwiftUI

struct SecondView: View {
    //This @EnvironmentObject variable is shared between views cleanly
    @EnvironmentObject var timerData: TimerData
    
    // This managedObjectContext grants access to shared CoreData across views
    // But all of the data access functions have to be included in each view
    @Environment(\.managedObjectContext) private var viewContext
    
    // Retrieve stored habits from CoreData
    // This fetch request works regardless of whether the viewContext line is included or not
    @FetchRequest(
        entity: Habit.entity(),
        sortDescriptors: [
            // Note that the sort order is in place to make it easy to grab the latest entry in CoreData
            // Do not change this
            NSSortDescriptor(keyPath: \Habit.creationDate, ascending: false)
        ]
    ) var habits: FetchedResults<Habit>
    
    var body: some View {
        VStack {
            Text("Second View")
                .font(.largeTitle)
            Text("Timer Count = \(timerData.timeCount)")
                .font(.headline)
            // Need to figure out how to change the value and save the context
            Text("Habit target = \(habits.first?.target ?? 0)")
                .padding()
            Button(
                action: { changeTarget() },
                label: { Text("Change Target") }
            )
        }
        .padding()
    }
    
    // Save habits to CoreData - duplicate to the ContentView func
    public func saveContext() {
      do {
        try viewContext.save()
      } catch {
        print("Error saving managed object context: \(error)")
      }
    }
    
    // Add a new habit - duplicate to the ContentView func
    public func addHabit(uuid: UUID, creationDate: Date, name: String, moreOrLess: Bool,  target: Int64, count: Int64) {
        // Create a newHabit object
        let newHabit = Habit(context: viewContext)
        
        // Populate the attributes of the newHabit
        newHabit.uuid = UUID()
        newHabit.creationDate = Date()
        newHabit.name = name
        newHabit.moreOrLess = moreOrLess
        newHabit.target = target
        newHabit.count = count
        
        // Save all of the habits including the new one
        saveContext()
    }
    
    func changeTarget() {
        habits.first?.target += 1
        saveContext()
    }
}



struct SecondView_Previews: PreviewProvider {
    static var previews: some View {
        //SecondView(timerData: TimerData())
        SecondView().environmentObject(TimerData())
    }
}

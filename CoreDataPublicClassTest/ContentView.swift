//
//  ContentView.swift
//  CoreDataPublicClassTest
//
//  Created by Paul Krakow on 1/25/21.
//

import SwiftUI
import CoreData

struct ContentView: View {
    
    // This is for the in-memory data
    @StateObject var timerData: TimerData = TimerData()
    //@StateObject var timerData2: TimerData = TimerData()
    
    //
    @Environment(\.managedObjectContext) private var viewContext
    
    // Retrieve stored habits from CoreData
    @FetchRequest(
        entity: Habit.entity(),
        sortDescriptors: [
            // Note that the sort order is in place to make it easy to grab the latest entry in CoreData
            // Do not change this
            NSSortDescriptor(keyPath: \Habit.creationDate, ascending: false)
        ]
    ) var habits: FetchedResults<Habit>
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Timer count = \(timerData.timeCount)")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding()
                Text("Habit target = \(habits.first?.target ?? 0)")
                    .padding()
                NavigationLink(destination: SecondView()) {
                    Text("Click to SecondView")
                }
                .padding()
            }
        }
        // This line calls out the environmentObject(s) that will be shared between views
        .environmentObject(timerData)
        //.environmentObject(timerData2)

        
        
        // When the app loads
        .onAppear() {
            //print(habits)
            //print(habits.count)
            //print(habits.isEmpty)
            //print("onAppear Fired")
            
            // Check if this is the first time the app has been used
            if habits.count == 0
            {
                //print("First Use")
                addHabit(uuid: UUID(), creationDate: Date(), name: "placeholder", moreOrLess: true, target: 3, count: 0)
                saveContext()

            }
        }
    }
    
    
    // Save habits to CoreData
    public func saveContext() {
      do {
        try viewContext.save()
      } catch {
        print("Error saving managed object context: \(error)")
      }
    }

    // Add a new habit
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

    // Delete a habit
    public func deleteHabit(at offsets: IndexSet) {
        // Go through the CoreData index to find and delete the specific habit
        offsets.forEach { index in
            let habit = self.habits[index]
            self.viewContext.delete(habit)
      }
      
        // Save the updated list of habits to CoreData
      saveContext()
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

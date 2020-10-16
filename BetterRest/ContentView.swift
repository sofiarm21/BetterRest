//
//  ContentView.swift
//  BetterRest
//
//  Created by Sofia Rodriguez Morales on 10/14/20.
//

import SwiftUI

struct ContentView: View {
    @State private var wakeUp = Date()
    @State private var amountOfCoffe = 0
    @State private var amountOfSleep = 8.0
    var body: some View {
        NavigationView{
            VStack{
                Text("Select what time you want to sleep")
                DatePicker("Please enter a time", selection: $wakeUp, displayedComponents: .hourAndMinute)
                    .labelsHidden()
                Text("Desired amount of sleep")
                    .font(.headline)
                Stepper(value: $amountOfSleep, in: 4...12, step: 0.25){
                    Text("\(amountOfSleep, specifier:"%g")h. of sleep")
                }
                Stepper(value: $amountOfCoffe, in: 0...20){
                    //(amountOfCoffe == 1) ? Text("\(amountOfCoffe) cups") : Text("1 cup")
                    Text("\(amountOfCoffe == 1 ? "1 cup" : "\(amountOfCoffe) cups")")
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

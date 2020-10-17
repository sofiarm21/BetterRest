//
//  ContentView.swift
//  BetterRest
//
//  Created by Sofia Rodriguez Morales on 10/14/20.
//

import SwiftUI

struct ContentView: View {
    
    static var defaultWakeTime: Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? Date()
    }
    
    @State private var wakeUp = defaultWakeTime
    @State private var amountOfCoffe = 0
    @State private var amountOfSleep = 8.0
    
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var showAlert = false
    
   
    
    var body: some View {
       
        NavigationView{
            Form{
                Section(header: Text("When do you want to wake up?")) {
                    
                    DatePicker("Please enter a time", selection: $wakeUp, displayedComponents: .hourAndMinute)
                        .labelsHidden()
                }
                Section(header: Text("Desired amount of sleep")){
                    Stepper(value: $amountOfSleep, in: 4...12, step: 0.25){
                        Text("\(amountOfSleep, specifier:"%g")h. of sleep")
                    }
                }
                Section(header: Text("Number of cups of coffe")) {
                    Stepper(value: $amountOfCoffe, in: 0...20){
                        Text("\(amountOfCoffe == 1 ? "1 cup" : "\(amountOfCoffe) cups")")
                    }
                }
                VStack(alignment: .center, spacing: 3) {
                    Text("Recomended bedtime")
                        .font(.title)
                    Text("\(calculateSleep)")
                        .font(.title)
                }

                

               
                .alert(isPresented: $showAlert) {
                    Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .default(Text("ok")))
                }
            }
            .navigationTitle("BetterRest")
//            .navigationBarItems(trailing:
//                                    Button(action: self.calculateSleep){
//                    Text("Calculate")
//                 }
//            )
            

        }
        
    }
    
    var calculateSleep: String {
        let model = SleepCalculator()

        let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
        let hour = (components.hour ?? 0) * 60 * 60
        let minute = (components.minute ?? 0) * 60 * 60
        
        do {
            let prediction = try model.prediction(wake: Double(hour + minute), estimatedSleep: amountOfSleep, coffee: Double(amountOfCoffe))
            let sleepTime = wakeUp - prediction.actualSleep

            let formatter = DateFormatter()
            formatter.timeStyle = .short
            return "\(formatter.string(from: sleepTime))"
            
        }catch{
            alertTitle = "Upss..."
            alertMessage = "Something went wrong"
            return "Error"
        }
       // showAlert = true
    
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

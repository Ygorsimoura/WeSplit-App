//
//  ContentView.swift
//  WeSplit
// #100DaysOfSwiftUI
//  Created by Ygor Simoura on 29/08/23.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 10
    @FocusState private var amountIsFocused: Bool
    
    var peopleCount: Double {
        return Double(numberOfPeople + 2)
        
    }

    var totalAmount: Double {
        let tipSelection = Double(tipPercentage)
        let tipValue = tipSelection / 100 * checkAmount
        let totalValue = tipValue + checkAmount
        
        return totalValue
    }
    
    var totalPerPerson: Double {
        let totalPerPerson = totalAmount / peopleCount
        
        return totalPerPerson
    }
    
    var body: some View {
        NavigationView{
                Form{
                    Section{
                        TextField("Amount", value: $checkAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                            .keyboardType(.decimalPad)
                            .focused($amountIsFocused)
                        
                        Picker("Number of People", selection: $numberOfPeople){
                            ForEach(2..<100) {
                                Text("\($0) People")
                            }
                        }
                    } header: {
                        Text("")
                    }
                    
                    Section{
                        Picker("Tip Percentage", selection: $tipPercentage){
                            ForEach(0..<101){
                                Text($0, format:.percent)
                            }
                        }
                        .pickerStyle(.wheel)
                        .frame(height: 100)
                    } header: {
                        Text("How much tip do you wanna leave?")
                    }
                    
                    Section{
                        Text(totalAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                    } header : {
                        Text("Total Amount of the Check")
                    }
                    
                    Section{
                        Text(totalPerPerson,  format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                    } header: {
                        Text("Total per person")
                    }
                }
                .navigationTitle("WeSplit")
                .toolbar{
                    ToolbarItemGroup(placement: .keyboard){
                        Spacer()
                        Button("Done"){
                            amountIsFocused = false
                        }
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

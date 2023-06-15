//
//  ContentView.swift
//  WeSplit
//
//  Created by Kramer, Tim on 6/15/23.
//

import SwiftUI

struct ContentView: View {
    @State private var mPrice = 0.00
    @State private var mTipPer = 0.2
    @State private var mNumPeople = 1
    
    let maxPeople = 100
    
    var body: some View
    {
        NavigationView
        {
            ZStack
            {
                VStack
                {
                    Form
                    {
                        TextField("Meal Price", value: $mPrice, format: .currency(code: Locale.current.currency?.identifier ?? "USD")).keyboardType(.decimalPad)
                        
                        Picker(selection: $mNumPeople, label: Text("Number of people"), content: {
                            ForEach(1...maxPeople, id:\.self)
                            {
                                number in
                                Text("\(number)").tag(number)
                            }
                        })
                        Picker(selection: $mTipPer, label: Text("Tip Percentage"), content:{
                            ForEach(0 ... 100, id:\.self)
                            {
                                number in Text("\(number)").tag(number)
                            }
                        })
                    }.navigationTitle("Check Splitter")
                    Section
                    {
                        Text("Total Price per Person: \(calculateTotalPricePerPerson(), specifier: "%.2f")")
                            .font(.system(size: 20))
                            .fontWeight(.bold)
                    }
                }
            }
        }
    }
    
    private func calculateTotalPricePerPerson() -> Double {
        let totalPrice = mPrice + mPrice * mTipPer
        return totalPrice / Double(mNumPeople)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

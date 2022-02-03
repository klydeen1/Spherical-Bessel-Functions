//
//  ContentView.swift
//  Shared
//
//  Created by Katelyn Lydeen on 2/2/22.
//  Based on code created by Jeff Terry on 1/5/21.
//

import SwiftUI

struct ContentView: View {
    
    @State var guess = ""
    @State private var totalInput: Int? = 24
    
    private var intFormatter: NumberFormatter = {
        let f = NumberFormatter()
        f.numberStyle = .decimal
        return f
    }()
    
    var body: some View {

        VStack {
            HStack {
                TextEditor(text: $guess)
                Button("Calculate Bessel Functions", action: calculateBesselFunc)
            }
            .frame(minHeight: 300, maxHeight: 800)
            .frame(minWidth: 480, maxWidth: 800)
            .padding()
         
            HStack{
                Text(verbatim: "Order:")
                    .padding()
                TextField("Total", value: $totalInput, formatter: intFormatter)
                    .padding()
             }
         }
    }
    
    func calculateBesselFunc()  {
        let xValues = [0.1, 1, 10]
        let order = totalInput ?? 0 // Order of the Bessel function
        let start = order+25        // Starting order for the downward recursion
        guess = String(format: "J%d(x)\n", order)

        for x in xValues
        {
            guess += String(format: "x = %f, Downward, %7.5e, Upward, %7.5e\n", x, calculateDownwardRecursion(xValue: x, order: order, start: start),   calculateUpwardRecursion(xValue: x, order: order))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

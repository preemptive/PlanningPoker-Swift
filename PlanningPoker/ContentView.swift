//
//  ContentView.swift
//  PlanningPoker
//
//  Created by Mike Richter on 2/2/21.
//  Copyright © 2021 PreEmptive Solutions, LLC. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    enum BidStyle: String, CaseIterable, Identifiable {
        case fibonacci
        case primes
        case squares
        case linear

        var id: String { self.rawValue }
    }
    
    static let fibonacci = ["0", "1", "2", "3", "5", "8", "13", "21", "34", "55", "∞", "?"]
    static let squares = ["0", "1", "4", "9", "16", "25", "36", "49", "64", "81", "∞", "?"]
    static let primes = ["2", "3", "5", "7", "11", "13", "17", "19", "23", "29", "∞", "?"]
    static let linear = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "∞", "?"]
    
    @State private var bidIndex: Float = 1
    @State private var isEditing: Bool = false
    @State private var bidStyle = BidStyle.fibonacci
    @State private var options: Array<String> = fibonacci

    var body: some View {
        let drag = DragGesture()
                .onEnded {
                    if $0.translation.width < -30 {
                        bidIndex = Float(max(Int(bidIndex) - 1, 0))
                    } else if $0.translation.width > 30 {
                        bidIndex = Float(min(Int(bidIndex) + 1, options.count - 1))
                    }
               }

        GeometryReader { geo in
            VStack(spacing: 0.0) {
                Picker("Bid Style", selection: $bidStyle.onChange(changeBidStyle)) {
                    ForEach(BidStyle.allCases) { bidStyle in
                        Text(bidStyle.rawValue.capitalized).tag(bidStyle)
                    }
                }.pickerStyle(SegmentedPickerStyle())
            
                Text("\(options[Int(bidIndex)])")
                    .font(.system(size: min(geo.size.height, geo.size.width) * 0.8))
                    .lineLimit(1)
                    .foregroundColor(isEditing ? .red : .black)
                    .gesture(drag)

                Slider(
                    value: $bidIndex,
                    in: 0...Float((options.count-1)),
                    step: 1,
                    onEditingChanged: { editing in
                        isEditing = editing
                    },
                    minimumValueLabel: Text(options[0]),
                    maximumValueLabel: Text(options[options.count - 1]))
                {
                    Text("missing?")
                }
            }
        }
        .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
    }
    
    private func changeBidStyle(_ bidStylex: BidStyle) {
        switch bidStylex {
        case .fibonacci: options = ContentView.fibonacci
        case .primes: options = ContentView.primes
        case .squares: options = ContentView.squares
        case .linear: options = ContentView.linear
        }
    }
}

extension Binding {
    func onChange(_ handler: @escaping (Value) -> Void) -> Binding<Value> {
        return Binding(
            get: { self.wrappedValue },
            set: { selection in
                self.wrappedValue = selection
                handler(selection)
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

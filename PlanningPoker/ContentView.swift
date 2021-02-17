//
//  ContentView.swift
//  PlanningPoker
//
//  Copyright © 2021 PreEmptive Solutions, LLC. All rights reserved.
//

import SwiftUI
import iOSDefenderSDK

struct ContentView: View {
    enum BidStyle: String, CaseIterable, Identifiable {
        case fibonacci
        case primes
        case squares
        case linear

        var id: String { self.rawValue }
    }
    
    // For now each bid style has 12 options:
    static let fibonacci = ["0", "1", "2", "3", "5", "8", "13", "21", "34", "55", "∞", "?"]
    static let squares = ["0", "1", "4", "9", "16", "25", "36", "49", "64", "81", "∞", "?"]
    static let primes = ["2", "3", "5", "7", "11", "13", "17", "19", "23", "29", "∞", "?"]
    static let linear = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "∞", "?"]

    static let dragThreshold: CGFloat = 25

    @State private var bidIndex: Float = 1
    @State private var bidStyle = BidStyle.fibonacci
    @State private var options: Array<String> = getOptions(fibonacci)
    @State private var showAlert = false
    @State private var alertDescription: String? = nil

    var body: some View {
        let drag = DragGesture()
                .onEnded {
                    if $0.translation.width < -ContentView.dragThreshold {
                        bidIndex = Float(min(Int(bidIndex) + 1, options.count - 1))
                    } else if $0.translation.width > ContentView.dragThreshold {
                        bidIndex = Float(max(Int(bidIndex) - 1, 0))
                    }
               }

        GeometryReader { geo in
            VStack(spacing: 0.0) {
                Picker("Bid Style", selection: $bidStyle.onChange(changeBidStyle)) {
                    ForEach(BidStyle.allCases) { bidStyle in
                        Text(bidStyle.rawValue.capitalized).tag(bidStyle)
                    }
                }.pickerStyle(SegmentedPickerStyle())

                Spacer()

                // Seems like 0.8 gives nice large numbers, but won't make "55" change to "...".
                Text("\(options[Int(bidIndex)])")
                    .font(.system(size: min(geo.size.height, geo.size.width) * 0.8))
                    .lineLimit(1)
                    .gesture(drag)

                Spacer()
                    .alert(isPresented: $showAlert) {
                        Alert(
                            title: Text("Jailbroken"),
                            message: Text(alertDescription!)
                        )
                    }
                
                Slider(
                    value: $bidIndex,
                    in: 0...Float((options.count-1)),
                    step: 1,
                    minimumValueLabel: Text(options[0]),
                    maximumValueLabel: Text(options[options.count - 1]))
                {
                    Text("Bid")
                }
            }
        }
        .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
        .onAppear(perform: checkForJailbroken)
    }
    
    private func checkForJailbroken() {
        var state: String? = nil
        if iOSDefender.isActivelyJailbroken() {
            state = "Device is Actively Jailbroken, functionality is limited: only 3 different bids are available"
        } else if iOSDefender.isJailbroken() {
            state = "Device is Jailbroken, functionality is limited: only 5 different bids are available"
        } else if iOSDefender.hasBeenJailbroken() {
            state = "Device has been Jailbroken before, funtionality is limited: only 7 integer bids and infinity are available"
        }
        
        if let theState = state {
            alertDescription = theState
            showAlert = true
        }
    }
    
    private func changeBidStyle(_ bidStylex: BidStyle) {
        let selected: Array<String>
        switch bidStylex {
        case .fibonacci: selected = ContentView.fibonacci
        case .primes: selected = ContentView.primes
        case .squares: selected = ContentView.squares
        case .linear: selected = ContentView.linear
        }
        
        options = ContentView.getOptions(selected)
    }
    
    private static func getOptions(_ array: Array<String>) -> Array<String> {
        if iOSDefender.isActivelyJailbroken() {
            return [] + array[1...3]
        } else if iOSDefender.isJailbroken() {
            return [] + array[0...4]
        } else if iOSDefender.hasBeenJailbroken() {
            return array[0...6] + [array[array.count - 2]]
        } else {
            return array
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

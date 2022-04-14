//
//  Parameters.swift
//  Electrospinner
//
//  Created by Steven DiGregorio on 4/13/22.
//

import Foundation

class Parameters: ObservableObject {
    @Published var RH = ""
    @Published var Tamb = ""
    @Published var solution = ""
    @Published var flowRate = ""
    @Published var flowRateUnits = ""
    @Published var notes = "\n\n\n"
    @Published var sampleID = ""
    @Published var duration = ""
    @Published var voltage = ""
    @Published var distance = ""
}

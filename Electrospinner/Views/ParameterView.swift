//
//  ParameterView.swift
//  Electrospinner
//
//  Created by Steven DiGregorio on 4/1/22.
//

import SwiftUI

struct ParameterView: View {
    @State private var distance: String = ""
    @State private var RH: String = ""
    @State private var ambTemperature: String = ""
    @State private var solution: String = ""
    @State private var duration: String = ""
    @State private var sampleID: String = ""
    @State private var notes: String = "\n\n\n"

    var body: some View {
        Form {
            TextField("RH [%]", text: $RH)
            TextField("Tamb [°C]", text: $ambTemperature)
            TextField("Solution", text: $solution)
            TextField("Voltage [kV]", text: $distance)
            TextField("Duration [s]", text: $duration)
            TextField("Sample ID", text: $sampleID)
            TextField("Notes", text: $notes)
        }
    }
}

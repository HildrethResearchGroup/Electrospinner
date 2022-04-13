//
//  SyringePumpView.swift
//  Electrospinner
//
//  Created by Steven DiGregorio on 4/1/22.
//

import SwiftUI

enum syringePumpUnits: String {
    case ml_hr = "ml/hr"
    case ul_hr = "µl/hr"
    case ml_min = "ml/min"
    case ul_min = "µl/min"
}

extension syringePumpUnits: CaseIterable, Identifiable {
    var id: Self {self}
}

struct SyringePumpView: View {
    @State private var flowRate: String = ""
    @State private var units: syringePumpUnits = .ml_hr
    
    var body: some View {
        VStack {
            Form {
                TextField("Flow Rate", text: $flowRate)
                Picker("Units", selection: $units) {
                    ForEach(syringePumpUnits.allCases) { unit in
                        Text(unit.rawValue)
                    }
                }
            }
            Button("Start Pumping"){}
        }
    }
}

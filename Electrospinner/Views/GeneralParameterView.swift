//
//  ParameterView.swift
//  Electrospinner
//
//  Created by Steven DiGregorio on 4/1/22.
//

import SwiftUI

struct GeneralParameterView: View {
    @ObservedObject var electrospinner: Electrospinner

    var body: some View {
        Form {
            TextField("RH [%]", text: $electrospinner.parameters.RH)
            TextField("Tamb [°C]", text: $electrospinner.parameters.Tamb)
            TextField("Solution", text: $electrospinner.parameters.solution)
            TextField("Distance [cm]", text: $electrospinner.parameters.distance)
        }.frame(alignment: .leading)
    }
}

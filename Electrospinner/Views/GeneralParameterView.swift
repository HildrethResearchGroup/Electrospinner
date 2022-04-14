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
        VStack{
            Text("General Parameters").font(.title2).padding(.top, -5)
            Form {
                TextField("RH [%]", text: $electrospinner.RH)
                TextField("Tamb [°C]", text: $electrospinner.Tamb)
                TextField("Solution", text: $electrospinner.solution)
                TextField("Distance [cm]", text: $electrospinner.distance)
            }
        }
    }
}

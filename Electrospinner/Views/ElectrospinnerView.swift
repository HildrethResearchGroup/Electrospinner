//
//  ElectrospinnerView.swift
//  Electrospinner
//
//  Created by Steven DiGregorio on 4/5/22.
//

import SwiftUI

struct ElectrospinnerView: View {
    @ObservedObject var electrospinner: Electrospinner
    
    var body: some View {
        Form {
            TextField("Duration [s]", text: $electrospinner.parameters.distance)
            TextField("Sample ID", text: $electrospinner.parameters.sampleID)
            TextField("Notes", text: $electrospinner.parameters.notes)
        }
        VStack{
            HStack {
                Button("Start"){ electrospinner.startElectrospinning() }
                Text("Elapsed Time: 0 / 60 s")
            }
            Button("Abort"){}
        }
    }
}

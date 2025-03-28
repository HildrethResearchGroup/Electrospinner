//
//  ElectrospinnerView.swift
//  Electrospinner
//
//  Created by Steven DiGregorio on 4/5/22.
//

import SwiftUI
import CoreMedia

struct ElectrospinnerView: View {
    @Bindable var electrospinner: Electrospinner

    
    var body: some View {
        VStack {
            Text("Electrospinner").font(.title2).padding(.top, -5)
            Form {
                TextField("Duration [s]", value: $electrospinner.duration, format: IntegerFormatStyle())
                TextField("Sample ID", text: $electrospinner.sampleID)
                TextField("Notes", text: $electrospinner.notes)
            }
            Spacer(minLength: 5)
            Button("Start"){ electrospinner.startElectrospinning() }
                .disabled(startButtonDisabled)
                .frame(maxWidth: .infinity)
            Text("Elapsed Time: \(electrospinner.elapsedTime) / \(electrospinner.duration) s").font(.title3).frame(maxWidth: .infinity)
                .frame(maxWidth: .infinity)
                .padding(.all, 3)
                .overlay(RoundedRectangle(cornerRadius: 10)
                            .stroke(startButtonColor, lineWidth: 2))
            Button("Abort"){electrospinner.abort()}.frame(maxWidth: .infinity)
        }
    }
    
    var startButtonDisabled: Bool {
        electrospinner.isRunning
    }
    
    var startButtonColor: Color {
        electrospinner.isRunning ? Color.green : Color.gray
    }
}

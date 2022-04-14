//
//  SyringePumpView.swift
//  Electrospinner
//
//  Created by Steven DiGregorio on 4/1/22.
//

import SwiftUI
import ORSSerial

struct SyringePumpView: View {
    @ObservedObject var controller: SyringePumpController
    
    var body: some View {
        Form {
            // Select Port
            HStack {
                Picker("Port", selection: $controller.serialPort) {
                    ForEach(controller.serialPortManager.availablePorts, id:\.self) { port in
                        Text(port.name).tag(port as ORSSerialPort?)
                    }
                }
                Button(controller.nextPortState) {controller.openOrClosePort()}
            }.frame(alignment: .leading)
            
            // Select units
            HStack{
                Form{
                    HStack {
                        Text("Flow Rate")
                        TextField("", text: $controller.flowRate)
                    }
                    
                    Picker("Units", selection: $controller.units) {
                        ForEach(SyringePumpController.flowRateUnits.allCases) { unit in
                            Text(unit.rawValue)
                        }
                    }
                }
                Button("Start Pumping"){ controller.startPumping() }
                .padding()
            }
        }
    }
}

// Actual solution to picker with optionals:
// use tag (port as ORSSerialPort?)
// https://stackoverflow.com/questions/59348093/picker-for-optional-data-type-in-swiftui

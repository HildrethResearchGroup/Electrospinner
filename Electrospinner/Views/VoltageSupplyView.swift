//
//  VoltageSupplyView.swift
//  Electrospinner
//
//  Created by Steven DiGregorio on 4/8/22.
//

import SwiftUI
import ORSSerial

struct VoltageSupplyView: View {
    @ObservedObject var controller: VoltageSupplyController
    
    var body: some View {
        VStack {
            
            // Select Port
            HStack {
                Picker("Port", selection: $controller.serialPort) {
                    ForEach(controller.serialPortManager.availablePorts, id:\.self) { port in
                        Text(port.name).tag(port as ORSSerialPort?)
                    }
                }
                Button(controller.nextPortState) {controller.openOrClosePort()}
            }.frame(alignment: .leading)
            
            // Set Voltage
            HStack {
                Text("Voltage [kV]:")
                TextField("", text: $controller.voltage)
            }.frame(alignment: .leading)
            
        }
    }
}

// Actual solution to picker with optionals:
// use tag (port as ORSSerialPort?)
// https://stackoverflow.com/questions/59348093/picker-for-optional-data-type-in-swiftui

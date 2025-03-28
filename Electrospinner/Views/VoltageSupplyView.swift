//
//  VoltageSupplyView.swift
//  Electrospinner
//
//  Created by Steven DiGregorio on 4/8/22.
//

import SwiftUI
import ORSSerial

struct VoltageSupplyView: View {
    @Bindable var controller: VoltageSupplyController
    
    var body: some View {
        VStack{
            Text("High-Voltage Supply").font(.title2).padding(.top, -5)
            Form {
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
                    Text("Voltage [kV]")
                    TextField("", text: $controller.voltage)
                }.frame(alignment: .leading)
                
                
                Button(controller.onOffButtonLabel) {controller.turnVoltageOnOrOff()}
            }
        }
    }
}

// Actual solution to picker with optionals:
// use tag (port as ORSSerialPort?)
// https://stackoverflow.com/questions/59348093/picker-for-optional-data-type-in-swiftui

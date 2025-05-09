//
//  SyringePumpView.swift
//  Electrospinner
//
//  Created by Steven DiGregorio on 4/1/22.
//

import SwiftUI
import ORSSerial

struct SyringePumpView: View {
    @Bindable var controller: SyringePumpController
    
    var body: some View {
        VStack{
            Text("Syringe Pump").font(.title2).padding(.top, -5)
            Form {
                // Select Port
                HStack {
                    Picker("Port", selection: $controller.serialPort) {
                        ForEach(controller.serialPortManager.availablePorts, id:\.self) { port in
                            Text(port.name).tag(port as ORSSerialPort?)
                        }
                    }
                    Button(controller.nextPortState) {controller.openOrClosePort()}
                }
                
                // Select units
                HStack {
                    TextField("Flow Rate", text: $controller.flowRate)
                }
                
                Picker("Units", selection: $controller.units) {
                    ForEach(SyringePumpController.flowRateUnits.allCases) { unit in
                        Text(unit.rawValue)
                    }
                }
                
                // Start Button
                Button(controller.onOffButtonLabel){ controller.startOrStopPumping() }
            }
        }
    }
}

// Actual solution to picker with optionals:
// use tag (port as ORSSerialPort?)
// https://stackoverflow.com/questions/59348093/picker-for-optional-data-type-in-swiftui

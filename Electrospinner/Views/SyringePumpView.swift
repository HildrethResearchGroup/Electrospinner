//
//  SyringePumpView.swift
//  Electrospinner
//
//  Created by Steven DiGregorio on 4/1/22.
//

import SwiftUI
import ORSSerial

struct SyringePumpView: View {
    @ObservedObject var controller = SyringePumpController()
    
    var body: some View {
        VStack {
            
            HStack {
                Picker("Select Port", selection: $controller.serialPort) {
                    ForEach(controller.serialPortManager.availablePorts, id:\.self) { port in
                        Text(port.name).tag(port as ORSSerialPort?)
                    }
                }
                Button(controller.nextPortState) {controller.openOrClosePort()}
            }.frame(alignment: .leading)
            
            HStack {
                TextField("Flow Rate: ", text: $controller.flowRate)
                Picker("Units: ", selection: $controller.units) {
                    ForEach(SyringePumpController.flowRateUnits.allCases) { unit in
                        Text(unit.rawValue)
                    }
                }
                Button("Set Flow Rate"){ controller.startPumping() }
            }.frame(alignment: .leading)
            
        }
    }
}




// Making picker work with observed objects
// cannot use optionals
// https://stackoverflow.com/questions/57912601/how-make-work-a-picker-with-an-observedobject-in-swiftui

// Actual solution to picker with optionals:
// use tag (port as ORSSerialPort?)
// https://stackoverflow.com/questions/59348093/picker-for-optional-data-type-in-swiftui

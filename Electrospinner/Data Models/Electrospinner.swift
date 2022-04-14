//
//  ElectrospinnerModel.swift
//  Electrospinner
//
//  Created by Steven DiGregorio on 4/2/22.
//

import Foundation

class Electrospinner: ObservableObject {
    
    let syringePump = SyringePumpController()
    let voltageSupply = VoltageSupplyController()
    @Published var parameters = Parameters()
    
    func startElectrospinning() {
        // start camera
        // start voltage
        // wait to time
        // stop voltage
        // stop camera
        // save video and param file
        voltageSupply.startVoltage()
        
    }
    
    func saveParameters() {
        return
    }
}

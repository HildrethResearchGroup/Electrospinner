//
//  ElectrospinnerModel.swift
//  Electrospinner
//
//  Created by Steven DiGregorio on 4/2/22.
//

import Foundation

class Electrospinner: ObservableObject {
    @Published var elapsedTime = 0
    @Published var isRunning = false
    @Published var folderURL: URL? = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    var timer = Timer()
    
    // Parameters
    @Published var RH = ""
    @Published var Tamb = ""
    @Published var solution = ""
    @Published var notes = "\n\n\n"
    @Published var sampleID = ""
    @Published var duration: Int = 0
    @Published var distance = ""
    
    // Equipment
    let syringePump = SyringePumpController()
    let voltageSupply = VoltageSupplyController()
    
    func startElectrospinning() {
        elapsedTime = 0
        isRunning = true
        startTimer()
        let deadlineTime = DispatchTime.now() + DispatchTimeInterval.seconds(duration) // converting to a int
        // start camera
        voltageSupply.startVoltage() // start voltage
        
        // wait for duration
        DispatchQueue.main.asyncAfter(deadline: deadlineTime) {
            self.isRunning = false
            self.voltageSupply.stopVoltage() // Stop Voltage
        }
        
        // stop camera
        // save video and param file
    }
    
    func startTimer() {
        self.timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { _ in
            if self.elapsedTime < self.duration {
                self.elapsedTime += 1
            } else {
                self.timer.invalidate()
            }})
    }
    
    func abort() { voltageSupply.stopVoltage() }
    
    func saveParameters() {
        return
    }
}

// timer: https://stackoverflow.com/questions/30090309/how-can-i-make-a-function-execute-every-second-in-swift

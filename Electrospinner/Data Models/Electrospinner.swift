//
//  ElectrospinnerModel.swift
//  Electrospinner
//
//  Created by Steven DiGregorio on 4/2/22.
//

import Foundation
import SwiftUI


@Observable
class Electrospinner {
    var elapsedTime = 0
    var isRunning = false
    var folderURL: URL? = FileManager.default
        .urls(for: .documentDirectory, in: .userDomainMask)[0]
        .appendingPathComponent("Electrospinner")
    var timer = Timer()
    
    // Parameters
    var solution = ""
    var RH = ""
    var Tamb = ""
    var distance = ""
    var duration: Int = 1
    var sampleID = ""
    var notes = "\n\n\n"
    
    // Equipment
    var syringePump = SyringePumpController()
    var voltageSupply = VoltageSupplyController()
    
    func startElectrospinning() {
        // Start Timer
        elapsedTime = 0
        isRunning = true
        startTimer()
                
        // start voltage
        voltageSupply.startVoltage()
        
        // wait for time to elapse and turn off voltage
        let deadlineTime = DispatchTime.now() + DispatchTimeInterval.seconds(duration)
        DispatchQueue.main.asyncAfter(deadline: deadlineTime) {
            self.isRunning = false
            self.voltageSupply.stopVoltage()
            self.saveParameters() // save param file
        }
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
        let stringToSave = generateString()
        let filePath = getFilePath()
        do {
            try stringToSave.write(toFile: filePath,
                                   atomically: true,
                                   encoding: .utf8)
        } catch {
            print("Save File Error:", error)
            return
        }
    }
    
    func getFilePath() -> String {
        let fileManager = FileManager.default
        var filename = sampleID
        var fileNameIndex = 1
        
        // making sure file does not already exist. Append number if it does
        while true {
            if let newpath = folderURL?.appendingPathComponent("\(filename).csv") {
                if fileManager.fileExists(atPath: newpath.path) {
                    filename = "\(sampleID)\(fileNameIndex)"
                    fileNameIndex += 1
                } else {
                    filename = newpath.path
                    break
                }
            }
        }
        return filename
    }
    
    func generateString() -> String {
        let date = Date()
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let dateString = df.string(from: date)
        
        let output = """
Sample, \(sampleID)
Date, \(dateString)
Solution, \(solution)
RH [%], \(RH)
Tamb [C], \(Tamb)
Distance [cm], \(distance)
Duration [s], \(duration)
Voltage [kV], \(voltageSupply.voltage)
Flowrate, \(syringePump.flowRate) \(syringePump.units.rawValue)
SampleID, \(sampleID)
Notes, \(notes)
"""
        return output
    }
}

// timer: https://stackoverflow.com/questions/30090309/how-can-i-make-a-function-execute-every-second-in-swift
// saving files: https://programmingwithswift.com/save-file-to-documents-directory-with-swift/
// better saving files: https://www.hackingwithswift.com/example-code/strings/how-to-save-a-string-to-a-file-on-disk-with-writeto
// if files exists: https://www.appsdeveloperblog.com/check-if-a-file-exist/

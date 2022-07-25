//
//  VoltageSupplyController.swift
//  Electrospinner
//
//  Created by Steven DiGregorio on 4/2/22.
//

import Foundation
import ORSSerial

class VoltageSupplyController: ObservableObject {
    // MARK: - Serial Port Methods
    var serialPortManager: ORSSerialPortManager = ORSSerialPortManager.shared()
    @Published var nextPortState = "Open"
    @Published var serialPort: ORSSerialPort? {
        didSet {
            serialPort?.parity = .none
            serialPort?.baudRate = 9600
        }
    }
    
    func openOrClosePort() {
        if let port = self.serialPort {
            if (port.isOpen) {
                port.close()
                nextPortState = "Open"
            } else {
                port.open()
                nextPortState = "Close"
            }
        }
    }
    
    func send(_ sendString :String) {
        print("Voltage controller sent:\(sendString)")
        if let data = sendString.data(using: String.Encoding.utf8) {
            self.serialPort?.send(data)
        }
    }
    
    // MARK: - Voltage Controller Methods
    @Published var voltage: String = "0"
    
    func startVoltage() {
        // scale voltage
        let maxBit = 255.0
        let maxHighVoltage = 19.8
        let scaleFactor = 0.99
        let scaledVoltage = (Double(voltage) ?? 0.0) * maxBit / maxHighVoltage * scaleFactor
        send(String(Int(scaledVoltage)))
    }
    
    func stopVoltage() {
        send("0")
    }
}





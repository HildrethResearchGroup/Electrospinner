//
//  SyringePumpController.swift
//  Electrospinner
//
//  Created by Steven DiGregorio on 4/2/22.
//

import Foundation
import ORSSerial

@Observable
class SyringePumpController {
    // MARK: - Serial Port Methods
    var serialPortManager: ORSSerialPortManager = ORSSerialPortManager.shared()
    var serialPort: ORSSerialPort? {
        didSet {
            serialPort?.numberOfStopBits = 1
            serialPort?.parity = .none
            serialPort?.baudRate = 19200
            serialPort?.shouldEchoReceivedData = true
        }
    }
    var nextPortState: String {
        switch portState {
        case .closed: return "Open"
        case .open: return "Close"
        }
    }
    
    var portState: PortState = .closed
    
    
    func openOrClosePort() {
        if let port = self.serialPort {
            if (port.isOpen) {
                port.close()
                portState = .closed
            } else {
                port.open()
                portState = .open
            }
        } else {
            portState = .closed
        }
    }
    
    func send(_ sendData :String) {

        let sendString = sendData + "\r\n" // adding line end characters for syringe pump to work
        print("Syringe pump controller sent:\(sendString)")
        if let data = sendString.data(using: String.Encoding.utf8) {
            self.serialPort?.send(data)
        }
    }
    
    // MARK: - Syringe Pump Controller Methods
    var nextPumpState: NextPumpState = .startPumping
    var units: flowRateUnits = .nL_min
    var flowRate: String = "20"
    
    enum flowRateUnits: String, CaseIterable, Identifiable {
        var id: Self {self}
        
        case mm_hr = "ml / hr"
        case uL_hr = "µl / hr"
        case nL_hr = "nl / hr"
        case mm_min = "ml / min"
        case uL_min = "µl / min"
        case nL_min = "nl / min"
        
        var queryString: String {
            switch self {
            case .mm_hr: return "MH"
            case .uL_hr: return "UH"
            case .nL_hr: return "NH"
            case .mm_min: return "MM"
            case .uL_min: return "UM"
            case .nL_min: return "NM"
            }
        }
    }
    
    enum NextPumpState: String {
        case startPumping = "Start Pumping"
        case stopPumping = "Stop Pumping"
    }
    
    func startOrStopPumping() {
        switch nextPumpState {
        case .startPumping:
            startPumping()
            nextPumpState = .stopPumping
        case .stopPumping:
            stopPumping()
            nextPumpState = .startPumping
        }
    }
    
    private func startPumping() {
        self.send("") // Sending empty string first seems to make things more consistant
        // Adding delays for serial communication to work
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.send("FUN RAT") // entering rate mode
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            self.send("RAT \(self.flowRate) \(self.units.queryString)") // Setting new flow rate
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.send("RUN") // starting pump
        }
    }
    
    private func stopPumping() {
        send("STP")
    }
}

extension ORSSerialPort: @retroactive Identifiable {
    public var id: ORSSerialPort {return self}
}

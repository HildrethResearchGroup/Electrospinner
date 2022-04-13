//
//  SyringePumpController.swift
//  Electrospinner
//
//  Created by Steven DiGregorio on 4/2/22.
//

import Foundation
import ORSSerial

class SyringePumpController: ObservableObject {
    var serialPortManager: ORSSerialPortManager = ORSSerialPortManager.shared()
    @Published var serialPort: ORSSerialPort? {
        didSet {
            serialPort?.numberOfStopBits = 1
            serialPort?.parity = .none
            serialPort?.baudRate = 19200
            serialPort?.shouldEchoReceivedData = true
        }
    }
    @Published var nextPortState = "Open"
    @Published var units: flowRateUnits = .nL_min
    @Published var flowRate: String = "20"
    
    enum flowRateUnits: String, CaseIterable, Identifiable {
        var id: Self {self}
        
        case mm_hr = "ml/hr"
        case uL_hr = "µl/hr"
        case nL_hr = "nl/hr"
        case mm_min = "ml/min"
        case uL_min = "µl/min"
        case nL_min = "nl/min"
        
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
    
    func startOrStopPumping() {
        if let port = self.serialPort {
            if (port.isOpen) {
                port.close()
            } else {
                port.open()
            }
        }
    }
    
    func startPumping() {
        send("FUN RAT") // entering rate mode
        send("RAT \(flowRate) \(units.queryString)") // Setting new flow rate
        send("RUN") // starting pump
    }
    
    func stopPumping() {
        send("STP")
    }
    
    func send(_ sendData :String) {

        let sendString = sendData + "\r\n" // adding line end characters for syringe pump to work
        print(sendString)
        if let data = sendString.data(using: String.Encoding.utf8) {
            self.serialPort?.send(data)
        }
    }
}

extension ORSSerialPort: Identifiable {
    public var id: ORSSerialPort {return self}
}

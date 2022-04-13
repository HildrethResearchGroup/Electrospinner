//
//  ContentView.swift
//  Electrospinner
//
//  Created by Steven DiGregorio on 4/1/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        let titleFont: Font = .title2
        
        HStack {
            VStack {
                Text("Camera").font(titleFont)
                CameraView()
//                DinoLiteVideoView()
            }.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            
            Divider()
            
            VStack {
                Text("Syringe Pump").font(titleFont)
                SyringePumpView()
                Divider()
                Text("High-Voltage Supply").font(titleFont)
                VoltageSupplyView()
                Divider()
                Text("Parameters").font(titleFont)
                ParameterView()
                Divider()
                Text("Electrospinner").font(titleFont)
//                ElectrospinnerView()
            }.frame(minWidth: 100, idealWidth: 200, maxWidth: 300, maxHeight: .infinity, alignment: .topLeading)
            
        }.frame(minWidth: 500, maxWidth: .infinity, minHeight: 500, maxHeight: .infinity).padding()
    }
}

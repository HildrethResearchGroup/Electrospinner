//
//  ElectrospinnerView.swift
//  Electrospinner
//
//  Created by Steven DiGregorio on 4/5/22.
//

import SwiftUI

struct ElectrospinnerView: View {
    var body: some View {
        VStack{
            HStack {
                Button("Start"){}
                Text("Elapsed Time: 0 / 60 s")
            }
            Button("Abort"){}
        }
    }
}

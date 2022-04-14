//
//  PreferencesView.swift
//  Electrospinner
//
//  Created by Steven DiGregorio on 4/13/22.
//

import SwiftUI

struct PreferencesView: View {
    @ObservedObject var electrospinner: Electrospinner
    var body: some View {
        VStack {
            HStack {
                Text("Save Location")
                Spacer()
                Button("Browse...") {importURL()}
            }
            Text(electrospinner.folderURL?.absoluteString ?? "No Folder Selected")
                .frame(maxWidth: .infinity)
                .padding()
                .overlay(RoundedRectangle(cornerRadius: 3)
                            .stroke(Color.gray, lineWidth: 3))
                
        }.padding()
    }
    
    func importURL() {
        let panel = NSOpenPanel()
        panel.canChooseFiles = false
        panel.allowsMultipleSelection = false
        panel.canChooseDirectories = true
        if panel.runModal() == .OK {
            electrospinner.folderURL = panel.url
        }
    }
}

//
//  CameraView.swift
//  Electrospinner
//
//  Created by Steven DiGregorio on 4/1/22.
//

import SwiftUI

struct CameraView: View {
    var imageURL = Bundle.main.url(forResource: "ExamplePhoto", withExtension: "png")
    
    var body: some View {
        VStack {
            
            AsyncImage(url: imageURL) {image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            } placeholder: {
                ProgressView()
            }
            
            Text("Recording in Progress")
            
        }.frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

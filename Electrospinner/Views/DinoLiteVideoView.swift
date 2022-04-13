//
//  DinoLiteVideoView.swift
//  Electrospinner
//
//  Created by Steven DiGregorio on 4/5/22.
//


import SwiftUI
import AVKit

struct DinoLiteVideoView: View {
    let player = AVPlayer(url: Bundle.main.url(forResource: "ExampleVideo", withExtension: "mov")!)
    let endMonitor = NotificationCenter.default.publisher(for: NSNotification.Name.AVPlayerItemDidPlayToEndTime)
    
    var body: some View {
        
        VStack(alignment: .trailing) {
            VideoPlayer(player: player)
                .frame(width: 640, height: 360)
                .onAppear {
                    player.play()
                }
                .onReceive(endMonitor) { _ in
                    player.seek(to: .zero)
                    player.play()
                }
            
            Text("Recording in Progress").font(.caption).foregroundColor(Color.secondary)
        }
    }
}

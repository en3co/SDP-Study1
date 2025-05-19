//
//  SDP_Study_1App.swift
//  SDP Study 1
//
//  Created by Enrico Arapi on 02/04/2025.
//
//  *AIDED USING:
//
//  YouTube:
//  https://www.youtube.com/watch?v=fh1zb9jjtr0
//  https://www.youtube.com/watch?v=v1FasgV5Hm8
//
//  Grok:
//  https://grok.com/share/bGVnYWN5_4e085437-5b4a-4e79-857c-416243838d60
//  https://grok.com/share/bGVnYWN5_6dca8a20-ff6a-4757-ab05-4da702e2ee98
//  https://grok.com/share/bGVnYWN5_8420b0b0-ddcd-4d6e-b646-600e0887c9c7
//

import SwiftUI

@main
struct SDP_Study_1App: App {
    @StateObject private var appModel = AppModel()
    
    // The scene
    var body: some Scene {
        
        // Window with the slides
        WindowGroup {
            ContentView()
                .environmentObject(appModel)
        }
        // Sets a default size to the window
        // Can be adjusted but this sets it out proportionally pleasing
        .defaultSize(width: 500, height: 400)
        
        // VolumeView.swift is given the reference name "Volume" to be referenced elsewhere
        WindowGroup(id: "Volume") {
            VolumeView()
                .environmentObject(appModel)
        }
        .windowStyle(.volumetric) // Defines window type as volumetric
        .windowResizability(.automatic) // Supposedly resizable but VisionOS doesn't really allow this post-importing into environment...
        .defaultSize(width: 0.4, height: 0.05, depth: 0.4, in: .meters)  // Default size, also defined in VolumeView.swift
    }
}

#Preview(windowStyle: .automatic) {
    ContentView()
        .environmentObject(AppModel())
}

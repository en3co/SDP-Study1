//
//  AppModel.swift
//  SDP Study 1
//
//  Created by Enrico Arapi on 02/04/2025.
//

import SwiftUI

@MainActor
class AppModel: ObservableObject {
    let immersiveSpaceID = "ImmersiveSpace"
    enum ImmersiveSpaceState {
        case closed
        case inTransition
        case open
    }
    @Published var immersiveSpaceState = ImmersiveSpaceState.closed
    @Published var highlightedParts: [HighlightedPart] = []
}

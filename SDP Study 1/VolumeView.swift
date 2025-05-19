//
//  VolumeView.swift
//  SDP Study 1
//
//  Created by Enrico Arapi on 02/04/2025.
//
//  View for Volumetric model
//

// Imports
import SwiftUI
import RealityKit
import RealityKitContent
import RealityFoundation

// Array for highlighted part elements
struct HighlightedPart: Equatable {
    let parts: [String] // Supports multiple entities
    let color: Color
    
    // Equality based on 'parts' array
    static func == (lhs: HighlightedPart, rhs: HighlightedPart) -> Bool {
        return lhs.parts == rhs.parts
    }
}

// Main view
struct VolumeView: View {

    @EnvironmentObject var appModel: AppModel
    
    // Variables for array elements
    @State private var highlightedEntities: [String: Entity] = [:]
    @State private var originalMaterials: [Entity: [RealityFoundation.Material]] = [:]
    @State private var rootEntity: Entity?
    
    // Defines volume size (also in App @main)
    let targetVolumeSize = SIMD3<Float>(0.4, 0.05, 0.4)
    
    var body: some View {
        
        // Pulls in Scene (Reality Composer Pro scene with the motherboard.usdz inside)
        GeometryReader { geometry in
            RealityView { content in
                if rootEntity == nil {
                    guard let entity = try? Entity.load(named: "Scene", in: realityKitContentBundle) else {
                        print("Failed to load model")
                        return
                    }
                    
                    // Places it within the volumetric window
                    entity.position = [0, 0, 0.13]
                    rootEntity = entity
                    content.add(entity)
                    
                    // Lists in console the subcomponents (for checking it's all there)
                    registerNamedEntities(from: entity)
                }
                
                // Scales the model in the Volume appropriately
                // I confess that Grok helped me here
                if let rootEntity = rootEntity {
                    let bounds = rootEntity.visualBounds(relativeTo: nil)
                    let modelSize = bounds.extents
                    let maxModelDimension = max(modelSize.x, modelSize.y, modelSize.z)
                    let defaultWidthInPoints: Float = 700
                    let containerWidthInMeters = (Float(geometry.size.width) / defaultWidthInPoints) * targetVolumeSize.x
                    let scaleFactor = (containerWidthInMeters / maxModelDimension) * 0.95
                    rootEntity.scale = [scaleFactor, scaleFactor, scaleFactor]
                }
            }
        }
        // Update the highlighted parts
        .onChange(of: appModel.highlightedParts) { newParts in
            updateHighlights(with: newParts)
        }
    }
    
    // Registers and outputs the named entities in console
    private func registerNamedEntities(from entity: Entity) {
        if !entity.name.isEmpty {
            print("Registered entity: \(entity.name)") // Debug entity names
            highlightedEntities[entity.name] = entity
            for modelEnt in modelEntities(in: entity) {
                if let modelComp = modelEnt.components[ModelComponent.self] {
                    originalMaterials[modelEnt] = modelComp.materials as? [RealityFoundation.Material]
                }
            }
        }
        // Including children
        for child in entity.children {
            registerNamedEntities(from: child)
        }
    }
    
    // Gets model entities from the slide lists in ContentView.swift
    private func modelEntities(in entity: Entity) -> [Entity] {
        var result: [Entity] = []
        if entity.components.has(ModelComponent.self) {
            result.append(entity)
        }
        for child in entity.children {
            result.append(contentsOf: modelEntities(in: child))
        }
        return result
    }
    
    // Update highlights on model components
    private func updateHighlights(with newHighlightedParts: [HighlightedPart]) {
        var entitiesToHighlight: [Entity: Color] = [:]
        for highlightedPart in newHighlightedParts {
            for partName in highlightedPart.parts {
                
                // Debugging for if the components are/aren't in the model .usdz
                if let entity = highlightedEntities[partName], entity.components.has(ModelComponent.self) {
                    entitiesToHighlight[entity] = highlightedPart.color
                    print("Highlighting \(entity.name) in \(highlightedPart.color)")
                } else {
                    print("Warning: Entity '\(partName)' not found or has no ModelComponent")
                }
            }
        }
        
        // Apply highlights to entitiesToHighlight
        // Again, Grok helped me here
        
        if let rootEntity = rootEntity {
            for modelEnt in modelEntities(in: rootEntity) {
                if let color = entitiesToHighlight[modelEnt] {
                    if let modelComp = modelEnt.components[ModelComponent.self] {
                        let highlightedMaterials = modelComp.materials.map { mat -> RealityFoundation.Material in
                            if var pbrMat = mat as? PhysicallyBasedMaterial {
                                pbrMat.emissiveColor = PhysicallyBasedMaterial.EmissiveColor(color: UIColor(color))
                                return pbrMat
                            }
                            return mat
                        }
                        modelEnt.components.set(ModelComponent(mesh: modelComp.mesh, materials: highlightedMaterials))
                    }
                } else {
                    if let original = originalMaterials[modelEnt] {
                        if let modelComp = modelEnt.components[ModelComponent.self] {
                            modelEnt.components.set(ModelComponent(mesh: modelComp.mesh, materials: original))
                        }
                    }
                }
            }
        }
    }
}

// Preview for Xcode
#Preview {
    VolumeView()
        .environmentObject(AppModel())
}

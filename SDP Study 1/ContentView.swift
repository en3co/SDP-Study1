//
//  ContentView.swift
//  SDP Study 1
//
//  Created by Enrico Arapi on 02/04/2025.
//

// Imports
import SwiftUI
import RealityKit
import RealityKitContent

// Define a struct to hold slide data with highlighted words and object elements
struct Slide {
    let title: String
    let body: String
    let highlightedWords: [(word: String, color: Color)]
    let highlightedParts: [HighlightedPart]
}

// HighlightWords function to find the specifc words from the body text
func highlightWords(in text: String, highlightedWords: [(word: String, color: Color)]) -> AttributedString {
    var attributedString = AttributedString(text)
    let string = text
    for (word, color) in highlightedWords {
        var searchStart = string.startIndex
        while let range = string.range(of: word, options: .caseInsensitive, range: searchStart..<string.endIndex) {
            let attrRange = AttributedString.Index(range.lowerBound, within: attributedString)!..<AttributedString.Index(range.upperBound, within: attributedString)!
            attributedString[attrRange].foregroundColor = color
            searchStart = range.upperBound
        }
    }
    return attributedString
}

// Main view for the slideshow UI panel
struct ContentView: View {
    @EnvironmentObject var appModel: AppModel
    
    // Variables for the immersive space (there by default)
    @Environment(\.openImmersiveSpace) var openImmersiveSpace
    @Environment(\.dismissImmersiveSpace) var dismissImmersiveSpace
    
    // Variable to open the model as a window
    @Environment(\.openWindow) var openWindow
    
    // Array for the slides including a title, body and then the related highlighted words/elements on the motherboard
    let slides: [Slide] = [
        Slide(title: "ATX Motherboard Tutorial", body: "Designed by Enrico Arapi", highlightedWords: [], highlightedParts: []),
        Slide(title: "What is a motherboard?", body: "A motherboard is the main circuit board inside a computer which connects all of the most important components together. \n\n If you were to imagine yourself as a computer, the motherboard would be your central nervous system, which co-ordinates all the different components (organs) to have power and data flow.", highlightedWords: [], highlightedParts: []),
        Slide(title: "What does 'ATX' mean?", body: "ATX stands for 'Advanced Technology eXtended' - a standardised motherboard layout patented by David Dent at Intel in 1995. \n\n It is one of the most common motherboard designs, and many smaller scale boards use similar layouts whilst changing the dimensions of the form factor.", highlightedWords: [], highlightedParts: []),
        Slide(title: "How does it all connect?", body: "Motherboards use copper traces between components to carry electrical current and data across the board in pulses of charge. \n\n This tutorial uses a simplified direct-A-to-B approach to show these connections easily, but a real motherboard can have up to thousands of etched copper traces between components!", highlightedWords: [("simplified direct-A-to-B", .red)], highlightedParts: [
            
            // Copper connections
            HighlightedPart(parts:["Cube_009", "Cube_267", "Cube_285", "Cube_321", "Cube_322","Cube_323", "Cube_324", "Cube_325", "Cube_326", "Cube_327", "Cube_328", "Cube_336", "Cube_342", "Cube_329", "Cube_333", "Cube_334", "Cube_335", "Cube_337", "Cube_338", "Cube_339", "Cube_340", "Cube_341", "Cube_343", "Cube_344", "Cube_345", "Cube_346", "Cube_348", "Cube_349", "Cube_350", "Cube_351", "Cube_352", "Cube_353", "Cube_354", "Cube_355", "Cube_357", "Cube_356", "Cube_359", "Cube_360", "Cube_358", "Cube_361", "Cube_362", "Cube_363", "Cube_364", "Cube_365", "Cube_366", "Cube_092", "Cube_093", "Cube_094", "Cube_095", "Cube_096", "Cube_097", "Cube_098", "Cube_099", "Cube_100", "Cube_110", "Cube_111", "Cube_113", "Cube_347", "Cube_330", "Cube_331", "Cube_332", "Cube_112"], color: .red)
        ]),
        Slide(title: "Why is it green?", body: "Typically, a solder mask protective resin is applied to a motherboard to prevent the oxidation of its copper connections. \n\n Green was also traditionally used because it was cheaper not to colour a board (as it would be inside), and it also provided a good contrast against the components during assembly and repair by technicians.", highlightedWords: [], highlightedParts: [
            
            // Board
            HighlightedPart(parts: ["board_v2"], color: .green)
        ]),
        Slide(title: "How is it powered?", body: "A motherboard wouldn't be going anywhere without a power supply. \n\n Typical modern boards contain two connectors - one 24-pin connector for the majority of the components, and a smaller 8-pin auxillary connector which powers the CPU.", highlightedWords: [("24-pin connector", .cyan), ("8-pin auxillary", .yellow)], highlightedParts: [
            
            // 24-pin connector
            HighlightedPart(parts:["_24_slot"], color: .cyan),
            
            //8-pin connector
            HighlightedPart(parts:["_8_slot"], color: .yellow)
        ]),
        Slide(title: "What is the CPU?", body: "The CPU (Central Processing Unit) is the main processor of a computer - it resides in a protective bracket which also doubles as a base for the chip's pin connections to the board. \n\n The CPU is essentially the 'brain' of the computer; it delegates all the instructions to the other components to make the computer function.", highlightedWords: [("CPU (Central Processing Unit", .red)], highlightedParts: [
            
            // CPU
            HighlightedPart(parts:["cube_170"], color: .red)
        ]),
        Slide(title: "How does it turn on?", body: "Once power is supplied to a board, it activates the BIOS - aka the Basic Input Output System. \n\n BIOS is embeded in the board and is designed to check that all the components are functioning and supplied with electricity, as well as load up the computer Operating System (i.e. Windows) into memory.", highlightedWords: [("Basic Input Output System", .red)], highlightedParts: [
            
            // BIOS chip
            HighlightedPart(parts:["Cube_066", "Cube_130"], color: .red)
        ]),
        Slide(title: "What is 'Memory'", body: "Memory in this context is the the RAM - the Random Access Memory. \n\n RAM holds all the current instructions that the CPU needs but cannot be performing; think of it like your short-term memory. \n\n This motherboard model has 4 upgradable RAM slots linked to the CPU.", highlightedWords: [("RAM slots", .red)], highlightedParts: [
            
            // RAM slots
            HighlightedPart(parts:["Cube_301", "Cube_302", "Cube_303", "Cube_304", "Cube_305", "Cube_306", "Cube_307", "Cube_308", "Cube_309", "Cube_310", "Cube_311", "Cube_312", "Cube_313", "Cube_314", "Cube_315", "Cube_316", "Cube_317", "Cube_318", "Cube_319", "Cube_320", ], color: .red)
        ]),
        Slide(title: "What else is linked to the CPU?", body: "BIOS and RAM are not the only things that link to the CPU - there are many other components that have direct connections to speed up access and control. \n\n Some of these include the PCI slots and the North/Southbridge chips...", highlightedWords: [("PCI slots", .yellow), ("North/Southbridge chips", .cyan)], highlightedParts: [
            
            // PCI slots
            HighlightedPart(parts:["PCIEX1_1", "PCIEX1_2", "Cube_250", "Cube_256", "Cube_246", "Cube_247", "Cube_248", "Cube_249", "Cube_251", "Cube_252", "Cube_253", "Cube_254", "Cube_257", "Cube_298", "Cube_299", "Cube_300"], color: .yellow),
            
            // SB chip
            HighlightedPart(parts:["cube_106"], color: .cyan)
        ]),
        Slide(title: "PCI slots", body: "PCI slots are like expansion slots for the motherboard - they allow extra components to connect, such as a graphics, sound or network card. \n\n They come in multiple configurations of different 'lanes' (1, 4 or 16), and also have two variants, PCI and PCle, the latter being newer and faster (with the 'e' standing for 'Express')", highlightedWords: [], highlightedParts: [
            
            // PCI slots
            HighlightedPart(parts:["PCIEX1_1", "PCIEX1_2", "Cube_250", "Cube_256", "Cube_246", "Cube_247", "Cube_248", "Cube_249", "Cube_251", "Cube_252", "Cube_253", "Cube_254", "Cube_257", "Cube_298", "Cube_299", "Cube_300"], color: .yellow)
        ]),
        Slide(title: "North/Southbridge chips", body: "As well as the CPU, traditionally there used to be 2 supporting chips that handled additional specialised processes. This is why computers are said to have a 'chipset' (plural). \n\n The northbridge used to handle graphics and memory, before it was integrated into the CPU, whilst the southbridge still remains separate...", highlightedWords: [], highlightedParts: [
            
            // CPU
            HighlightedPart(parts:["cube_170"], color: .red),
            
            // SB chip
            HighlightedPart(parts:["cube_106"], color: .cyan)
        ]),
        Slide(title: "The Southbridge", body: "The southbridge (SB) is the CPU's supporting chip and manages most of the other components on the board - this includes things like USB ports, storage and even some of the PCI slots. \n\n In some cases with Intel chipsets, the southbridge is also known as the 'Platform Controller Hub', but is still fundamentally the same thing.", highlightedWords: [], highlightedParts: [
            
            // SB chip
            HighlightedPart(parts:["cube_106"], color: .cyan)
        ]),
        Slide(title: "Other chips", body: "Alongside the southbridge, there are other chips that are even more specialised to controlling certain components, including for things like: \n\n - Ports (I/O) \n\n - Audio enhancement for microphones/speakers \n\n - Display management", highlightedWords: [("Ports", .yellow), ("Audio enhancement", .cyan), ("Display management", .pink)], highlightedParts: [
            
            // Ports chip
            HighlightedPart(parts:["cube_043"], color: .yellow),
            
            // Audio chip
            HighlightedPart(parts:["cube_085"], color: .cyan),
            
            // Display chip
            HighlightedPart(parts:["cube_001"], color: .pink)
        ]),
        Slide(title: "Input/Output ports", body: "As you may have noticed, on one side of the board there are many different components which resemble the Input/Output (I/O) ports. \n\n Some such as HDMI, USB or Ethernet may look familiar, whilst others like KBMS or VGA may not be as commonplace nowadays - in most boards these are customised to the computer's requirements.", highlightedWords: [("HDMI", .yellow), ("USB", .cyan), ("Ethernet", .pink)], highlightedParts: [
            
            //HDMI
            HighlightedPart(parts:["Cube_001", "Cube_003"], color: .yellow),
            
            //USB
            HighlightedPart(parts:["Cube_012"], color: .cyan),
            
            //Ethernet
            HighlightedPart(parts:["Cube_013"], color: .pink)
        ]),
        Slide(title: "SATA & M.2", body: "On the other side of the board are SATA (Serial ATA) ports, and the M.2 connector which is in the middle. Both of these are used for connecting external SSD storage drives. \n\n However, although there are many ports, they may not all be able to be used at once as they often use the same connection paths...", highlightedWords: [("SATA (Serial ATA)", .yellow), ("M.2 connector", .cyan)], highlightedParts: [
            
            // SATA ports
            HighlightedPart(parts:["Cube_226", "Cube_229", "Cube_232", "Cube_235", "Cube_200", "Cube_211"], color: .yellow),
            
            // M.2 connector
            HighlightedPart(parts:["Cube_245"], color: .cyan)
        ]),
        Slide(title: "Additional components", body: "As well as this, this board includes a few more smaller components on worth knowing about such as: \n\n - Pin connectors for mounting fans, components, or the board to a case. \n\n - A circle 'CMOS' battery to power a long lasting analogue device clock.\n\n - Connectors for more ports (such as audio jacks) or device sensors.", highlightedWords: [("Pin connectors", .yellow), ("'CMOS' battery", .cyan), ("ports", .pink)], highlightedParts: [
            
            // Pin connectors
            HighlightedPart(parts:["Cube_038", "Cube_043", "Cube_048", "Cube_143", "Cube_240", "Cube_053", "Cube_062", "Cube_063", "Cube_071", "Cube_101", "Cube_119", "Cube_128", "Cube_190", "Cube_208", "Cube_217"], color: .yellow),
            
            // CMOS
            HighlightedPart(parts:["Cylinder_083"], color: .cyan),
            
            // Port connectors
            HighlightedPart(parts:["Cube_075", "Cube_074", "Cube_076", "Cube_077", "Cube_078"], color: .pink)
        ]),
        Slide(title: "The End!", body: "Congratulations! Hopefully you now understand the basics of an ATX motherboard and how it works!", highlightedWords: [], highlightedParts: [])
    ]
    
    // Current slide
    @State private var currentSlideIndex = 0
    
    // View on the window
    var body: some View {
        
        // Vstack for everything
        VStack {
            
            // Header
            Text(slides[currentSlideIndex].title)
                .font(.title)
                .multilineTextAlignment(.center)
                .padding(.top, 24)
                .padding(.bottom, 12)
            
            // Body
            Text(highlightWords(in: slides[currentSlideIndex].body, highlightedWords: slides[currentSlideIndex].highlightedWords))
                .font(.body)
                .multilineTextAlignment(.leading)
                .padding(.horizontal, 24)
            
            Spacer()
            
            // Buttons
            // Nested Hstack so they are horizontally spaced either side of the window
            // Exceptions for first and last slides which only have one button
            
            if currentSlideIndex == 0 && slides.count > 1 {
                HStack {
                    // First slide is just one button, centred
                    Spacer()
                    Button("Pinch to Start") { currentSlideIndex += 1 }
                        .buttonStyle(.bordered)
                    Spacer()
                }
                .padding(.bottom, 52)
            } else if currentSlideIndex == slides.count - 1 {
                
                HStack {
                    
                    // Restart = back to first slide, centred
                    Spacer()
                    Button("Restart") { currentSlideIndex = 0 }
                        .buttonStyle(.bordered)
                    Spacer()
                }
                .padding(.bottom, 52)
            } else if slides.count > 1 {
                HStack {
                    
                    // Back = -1, Next = +1
                    Button("Back") { currentSlideIndex -= 1 }
                        .buttonStyle(.bordered)
                    
                    // Spaced to either side of the window no matter the size
                    Spacer()
                    
                    Button("Next") { currentSlideIndex += 1 }
                        .buttonStyle(.bordered)
                }
                .padding(.bottom, 24)
            }
        }
        .padding(10)
        
        // Update slide on button press in order
        .onChange(of: currentSlideIndex) { newIndex in
            appModel.highlightedParts = slides[newIndex].highlightedParts
        }
        
        // When slides appear, also spawn in Volume (motherboard)
        // See VolumeView.swift
        .onAppear {
            openWindow(id: "Volume")
            appModel.highlightedParts = slides[currentSlideIndex].highlightedParts
        }
    }
}

// Preview for Xcode
#Preview(windowStyle: .automatic) {
    ContentView()
        .environmentObject(AppModel())
}

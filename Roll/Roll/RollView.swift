import SwiftUI
import CoreHaptics

struct RollView: View {
    @Environment(\.managedObjectContext) var moc
    @State private var currentRoll: Int? = nil
    @State private var engine: CHHapticEngine?
    @State private var selectedDie = 0
    
    private let dieSides = ["4", "6", "8", "10", "12", "20", "100"]
    
    var body: some View {
        VStack(spacing: 20) {
            Section(header: Text("Select your die size.")) {
                Picker("Die sides", selection: $selectedDie) {
                    ForEach(0 ..< dieSides.count) {
                        Text("\(self.dieSides[$0])")
                    }
                }
            }
            
            Button(action: {
                self.roll()
                self.generateFeedback()
            }) {
                Text("Roll the die!")
            }
            
            if currentRoll != nil {
                Text("You rolled a \(currentRoll!)!")
            }
        }
    }
    
    func add(_ diceRoll: Int, with sides: Int) {
           let roll = Roll(context: self.moc)
           roll.date = Date()
           roll.diceSideNumber = Int16(sides)
           roll.id = UUID()
           roll.result = Int16(diceRoll)
           
           try? self.moc.save()
       }
    
    func generateFeedback() {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
        var events = [CHHapticEvent]()

        let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: 0.5)
        let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: 0.5)
        let event = CHHapticEvent(eventType: .hapticTransient, parameters: [intensity, sharpness], relativeTime: 0)
        events.append(event)

        do {
            let pattern = try CHHapticPattern(events: events, parameters: [])
            let player = try engine?.makePlayer(with: pattern)
            try player?.start(atTime: 0)
        } catch {
            print("Failed to play pattern: \(error.localizedDescription).")
        }
    }
    
    func prepareHaptics() {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
        
        do {
            self.engine = try CHHapticEngine()
            try engine?.start()
        } catch {
            print("There was an error creating the engine: \(error.localizedDescription)")
        }
    }
    
    func roll() {
        guard let sides = Int(dieSides[selectedDie]) else { return }
        
        let diceRoll = Int.random(in: 1...sides)
        currentRoll = diceRoll
        add(diceRoll, with: sides)
    }
}

struct RollView_Previews: PreviewProvider {
    static var previews: some View {
        RollView()
    }
}

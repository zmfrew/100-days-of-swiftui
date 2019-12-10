import SwiftUI

struct ContentView: View {
    @State private var inputNumber = ""
    @State private var inputUnit = 0
    @State private var outputUnit = 0
    
    private let units = ["Meters", "Miles", "Kilometers"]
    
    var convertedDistance: String {
        let distance = Double(inputNumber) ?? 0
        let inputUnitString = units[inputUnit]
        let outputUnitString = units[outputUnit]
        
        if inputUnitString == "Meters" {
            let measurement = Measurement(value: distance, unit: UnitLength.meters)
            
            if outputUnitString == "Meters" {
                return "\(measurement.value)"
            } else if outputUnitString == "Kilometers" {
                return "\(measurement.converted(to: .kilometers).value)"
            } else {
                return "\(measurement.converted(to: .miles).value)"
            }
        } else if inputUnitString == "Kilometers" {
            let measurement = Measurement(value: distance, unit: UnitLength.kilometers)
            
            if outputUnitString == "Kilometers" {
                return "\(measurement.converted(to: .meters).value)"
            } else if outputUnitString == "Kilometers" {
                return "\(measurement.value)"
            } else {
                return "\(measurement.converted(to: .miles).value)"
            }
        } else {
            let measurement = Measurement(value: distance, unit: UnitLength.miles)
            
            if outputUnitString == "Meters" {
                return "\(measurement.converted(to: .meters).value)"
            } else if outputUnitString == "Kilometers" {
                return "\(measurement.converted(to: .kilometers).value)"
            } else {
                return "\(measurement.value)"
            }
        }
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("What unit do you want to start with?")) {
                    Picker("Unit", selection: $inputUnit) {
                        ForEach(0 ..< units.count) {
                            Text("\(self.units[$0])")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                Section(header: Text("Distance to convert")) {
                    TextField("Distance", text: $inputNumber)
                    .keyboardType(.numberPad)
                }
                
                Section(header: Text("What unit do you want to convert to?")) {
                    Picker("Unit", selection: $outputUnit) {
                        ForEach(0 ..< units.count) {
                            Text("\(self.units[$0])")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                Section(header: Text("Converted Distance")) {
                    Text("\(Double(convertedDistance) ?? 0, specifier: "%.2f")")
                }
            }
        .navigationBarTitle("Convert")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

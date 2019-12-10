import SwiftUI

struct OpacityModifier: ViewModifier {
    let amount: Double
    
    func body(content: Content) -> some View {
        content.opacity(amount)
    }
}

extension AnyTransition {
    static var opaque: AnyTransition {
        .modifier(active: OpacityModifier(amount: 0.25),
                  identity: OpacityModifier(amount: 1))
    }
}

struct ContentView: View {
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var isCorrect = false
    @State private var flaggedFlag = Int.random(in: 0...2)
    @State private var rotationAmount = 0.0
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var score = 0
    @State private var transitionType: AnyTransition = .identity
    
    let labels = [
        "Estonia": "Flag with three horizontal stripes of equal size. Top stripe blue, middle stripe black, bottom stripe white",
        "France": "Flag with three vertical stripes of equal size. Left stripe blue, middle stripe white, right stripe red",
        "Germany": "Flag with three horizontal stripes of equal size. Top stripe black, middle stripe red, bottom stripe gold",
        "Ireland": "Flag with three vertical stripes of equal size. Left stripe green, middle stripe white, right stripe orange",
        "Italy": "Flag with three vertical stripes of equal size. Left stripe green, middle stripe white, right stripe red",
        "Nigeria": "Flag with three vertical stripes of equal size. Left stripe green, middle stripe white, right stripe green",
        "Poland": "Flag with two horizontal stripes of equal size. Top stripe white, bottom stripe red",
        "Russia": "Flag with three horizontal stripes of equal size. Top stripe white, middle stripe blue, bottom stripe red",
        "Spain": "Flag with three horizontal stripes. Top thin stripe red, middle thick stripe gold with a crest on the left, bottom thin stripe red",
        "UK": "Flag with overlapping red and white crosses, both straight and diagonally, on a blue background",
        "US": "Flag with red and white stripes of equal size, with white stars on a blue background in the top-left corner"
    ]
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.blue, .black]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 30) {
                VStack {
                    Text("Tap the flag of")
                        .foregroundColor(.white)
                    Text(countries[correctAnswer])
                        .foregroundColor(.white)
                        .font(.largeTitle)
                        .fontWeight(.black)
                }
                
                ForEach(0 ..< 3) { num in
                    if num == self.correctAnswer {
                        Button(action: {
                            withAnimation(.default) {
                                self.flagTapped(num)
                            }
                        }) {
                            if num == self.flaggedFlag {
                                Image(self.countries[num])
                                    .renderingMode(.original)
                                    .flagged()
                                    .accessibility(label: Text(self.labels[self.countries[num], default: "Unknown flag"]))

                            } else {
                                Image(self.countries[num])
                                    .renderingMode(.original)
                                    .accessibility(label: Text(self.labels[self.countries[num], default: "Unknown flag"]))

                            }
                        }
                        .rotation3DEffect(.degrees(self.rotationAmount), axis: (x: 0, y: 1, z: 0))
                    } else {
                        Button(action: {
                            withAnimation(.default) {
                                self.flagTapped(num)
                            }
                        }) {
                            if num == self.flaggedFlag {
                                Image(self.countries[num])
                                    .renderingMode(.original)
                                    .flagged()
                            } else {
                                Image(self.countries[num])
                                    .renderingMode(.original)
                            }
                        }
                        .transition(self.transitionType)
                    }
                }
                
                Text("Current score: \(score)")
                    .foregroundColor(.white)
                
                Spacer()
            }
        }
        .alert(isPresented: $showingScore) {
            Alert(title: Text(scoreTitle), message: Text("Your score is \(score)"), dismissButton: .default(Text("Continue"), action: {
                withAnimation(.default) {
                    self.askQuestion()
                }
            }))
        }
    }
}

extension ContentView {
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct"
            score += 1
            rotationAmount = 360
            transitionType = .opaque
        } else {
            if score > 0 {
                score -= 1
            } else {
                score = 0
            }
            scoreTitle = "Incorrect! That is \(countries[number])'s flag!"
            transitionType = .slide
        }
        
        showingScore = true
    }
    
    func askQuestion() {
        transitionType = .identity
        rotationAmount = 0
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        flaggedFlag = Int.random(in: 0...2)
    }
}

struct FlagImage: ViewModifier {
    func body(content: Content) -> some View {
        content
            .clipShape(Capsule())
            .overlay(Capsule().stroke(Color.black, lineWidth: 1))
            .shadow(color: .black, radius: 2)
    }
}

extension View {
    func flagged() -> some View {
        self.modifier(FlagImage())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

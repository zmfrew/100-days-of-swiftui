import SwiftUI

struct ContentView: View {
    @State private var currentChoice = 0
    @State private var currentScore = 0
    @State private var randomMoveIndex = Int.random(in: 0...2)
    @State private var shouldWin = Bool.random()
    @State private var lastResult = "no games played yet"
    @State private var gameCount = 1
    
    private let possibleMoves = ["rock", "paper", "scissors"]
    
    var body: some View {
        Section {
            if gameCount == 10 {
                Text("Your score was: \(currentScore)/10")
                    .font(.largeTitle)
                    .fontWeight(.bold)
            
                Button(action: {
                    self.playAgain()
                }) {
                    Text("Play again?")
                }
            } else {
                VStack {
                    Text("Current score \(currentScore)")
                    Text("You should \(shouldWin ? "win" : "lose") this turn.")
                    Image(possibleMoves[randomMoveIndex])
                }
                
                HStack {
                    ForEach(possibleMoves, id: \.self) { move in
                        Button(action: {
                            self.moveSelected(move)
                        }) {
                            Image(move)
                                .renderingMode(.original)
                        }
                    }
                }
                
                Text("Last result: \(lastResult)")
            }
        }
    }
    
    func moveSelected(_ move: String) {
        let randomMove = possibleMoves[randomMoveIndex]
        
        let result = playGame(userMove: move, computerMove: randomMove)
        lastResult = result
        
        if result == "win" && shouldWin {
            currentScore += 1
            lastResult += " correct selection"
        } else if result == "lose" && shouldWin == false {
            currentScore += 1
            lastResult += " correct selection"
        } else if result == "lose" && shouldWin {
            currentScore -= 1
            lastResult += " incorrect selection"
        } else if result == "win" && shouldWin == false {
            currentScore -= 1
            lastResult += " incorrect selection"
        } else {
            lastResult += " incorrect selection"
        }
        
        randomMoveIndex = Int.random(in: 0...2)
        shouldWin = Bool.random()
        gameCount += 1
    }
    
    func playAgain() {
        randomMoveIndex = Int.random(in: 0...2)
        shouldWin = Bool.random()
        gameCount = 0
    }
    
    func playGame(userMove: String, computerMove: String) -> String {
        if userMove == computerMove {
            return "tie"
        } else if userMove == "paper" && computerMove == "rock" {
            return "win"
        } else if userMove == "scissors" && computerMove == "paper" {
            return "win"
        } else if userMove == "rock" && computerMove == "scissors" {
            return "win"
        }
        
        return "lose"
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

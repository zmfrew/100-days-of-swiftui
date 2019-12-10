import SwiftUI

struct ContentView: View {
    @State private var currentScore = 0
    @State private var questionsAnswered = 0
    @State private var currentQuestion: Question?
    @State private var questionIndex = 0
    @State private var questions: [Question] = []
    @State private var isPlaying = false
    @State private var isGameOver = true
    @State private var multiplicationTable = 1
    @State private var numberOfQuestionsIndex = "2"
    
    private let potentialQuestions = ["5", "10", "20", "All"]
    var numberOfQuestions: Int {
        let numberAsString = potentialQuestions[Int(numberOfQuestionsIndex)!]
        
        if numberAsString == "All" {
            return multiplicationTable * multiplicationTable
        }
        
        return Int(numberAsString)!
    }
    
    var body: some View {
        NavigationView {
            Group {
                VStack {
                    if !isPlaying {
                        Form {
                            Section(header: Text("What times tables would you like to practice?")) {
                                Stepper(value: $multiplicationTable, in: 1...12) {
                                    Text("\(multiplicationTable)")
                                }
                            }
                            .font(.headline)
                            
                            Section(header: Text("How many questions?")) {
                                Picker("Number of questions", selection: $numberOfQuestionsIndex) {
                                    ForEach(0..<potentialQuestions.count) {
                                        Text("\(self.potentialQuestions[$0])")
                                    }
                                }
                                .pickerStyle(SegmentedPickerStyle())
                            }
                            .font(.headline)
                        }
                        
                        Button("Let's multiply!") {
                            self.questions = self.generateQuestions()
                            self.questionsAnswered = 0
                            self.currentQuestion = self.questions.first!
                            self.isPlaying = true
                            self.isGameOver = false
                        }
                    } else {
                        Section {
                            if currentQuestion != nil {
                                Text("What is \(currentQuestion!.display)")
                                Spacer()
                                
                                ForEach(0..<4) { num in
                                    Button("\(self.currentQuestion!.answers[num])") {
                                        withAnimation(.default) {
                                            self.answerSelected(num)
                                        }
                                    }
                                    .frame(width: 164, height: UIScreen.main.bounds.height / 16)
                                    .roundedButton()
                                    Spacer()
                                }
                            }
                        }
                        Text("\(questionsAnswered)/\(self.numberOfQuestions) answered")
                        Text("Current score: \(currentScore)")
                            .font(.largeTitle)
                    }
                }
            }
            .navigationBarTitle("Edutainment")
        }
        .alert(isPresented: $isGameOver) {
            Alert(title: Text("Your score was \(self.currentScore)/\(self.numberOfQuestions)"),
                  message: Text("Do you want to play again?"),
                  primaryButton: .default(Text("Yes"), action: {
                    self.resetGame()
                    self.isPlaying = true
                  }),
                  secondaryButton: .cancel(Text("No")), action: {
                    self.resetGame()
            })
        }
    }
    
    func answerSelected(_ num: Int) {
        let answer = currentQuestion!.answers[num]
        
        if answer == currentQuestion!.answer {
            currentScore += 1
        } else {
            if currentScore > 0 {
                currentScore -= 1
            } else {
                currentScore = 0
            }
        }
        
        questionsAnswered += 1
        setupNextQuestion()
    }
    
    func generateQuestions() -> [Question] {
         return (1...numberOfQuestions).map { _ in
            Question(multiplicator: multiplicationTable,
                     number: Int.random(in: 1...multiplicationTable))
        }
    }
    
    func setupNextQuestion() {
        if questionsAnswered == numberOfQuestions {
            isGameOver = true
        }
        
        guard !questions.isEmpty, questionIndex < questions.count - 1 else { return }
        
        questionIndex += 1
        currentQuestion = questions[questionIndex]
    }
    
    func resetGame() {
        questionsAnswered = 0
        isPlaying = false
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

import SwiftUI

struct ContentView: View {
    @State private var usedWords: [String] = []
    @State private var rootWord = ""
    @State private var newWord = ""
    @State private var errorTitle = ""
    @State private var errorMessage = ""
    @State private var showingError = false
    @State private var currentScore = 0
    @State private var wordCount = 0
    
    var body: some View {
        NavigationView {
            GeometryReader { geo in
                VStack {
                    VStack {
                        Text("Score: \(self.currentScore)")
                            .font(.headline)
                        Text("Word count: \(self.wordCount)")
                            .font(.headline)
                    }
                    
                    TextField("Enter your word", text: self.$newWord, onCommit: self.addNewWord)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .autocapitalization(.none)
                        .padding()
                        .disableAutocorrection(true)
                    
                    
                    List(self.usedWords, id: \.self) { word in
                        HStack {
                            Image(systemName: "\(word.count).circle")
                            Text(word)
                        }
                        .accessibilityElement(children: .ignore)
                        .accessibility(label: Text("\(word), \(word.count) letters"))
                    }
                    .offset(x: 5.0 * CGFloat(self.wordCount), y: 0.0)
                }
                .navigationBarTitle(self.rootWord)
                .onAppear(perform: self.startGame)
                .alert(isPresented: self.$showingError) {
                    Alert(title: Text(self.errorTitle), message: Text(self.errorMessage), dismissButton: .default(Text("OK")))
                }
            }
        }
    }
    
    func addNewWord() {
        let answer = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard answer.count > 0 else { return }
        
        guard isOriginal(word: answer) else {
            wordError(title: "Word used already", message: "Be more original")
            return
        }
        
        guard isPossible(word: answer) else {
            wordError(title: "Word not recognized", message: "You can't just make them up you know")
            return
        }
        
        guard isReal(word: answer) else {
            wordError(title: "Word not possible", message: "That isn't a real word")
            return
        }
        
        guard answer.count >= 3 else {
            wordError(title: "Word too short", message: "Word must be 3 at least letters long")
            return
        }
        
        guard answer != rootWord else {
            wordError(title: "Really?", message: "You're better than that.. try harder")
            return
        }
        
        usedWords.insert(answer, at: 0)
        newWord = ""
        currentScore += answer.count
        wordCount += 1
    }
    
    func isOriginal(word: String) -> Bool {
        !usedWords.contains(word)
    }
    
    func isPossible(word: String) -> Bool {
        var tempWord = rootWord.lowercased()
        
        for letter in word {
            if let pos = tempWord.firstIndex(of: letter) {
                tempWord.remove(at: pos)
            } else {
                return false
            }
        }
        
        return true
    }
    
    func isReal(word: String) -> Bool {
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        
        return misspelledRange.location == NSNotFound
    }
    
    func startGame() {
        if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt"),
            let startWords = try? String(contentsOf: startWordsURL) {
            let allWords = startWords.components(separatedBy: "\n")
            rootWord = allWords.randomElement() ?? "silkworm"
            return
        }
        fatalError("Could not load start.text from bundle.")
    }
    
    func wordError(title: String, message: String) {
        errorTitle = title
        errorMessage = message
        showingError = true
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

/*
 let people = ["Finn", "Leia", "Luke", "Rey"]
 
 List(people, id: \.self) {
        Text($0)
    }
    .listStyle(GroupedListStyle())
 */

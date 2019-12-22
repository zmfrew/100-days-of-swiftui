struct Card: Codable {
    let prompt: String
    let answer: String

    static var example: Card {
        return Card(prompt: "Who played the Mandolorian", answer: "Pedro Pascal")
    }
}

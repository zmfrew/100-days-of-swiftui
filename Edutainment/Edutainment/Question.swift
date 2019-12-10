struct Question {
    let multiplicator: Int
    let number: Int
    let answer: Int
    let answers: [Int]
    let display: String
    
    init(multiplicator: Int, number: Int) {
        self.multiplicator = multiplicator
        self.number = number
        self.display = "\(number) * \(multiplicator)"
        self.answer = number * multiplicator
        
        if multiplicator == 0 || number == 0 {
            self.answers = [
                answer,
                multiplicator,
                number,
                multiplicator + 1
            ].shuffled()
        } else {
            self.answers = [
                answer,
                (multiplicator + 1) * number,
                (multiplicator - 1) * number,
                multiplicator * (number + 1),
            ].shuffled()
        }
    }
}

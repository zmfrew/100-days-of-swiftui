import SwiftUI

struct PreviousRollsView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: Roll.entity(), sortDescriptors: [
        NSSortDescriptor(keyPath: \Roll.date, ascending: false)]) var rolls: FetchedResults<Roll>
    
    var body: some View {
        NavigationView {
            List {
                ForEach(rolls, id: \.self) { roll in
                    HStack(spacing: 240) {
                        VStack {
                            Text("Result: \(roll.result)")
                                .font(.headline)
                            Text("\(roll.diceSideNumber)-sided die")
                                .font(.callout)
                        }
                        
                        Text("\(roll.displayDate)")
                            .font(.subheadline)
                    }
                }
            }
        }
    }
}

struct PreviousRollsView_Previews: PreviewProvider {
    static var previews: some View {
        PreviousRollsView()
    }
}

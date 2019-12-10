import SwiftUI

struct AddView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var activityContainer: ActivityContainer
    @State private var title = ""
    @State private var description = ""
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Title", text: $title)
                               
                TextField("Description", text: $description)
            }
            .navigationBarTitle("Add new habit")
            .navigationBarItems(trailing: Button("Save") {
                let activity = Activity(id: UUID(), title: self.title, description: self.description)
                self.activityContainer.activities.append(activity)
                self.presentationMode.wrappedValue.dismiss()
            })
        }
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView(activityContainer: ActivityContainer(activities: [
            Activity(id: UUID(), title: "Meditate", description: "Meditation has awesome benefits on my sanity"),
            Activity(id: UUID(), title: "Run", description: "🏃‍♂️ gotta hustle"),
            Activity(id: UUID(), title: "Work", description: "Somebody gotta make that 💰")
        ]))
    }
}

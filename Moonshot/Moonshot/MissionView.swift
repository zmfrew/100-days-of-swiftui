import SwiftUI

struct MissionView: View {
    @State private var imageScale: CGFloat = 0.7
    @State private var direction = Direction.down
    
    enum Direction {
        case down, up
    }
    
    struct CrewMember {
        let role: String
        let astronaut: Astronaut
    }
    
    let astronauts: [CrewMember]
    let currentMission: Mission
    let allMissions: [Mission]
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView(.vertical) {
                VStack {
                    Image(self.currentMission.image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: geometry.size.width * self.imageScale, height: geometry.size.height * self.imageScale)
                        .padding(.top)
                    
                    Text(self.currentMission.formattedLaunchDate)
                        .font(.headline)
                    
                    Text(self.currentMission.description)
                        .padding()
                    
                    ForEach(self.astronauts, id: \.role) { crewMember in
                        NavigationLink(destination: AstronautView(astronaut: crewMember.astronaut, missions: self.allMissions)) {
                            HStack {
                                Image(crewMember.astronaut.id)
                                    .resizable()
                                    .frame(width: 83, height: 60)
                                    .clipShape(Capsule())
                                    .overlay(Capsule().stroke(Color.primary, lineWidth: 1))
                                
                                VStack(alignment: .leading) {
                                    Text(crewMember.astronaut.name)
                                        .font(.headline)
                                    Text(crewMember.role)
                                        .foregroundColor(.secondary)
                                }
                                
                                Spacer()
                            }
                            .padding(.horizontal)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                    
                    Spacer(minLength: 25)
                }
            }
            .gesture(
                DragGesture()
                    .onChanged { drag in
                        withAnimation {
                            self.direction = drag.translation.height > 0 ? .up : .down
                            self.imageScale = self.direction == .up ? 0.70 : 0.20
                        }
                    }
            
            )
        }
        .navigationBarTitle(Text(currentMission.displayName))
    }
    
    init(mission: Mission, astronauts: [Astronaut], allMissions: [Mission]) {
        self.currentMission = mission
        self.astronauts = mission.crew.compactMap { member in
            let match = astronauts.first(where: { $0.id == member.name })!
            return CrewMember(role: member.role, astronaut: match)
        }
        self.allMissions = allMissions
    }
}

struct MissionView_Previews: PreviewProvider {
    static let missions: [Mission] = Bundle.main.decode("missions.json")
    static let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")

    static var previews: some View {
        MissionView(mission: missions[0], astronauts: astronauts, allMissions: missions)
    }
}


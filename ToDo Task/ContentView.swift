






import SwiftUI

struct ContentView: View {
    @State private var taskGroups: [TaskGroup] = [] // See MockData
    @State private var selectedGroup: TaskGroup? // selected group
    @State private var columnVisibility: NavigationSplitViewVisibility = .all // navigation side panel
    @State private var isShowingAddGroup = false
    @Environment(\.scenePhase) private var scenePhase
    let saveKey = "SavedTaskGroups"
    @Environment(\.dismiss) private var dismiss
    @Binding var profile: Profile
    
    // MARK: Mini Challenge Adding the functionality of DarkMode
    @AppStorage("isDarkMode") private var isDarkMode = false
    
    
    var body: some View {
        NavigationSplitView(columnVisibility: $columnVisibility) {
            // SIDEBAR
            List(selection: $selectedGroup) {
                ForEach(profile.groups) {group in
                    NavigationLink(value: group) {
                        Label(group.title, systemImage: group.symbolName)
                    }
                }
            } // End List
            .navigationTitle(profile.name)
            .listStyle(.sidebar)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "chevron.left")
                    }
                }
                ToolbarItem(placement: .primaryAction) {
                    Button {
                        isShowingAddGroup = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
        } detail : {
            if let group = selectedGroup {
                if let index = profile.groups.firstIndex(where: {$0.id == group.id}) {
                    TaskGroupDetailView(groups: $profile.groups[index])
                }
            } else {
                ContentUnavailableView("Select a Group", systemImage: "sidebar.left")
            }
        } // End Detail
        .navigationSplitViewStyle(.balanced)
        .navigationBarBackButtonHidden(true)
        .sheet(isPresented: $isShowingAddGroup){
            NewGroupView { newGroup in
                taskGroups.append(newGroup)
                selectedGroup = newGroup
            }
        }
    }
    func savedData() {
        if let encodedData = try? JSONEncoder().encode(profile.groups){
            UserDefaults.standard.set(encodedData, forKey: saveKey)
        }
    }
    
    func loadData() {
        if let savedData = UserDefaults.standard.data(forKey: saveKey) {
            if let decodeGroups = try? JSONDecoder().decode([TaskGroup].self, from: savedData) {
                profile.groups = decodeGroups
                return
            }
        }
        if profile.groups.isEmpty {
            profile.groups = TaskGroup.sampleData
        }
    }
    
}

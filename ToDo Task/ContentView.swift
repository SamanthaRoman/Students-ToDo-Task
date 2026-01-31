






import SwiftUI

struct ContentView: View {
    @State private var taskGroups: [TaskGroup] = [] // See MockData
    @State private var selectedGroup: TaskGroup? // selected group
    @State private var columnVisibility: NavigationSplitViewVisibility = .all // navigation side panel
    @State private var isShowingAddGroup = false
    @Environment(\.scenePhase) private var scenePhase
    let saveKey = "SavedTaskGroups"
    
    // MARK: Mini Challenge Adding the functionality of DarkMode
    @AppStorage("isDarkMode") private var isDarkMode = false
    
    
    var body: some View {
        NavigationSplitView(columnVisibility: $columnVisibility) {
            // SIDEBAR
            List(selection: $selectedGroup) {
                ForEach(taskGroups) {group in
                    NavigationLink(value: group) {
                        Label(group.title, systemImage: group.symbolName)
                    }
                }
            } // End List
            .navigationTitle("ToDo APP")
            .listStyle(.sidebar)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        isDarkMode.toggle()
                    } label: {
                        Image(systemName: isDarkMode ? "moon.fill" : "moon")
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
                if let index = taskGroups.firstIndex(where: {$0.id == group.id}) {
                    TaskGroupDetailView(groups: $taskGroups[index])
                }
            } else {
                ContentUnavailableView("Select a Group", systemImage: "sidebar.left")
            }
        } // End Detail
        .sheet(isPresented: $isShowingAddGroup){
            NewGroupView { newGroup in
                taskGroups.append(newGroup)
                selectedGroup = newGroup
            }
        }
    }
    func savedData() {
        if let encodedData = try? JSONEncoder().encode(taskGroups){
            UserDefaults.standard.set(encodedData, forKey: saveKey)
        }
    }
    
    func loadData() {
        if let savedData = UserDefaults.standard.data(forKey: saveKey) {
            if let decodeGroups = try? JSONDecoder().decode([TaskGroup].self, from: savedData) {
                taskGroups = decodeGroups
                return
            }
        }
        taskGroups = TaskGroup.sampleData
    }
    
}

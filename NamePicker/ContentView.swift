//
//  ContentView.swift
//  NamePicker
//
//  Created by Katelyn Liu on 7/14/24.
//

import SwiftUI

struct ContentView: View {
    
    @State private var names: [String] = []
    @State private var nameToAdd = ""
    @State private var pickedName = ""
    @State private var shouldRemovePickedName = false
    @State private var savedList: [String] = []
    
    var body: some View {
        VStack {
            VStack(spacing: 8) {
                Image(systemName: "person.3.sequence.fill")
                    .foregroundStyle(.tint)
                    .symbolRenderingMode(.hierarchical)
                Text("Random Name Picker")
            }
            .font(.title)
            .bold()
            // ternary conditional operator: if pickedName is empty, shows an empty line on the page. if pickedName has name, it displays the name (TRUE : FALSE)
            Text(pickedName.isEmpty ? " " : pickedName)
                .font(.title2)
                .bold()
                .foregroundStyle(.tint)
            
            List {
                ForEach(names, id: \.self) { name in
                    Text(name)
                }
            }
            .clipShape(RoundedRectangle(cornerRadius: 10))
            
            TextField("Add Name", text: $nameToAdd)
                .autocorrectionDisabled()
                .onSubmit {
                    if !nameToAdd.isEmpty && !names.contains(nameToAdd) {
                        names.append(nameToAdd)
                        nameToAdd = ""
                    }
                }
            
            Divider()
            
            Toggle("Remove when picked", isOn: $shouldRemovePickedName)
            
            Button {
                // if let allows us to work with the possibility of nil values (array is empty) - if a random name is chosen from array, it runs first block. if not, it runs the code under "else"
                if let randomName = names.randomElement() {
                    pickedName = randomName
                    
                    // if user wants to remove picked names, remove the name in names that equals the random name
                    if shouldRemovePickedName {
                        names.removeAll { name in
                            return (name == randomName)
                        }
                    }
                }
                else {
                    pickedName = ""
                }
            } label: {
                Text("Pick Random Name")
                    .padding(.vertical, 8)
                    .padding(.horizontal, 16)
            }
            .buttonStyle(.borderedProminent)
            .font(.title2)
            
            HStack {
                Button("Save List") {
                    savedList = names
                }
                Button("Load List") {
                    names = savedList
                }
            }
            
            
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

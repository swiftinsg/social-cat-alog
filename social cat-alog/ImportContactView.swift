//
//  ImportContactView.swift
//  social cat-alog
//
//  Created by Jia Chen Yee on 11/8/24.
//

import Foundation
import SwiftUI

struct ImportContactView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @Binding var allCatContacts: [CatContact]
    @Binding var newContacts: [CatContact]
    
    var body: some View {
        NavigationStack {
            Form {
                ForEach($newContacts) { $contact in
                    Section(contact.name) {
                        VStack {
                            Picker("Cat Emoji", selection: $contact.catEmoji) {
                                Text("🐱").tag("🐱")
                                Text("😺").tag("😺")
                                Text("😸").tag("😸")
                                Text("😹").tag("😹")
                                Text("😻").tag("😻")
                                Text("😼").tag("😼")
                                Text("😽").tag("😽")
                                Text("😾").tag("😾")
                                Text("😿").tag("😿")
                                Text("🙀").tag("🙀")
                            }
                        }
                    }
                }
                
                Button("Save New Contacts") {
                    dismiss()
                    withAnimation {
                        allCatContacts += newContacts
                    }
                }
            }
            .navigationTitle("Import Contacts")
        }
    }
}
#Preview {
    @Previewable @State var allCatContacts: [CatContact] = []
    @Previewable @State var newContacts: [CatContact] = []
    
    ImportContactView(allCatContacts: $allCatContacts, newContacts: $newContacts)
}

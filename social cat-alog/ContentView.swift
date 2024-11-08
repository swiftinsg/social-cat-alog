//
//  ContentView.swift
//  social cat-alog
//
//  Created by Jia Chen Yee on 11/8/24.
//

import SwiftUI
import ContactsUI

struct ContentView: View {
    
    @State private var allCatContacts: [CatContact] = []
    
    @State private var newContacts: [CatContact] = []
    
    @State private var isImportContactSheetPresented = false
    
    @State private var searchQuery = ""
    
    var filteredContacts: [CatContact] {
        if searchQuery.isEmpty {
            allCatContacts
        } else {
            allCatContacts.filter {
                $0.name.localizedCaseInsensitiveContains(searchQuery)
            }
        }
    }
    
    let columns = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        NavigationStack {
            VStack {
                ScrollView {
                    LazyVGrid(columns: columns) {
                        ForEach(filteredContacts) { contact in
                            VStack {
                                Text(contact.catEmoji)
                                    .font(.system(size: 100))
                                    .padding()
                                    .background(.regularMaterial)
                                    .clipShape(.circle)
                                Text(contact.name)
                            }
                        }
                    }
                    .padding(.horizontal)
                }
                .searchable(text: $searchQuery)
                
                ContactAccessButton(queryString: searchQuery) { identifiers in
                    
                    let keys = [CNContactFormatter.descriptorForRequiredKeys(for: .fullName)]
                    let fetchRequest = CNContactFetchRequest(keysToFetch: keys)
                    
                    fetchRequest.predicate = CNContact.predicateForContacts(withIdentifiers: identifiers)
                    
                    var contacts = [CNContact]()
                    
                    try? CNContactStore().enumerateContacts(with: fetchRequest) { contact, _ in
                        contacts.append(contact)
                    }
                    
                    self.newContacts = contacts.map { contact in
                        CatContact(id: contact.id, name: contact.givenName, catEmoji: "🐱")
                    }
                    
                    if !newContacts.isEmpty {
                        isImportContactSheetPresented = true
                    }
                }
                .padding()
            }
            .navigationTitle("Social Cat-alog")
            .sheet(isPresented: $isImportContactSheetPresented) {
                ImportContactView(allCatContacts: $allCatContacts, newContacts: $newContacts)
                    .presentationDetents([.medium])
            }
        }
    }
}

#Preview {
    ContentView()
}

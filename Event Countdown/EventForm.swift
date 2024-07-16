//
//  EventForm.swift
//  Event Countdown
//
//  Created by Saurav Verma on 02/07/24.
//

import SwiftUI

struct EventForm: View {
    @Binding var event: Event?
    @Environment(\.dismiss) private var dismiss
    var onSave: (Event) -> Void

    @State private var title: String = ""
    @State private var date: Date = Date()
    @State private var textColor: Color = .black

    var body: some View {
        Form {
            Section {
                TextField("Title", text: $title)
                    .foregroundColor(textColor)
                DatePicker("Date", selection: $date, displayedComponents: .date)
                ColorPicker("Text Color", selection: $textColor)
            }
        }
        .navigationTitle(event == nil ? "Add Event" : "Edit Event")
        .toolbar {
            ToolbarItem(placement: .confirmationAction) {
                Button("Save") {
                    // Validate title before saving
                    guard !title.isEmpty else {
                        // Show alert or handle empty title case
                        return
                    }
                    
                    let newEvent = Event(id: event?.id ?? UUID(), title: title, date: date, textColor: textColor)
                    onSave(newEvent)
                    dismiss()
                }
                .disabled(title.isEmpty) // Disable save button if title is empty
            }
        }
        .onAppear {
            if let event = event {
                title = event.title
                date = event.date
                textColor = event.textColor
            } else {
                // Reset fields if event is nil
                title = ""
                date = Date()
                textColor = .black
            }
        }
    }
}


#Preview {
    EventForm(event: Binding.constant(nil)) { _ in }
}

//
//  EventsView.swift
//  Event Countdown
//
//  Created by Saurav Verma on 02/07/24.
//

import SwiftUI

struct EventsView: View {
    @State private var events: [Event] = []
    @State private var showingEventForm = false
    @State private var selectedEvent: Event?

    var body: some View {
        NavigationStack {
            List {
                ForEach(events.sorted()) { event in
                    EventRow(event: event)
                        .onTapGesture {
                            selectedEvent = event
                            showingEventForm = true // Show form for editing
                        }
                }
                .onDelete(perform: deleteEvent)
            }
            .navigationTitle("Events")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        selectedEvent = nil // Reset selectedEvent here
                        showingEventForm = true
                    }) {
                        Image(systemName: "plus")
                    }
                }
            }
            .navigationDestination(isPresented: $showingEventForm) {
                if let selectedEvent = selectedEvent {
                    EventForm(event: Binding.constant(selectedEvent)) { updatedEvent in
                        if let index = events.firstIndex(where: { $0.id == updatedEvent.id }) {
                            events[index] = updatedEvent // Update existing event
                        }
                        showingEventForm = false
                    }
                } else {
                    EventForm(event: Binding.constant(nil)) { newEvent in
                        events.append(newEvent)
                        showingEventForm = false
                    }
                }
            }
        }
    }

    private func deleteEvent(at offsets: IndexSet) {
        events.remove(atOffsets: offsets)
    }
}


#Preview {
    EventsView()
}



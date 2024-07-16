//
//  EventRow.swift
//  Event Countdown
//
//  Created by Saurav Verma on 02/07/24.
//

import SwiftUI

struct EventRow: View {
    var event: Event
    @State private var relativeDate: String = ""

    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    var body: some View {
        VStack(alignment: .leading) {
            Text(event.title)
                .foregroundColor(event.textColor)
            Text(relativeDate)
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
        .onAppear {
            updateRelativeDate()
        }
        .onReceive(timer) { _ in
            updateRelativeDate()
        }
    }

    private func updateRelativeDate() {
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .full
        relativeDate = formatter.localizedString(for: event.date, relativeTo: Date())
    }
}

#Preview {
    EventRow(event: Event(id: UUID(), title: "Sample Event", date: Date(), textColor: .blue))
        .previewLayout(.fixed(width: 300, height: 70))
}


//
//  Event.swift
//  Event Countdown
//
//  Created by Saurav Verma on 02/07/24.
//

import Foundation
import SwiftUI

struct Event: Identifiable, Comparable {
    var id: UUID
    var title: String
    var date: Date
    var textColor: Color

    static func < (lhs: Event, rhs: Event) -> Bool {
        return lhs.date < rhs.date
    }
}



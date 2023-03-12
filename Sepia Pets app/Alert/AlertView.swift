//
//  AlertView.swift
//  Sepia Pets app
//
//  Created by vipin on 3/11/23.
//

import Foundation
import SwiftUI

enum MyError: LocalizedError {
    
    case basic
    
    var errorDescription: String? {
        switch self {
        case .basic:
            return "Working hours."
        }
    }
    
    var errorMessage: String? {
        switch self {
        case .basic:
            return "your are accessing out side working hours."
        }
    }
}

struct ErrorAlert: ViewModifier {
    
    @Binding var error: MyError?
    var isShowingError: Binding<Bool> {
        Binding {
            error != nil
        } set: { _ in
            error = nil
        }
    }
    
    func body(content: Content) -> some View {
        content
            .alert(isPresented: isShowingError, error: error) { _ in
            } message: { error in
                if let message = error.errorMessage {
                    Text(message)
                }
            }
    }
}

extension View {
    func errorAlert(_ error: Binding<MyError?>) -> some View {
        self.modifier(ErrorAlert(error: error))
    }
}


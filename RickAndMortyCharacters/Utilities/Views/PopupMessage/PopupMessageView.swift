//
//  PopupMessageView.swift
//  RickAndMortyCharacters
//
//  Created by Mostafa Alaa on 08/07/2024.
//

import SwiftUI

enum MessageType {
    case warning
    case success
    case error
}
struct PopupMessageView: View {
    @State private var isVisible: Bool = true
    let message: String
    var displayDuration: TimeInterval = 5
    var messageType: MessageType = .error

    var body: some View {
        if isVisible {
            Text(message)
                .padding()
                .background(createColor)
                .foregroundColor(.white)
                .cornerRadius(8)
                .opacity(isVisible ? 1 : 0)
                .animation(.easeInOut(duration: 1.0))
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + displayDuration) {
                        withAnimation {
                            isVisible = false
                        }
                    }
                }
        }
    }
    private var createColor: Color {
        switch messageType {
        case .warning:
            return Color(DesignSystem.Colors.CoolOrange.Color)
        case .success:
            return Color(DesignSystem.Colors.CoolGreen.Color)
        case .error:
            return Color(DesignSystem.Colors.SoftRed.Color)
        }
    }
}

#Preview {
    PopupMessageView(message: "This is an error message", displayDuration: 3)
}

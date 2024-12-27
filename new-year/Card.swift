//
//  Card.swift
//  new-year
//
//  Created by Tommy on 27.12.2024.
//

import SwiftUI

struct Card: View {
    @State private var isPressed = false

    private let wish: Wish

    init(wish: Wish) {
        self.wish = wish
    }

    var body: some View {
        VStack(spacing: 12) {
            Image(wish.imageName)
                .resizable()
                .scaledToFit()
                .frame(maxWidth: .infinity)

            Text(wish.text)
                .font(.system(size: 12, weight: .semibold))
                .multilineTextAlignment(.center)
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(Color(.secondarySystemBackground))
        .cornerRadius(24)
        .shadow(color: Color.black.opacity(0.08), radius: 8, x: 0, y: 4)
        .scaleEffect(isPressed ? 0.97 : 1.0)
        .animation(.spring(response: 0.3, dampingFraction: 0.4), value: isPressed)
        .onTapGesture {
            isPressed.toggle()
            // Reset the state after animation
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                isPressed = false
            }
        }
    }
}

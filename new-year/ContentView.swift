//
//  ContentView.swift
//  new-year
//
//  Created by Tommy on 27.12.2024.
//

import AVFoundation
import SwiftUI

struct ContentView: View {
    @State private var player: AVAudioPlayer?
    @State private var isPlaying: Bool = false

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 16) {
                    // Верхняя часть с елкой и музыкой
                    VStack(alignment: .leading) {
                        Image("Сhristmas_winter")
                            .resizable()
                            .scaledToFit()
                            .cornerRadius(16)
                            .padding(.horizontal)

                        HStack {
                            VStack(alignment: .leading, spacing: 4) {
                                Text("Подборка 2024")
                                    .font(.headline)

                                Text("Frank Sinatra — Christmas Dreaming")
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }

                            Spacer()

                            Button(action: {
                                togglePlayPause()
                            }) {
                                Image(systemName: isPlaying ? "pause.circle.fill" : "play.circle.fill")
                                    .resizable()
                                    .frame(width: 40, height: 40)
                                    .foregroundColor(.blue)
                            }
                        }
                        .padding(.horizontal)
                    }

                    // Заголовок пожеланий
                    Text("Пожелания в Новом году")
                        .font(.title2)
                        .bold()
                        .padding(.horizontal)

                    // Сетка пожеланий
                    LazyVGrid(columns: [
                        GridItem(.flexible()),
                        GridItem(.flexible())
                    ], spacing: 16) {
                        ForEach(wishes, id: \.id) { wish in
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
                            .background(Color(.systemBackground))
                            .cornerRadius(16)
                            .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 5)
                        }
                    }
                    .padding(.horizontal)
                }
                .padding(.top)
            }
            .navigationTitle("Хо-хо-хо!")
            .navigationBarTitleDisplayMode(.inline)
        }
    }

    private func togglePlayPause() {
        if let player = player, player.isPlaying {
            player.pause()
            isPlaying = false
        } else {
            playSong()
        }
    }

    private func playSong() {
        guard let url = Bundle.main.url(forResource: "ChristmasDreaming", withExtension: "mp3") else {
            print("Песня не найдена")
            return
        }

        do {
            if player == nil {
                player = try AVAudioPlayer(contentsOf: url)
            }
            player?.play()
            isPlaying = true
        } catch {
            print("Ошибка воспроизведения: \(error.localizedDescription)")
        }
    }
}

// Модель данных для пожеланий
struct Wish: Identifiable {
    let id = UUID()
    let imageName: String
    let text: String
}

// Пример данных для пожеланий
let wishes = [
    Wish(imageName: "Santa", text: "Удачного года без deprecated API!"),
    Wish(imageName: "Gloves", text: "Пусть App Store никогда не тормозит модерацию!"),
    Wish(imageName: "Socks", text: "Пусть новые фичи не ломают старые релизы!"),
    Wish(imageName: "Cookie", text: "Стабильной работы Xcode... ну хоть на праздники!")
]

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

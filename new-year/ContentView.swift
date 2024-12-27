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
    @State private var selectedTab: Int = 0

    @State private var isPressed = false

    var body: some View {
        TabView(selection: $selectedTab) {
            // Tab 1
            screen
                .tabItem {
                    Image("Home")
                        .renderingMode(.template)
                        .foregroundColor(Color(.systemGray6))
                }
                .tag(0)

            // Tab 2
            NavigationView {
                Text("Поиск").navigationTitle("Поиск")
            }
            .tabItem {
                Image("Play")
                    .renderingMode(.template)
                    .foregroundColor(Color(.systemGray6))
            }
            .tag(1)

            // Tab 3
            NavigationView {
                Text("Избранное").navigationTitle("Избранное")
            }
            .tabItem {
                Image("More Circle")
                    .renderingMode(.template)
                    .foregroundColor(Color(.systemGray6))
            }
            .tag(2)

            // Tab 4
            NavigationView {
                Text("Профиль").navigationTitle("Профиль")
            }
            .tabItem {
                Image("Chat")
                    .renderingMode(.template)
                    .foregroundColor(Color(.systemGray6))
            }
            .tag(3)
        }.tint(Color(uiColor: UIColor(red: 111 / 255, green: 117 / 255, blue: 226 / 225, alpha: 1)))
    }

    var screen: some View {
        NavigationView {
            ScrollView {
                VStack {
                    // Верхняя часть с елкой и музыкой
                    VStack(alignment: .leading) {
                        Image("Сhristmas_winter")
                            .resizable()
                            .scaledToFit()
                            .cornerRadius(16)


                        HStack {
                            VStack(alignment: .leading, spacing: 4) {
                                Text("Подборка 2024")
                                    .font(.system(size: 17, weight: .semibold))

                                Text("Frank Sinatra — Christmas Dreaming")
                                    .font(.system(size: 13, weight: .regular))
                                    .foregroundColor(.gray)
                            }

                            Spacer()

                            Button(action: {
                                togglePlayPause()
                            }) {
                                Image(systemName: isPlaying ? "pause.circle.fill" : "play.circle.fill")
                                    .resizable()
                                    .frame(width: 40, height: 40)
                                    .foregroundColor(Color(uiColor: UIColor(red: 111 / 255, green: 117 / 255, blue: 226 / 225, alpha: 1)))
                            }
                        }.padding(
                            EdgeInsets(
                                top: 8,
                                leading: 20,
                                bottom: 8,
                                trailing: 20
                            )
                        )

                    }
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(20)
                    .shadow(color: Color.black.opacity(0.08), radius: 12, x: 0, y: 4)
                    .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))

                    Spacer(minLength: 20)
                    // Заголовок пожеланий
                    HStack {
                        Text("Пожелания в Новом году")
                            .font(.system(size: 22, weight: .semibold))
                            .padding(.leading, 20)
                            .multilineTextAlignment(.center)
                        Spacer()
                    }.frame(width: UIScreen.main.bounds.width, height: 40)

                    Spacer(minLength: 12)

                    HStack(alignment: .top, spacing: 12) {
                        VStack(spacing: 12) {
                            ForEach(wishes, id: \.id) { wish in
                                Card(wish: wish)
                            }
                        }
                        VStack(spacing: 12) {
                            ForEach(wishes2, id: \.id) { wish in
                                Card(wish: wish)
                            }
                        }
                    }.padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
                }
                .padding(.top)
            }
            .navigationTitle("Хо-хо-хо!")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        // Left button action
                    }) {
                        Image("Seach")
                            .foregroundColor(.black)
                    }
                }

                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        // Right button action
                    }) {
                        Image("Notification")
                            .foregroundColor(.black)
                    }
                }
            }
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
    Wish(imageName: "Socks", text: "Пусть новые фичи не ломают старые релизы!"),
]

let wishes2 = [
    Wish(imageName: "Gloves", text: "Пусть App Store никогда не тормозит модерацию!"),
    Wish(imageName: "Cookie", text: "Стабильной работы Xcode... ну хоть на праздники!")
]

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

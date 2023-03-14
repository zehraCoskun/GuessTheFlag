//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Zehra Coşkun on 28.02.2023.
//

import SwiftUI

//struct FlagImage: View {
//
//    var countries : [String]
//    var number : Int
//    var body: some View {
//        Image(countries[number])
//            .renderingMode(.original)
//            .shadow(radius: 5)
//            .cornerRadius(20)
//    }
//}
struct LargeBlueTitle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle.weight(.bold))
            .foregroundColor(Color(red: 0.1, green: 0.2, blue: 0.45))
    }
}
extension View {
    func largeBlueTitle() -> some View{
        modifier(LargeBlueTitle())
    }
}

struct ContentView: View {
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    
    @State private var showingAlert = false
    @State private var scoreTitle = ""
    
    @State private var scoreC = 0
    @State private var scoreW = 0
    @State private var gameLevel = 0
    
    @State private var selectedFlag = -1
    
    var body: some View {
        ZStack {
            RadialGradient(stops: [
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.35),
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.4)],
                           center: .top, startRadius: 200, endRadius: 500)
            .ignoresSafeArea()
            VStack (spacing: 15 ){
                Spacer()
                VStack{
                    Text("BAYRAĞI BUL")
                        .largeBlueTitle()
                    Text("\(gameLevel) / 10")
                        .largeBlueTitle()
                }
                Spacer()
                VStack{
                    Text(countries[correctAnswer])
                        .largeBlueTitle()
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 50))
                
                VStack {
                    ForEach (0..<3) { number in
                        Button {
                            flagTapped(number)
                        } label: {
                            Image(countries[number])
                                .renderingMode(.original)
                                .shadow(radius: 5)
                                .cornerRadius(20)
                                .rotation3DEffect(.degrees(number == selectedFlag ? 360 : 0), axis: (x: 0, y: 1, z: 0))
                                .animation(.default, value: selectedFlag)
                                .opacity(selectedFlag == -1 || selectedFlag == number ? 1.0 : 0.25)
                                .scaleEffect(selectedFlag == -1 || selectedFlag == number ? 1 : 0.5)
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 50))
                .animation(.default, value: selectedFlag)
                
                
                HStack {
                    Text("Doğru Sayısı : \(scoreC)")
                        .padding(.all)
                        .foregroundColor(.white)
                        .background(Color(.systemGray))
                        .clipShape(Capsule())
                        .shadow(radius: 5)
                    Text ("Yanlış Sayısı : \(scoreW)")
                        .padding(.all)
                        .foregroundColor(.white)
                        .background(Color(.systemGray))
                        .clipShape(Capsule())
                        .shadow(radius: 5)
                }
                Text ("SCORE : \((scoreC - scoreW)*100)")
                    .padding(.all)
                    .foregroundColor(.white)
                    .background(Color(.systemGray))
                    .clipShape(Capsule())
                    .shadow(radius: 5)
            }
                        .alert(scoreTitle, isPresented: $showingAlert) {
                            Button("OK", action: askQuestion)
                        }
        }
    }
    func flagTapped (_ number: Int) {
        
        if number == correctAnswer {
            showingAlert = true
            scoreTitle = "Doğru"
            scoreC += 1
            gameLevel += 1
            selectedFlag = number
            
        } else {
            showingAlert = true
            scoreTitle = "Seçtiğin bayrak '\(countries[number])'"
            scoreW += 1
            gameLevel += 1
        }
        
    }
    func askQuestion() {
        countries.shuffle()
        
        correctAnswer = Int.random(in: 0...2)
        selectedFlag = -1
        if gameLevel >= 10 {
            showingAlert = true
            scoreTitle = "Oyun Bitti Skorunuz \((scoreC - scoreW)*100)"
            restart()
        }
    }
    

    func restart(){
        scoreW = 0
        scoreC = 0
        gameLevel = 0
        askQuestion()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

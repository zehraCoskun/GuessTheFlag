//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Zehra Coşkun on 28.02.2023.
//

import SwiftUI

struct ContentView: View {
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    
    @State private var showingScore = false
    @State private var scoreTitle = ""
    
    @State private var scoreC = 0
    @State private var scoreW = 0
    
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
                        .font(.largeTitle.weight(.bold))
                        .foregroundColor(Color(red: 0.1, green: 0.2, blue: 0.45))
                }
                Spacer()
                VStack{
                    Text(countries[correctAnswer])
                        .font(.largeTitle.weight(.bold))
                        .foregroundColor(Color(red: 0.1, green: 0.2, blue: 0.45))
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 50))
                
                VStack {
                    ForEach (0..<3) { number in
                        Button {
                            flagTapped(number)
                            askQuestion()
                        } label: {
                            Image(countries[number])
                                .renderingMode(.original)
                                .shadow(radius: 5)
                                .cornerRadius(20)
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 50))
                
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
                Text ("SCORE : \(scoreC - scoreW)")
                    .padding(.all)
                    .foregroundColor(.white)
                    .background(Color(.systemGray))
                    .clipShape(Capsule())
                    .shadow(radius: 5)
            }
            
            //            .alert(scoreTitle, isPresented: $showingScore) {
            //                Button("Continue", action: askQuestion)
            //            } message: {
            //                Text ("Your score is \(scoreC - scoreW)")
            //            }
        }
    }
    func flagTapped (_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct"
            scoreC += 1
        } else {
            scoreTitle = "Wrong"
            scoreW += 1
        }
        showingScore = true
    }
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

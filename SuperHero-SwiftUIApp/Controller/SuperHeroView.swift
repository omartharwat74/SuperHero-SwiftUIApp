//
//  SuperHeroView.swift
//  SuperHero-SwiftUIApp
//
//  Created by Omar Tharwat on 08/05/2023.
//

import SwiftUI

struct SuperHeroView: View {
    
   // var gradiant : [Color] = [Color("Colorhulk01"),Color("Colorhulk02")]
    
    @State var isAlertPresented : Bool = false
    @State var isScaling : Bool = false
    @State var isSliding : Bool = false
    
    var hapticImpact  = UIImpactFeedbackGenerator(style: .heavy)
    
    var superH : Superhero
    
    var body: some View {
        ZStack{
            Image(superH.image)
                .resizable()
                .scaledToFill()
                .scaleEffect(isScaling ? 1 : 0.7 )
                .animation(.easeOut(duration: 0.8), value: isScaling)
            
            VStack{
                Text(superH.title)
                    .font(.largeTitle)
                    .fontWeight(.heavy)
                    .foregroundColor(.white)
                
                Button{
                    isAlertPresented.toggle()
                    hapticImpact.impactOccurred()
                    playSound(sound: "chimeup", type: "mp3")
                }label: {
                    HStack{
                        Text("Start")
                        Image(systemName: "arrow.right.circle")
                    }// HStack
                    .padding()
                    .background(LinearGradient(gradient: Gradient(colors: superH.gradientColors), startPoint: .bottomTrailing, endPoint: .topLeading))
                    .font(.title2)
                    .foregroundColor(.white)
                    .clipShape(Capsule())
                    .shadow(radius: 10)
                    .alert(isPresented: $isAlertPresented) {
                        Alert(title: Text("More About \(superH.title)"),message: Text(superH.message),dismissButton: .default(Text("OK")))
                    }
                }
                
            }// :VStack
            .offset(y: isSliding ? 150 : 300)
            .animation(.easeOut(duration: 3), value: isSliding)
            
        }// :ZStack
        .frame(width: 335,height: 545,alignment: .center)
        .background(LinearGradient(gradient: Gradient(colors: superH.gradientColors), startPoint: .topLeading, endPoint: .bottomTrailing))
        .cornerRadius(16)
        .shadow(color: .black, radius: 2,x: 2,y: 2)
        .onAppear  {
            isScaling = true
            isSliding = true
        }
    }
}

struct SuperHeroView_Previews: PreviewProvider {
    static var previews: some View {
        SuperHeroView(superH: superherosData[1])
    }
}

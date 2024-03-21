//
//  SplashScreenView.swift
//  PomoApp
//
//  Created by Berke Ceylan on 6.08.2023.
//


    import SwiftUI

struct SplashScreenView: View {
    @State private var isActive = false
    @State private var size = 0.8
    @State private var opacity = 0.5
    
    var body: some View {
        if isActive{
            ContentView()
        }
        else{
            ZStack{
                Color("green").edgesIgnoringSafeArea(.all)
                VStack{
                    VStack(alignment: .center){
                        Spacer()
                        Image("owl2")
                            .resizable()
                            .frame(width: 300, height: 300)
                            .opacity(0.80)
                           
                        Text("FUKURO")
                            .font(.system(size: 80, weight:.medium, design: .rounded))
                            .foregroundColor(.black.opacity(0.80))
                        Spacer()
                        Text("Endless Flow: Where Sessions and Breaks Unite.")
                            .font(.system(size: 20, weight:.medium, design: .rounded))
                            .foregroundColor(.black.opacity(0.80))
                            .multilineTextAlignment(.center)
                    }
                    .scaleEffect(size)
                    .opacity(opacity)
                    .onAppear{
                        withAnimation(.easeIn(duration: 1.2)){
                            self.size = 0.9
                            self.opacity = 1.0
                        }
                    }
                }
                .onAppear{
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3.0){
                        withAnimation{
                            print("Switching to ContentView")
                            self.isActive = true
                        }
                    }
                }
            }
        }
    }
}

struct SplashScreenView_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreenView()
    }
}

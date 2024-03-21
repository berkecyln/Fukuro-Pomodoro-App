//
//  ContentView.swift
//  PomoApp
//
//  Created by Berke Ceylan on 26.07.2023.
//

import SwiftUI
import UIKit

struct ContentView: View {
    @State var originalSessionTime = 0
    @State var originalBreakTime = 0
    @State var sessionInMinutes = 25 * 60
    @State var breakInMinutes = 5 * 60
    @State var sessionTime: Double = 25
    @State var breakTime: Double = 5
    @State var sessionAmount = 4
    @State var isSession = false
    @State var isBreak = false
    @State var isPaused = false
    
    @State private var sessionEndAt: Date?
    @State private var breakEndAt: Date?
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var sessionMinutes: Int {
        return sessionInMinutes / 60
    }
    
    var sessionSeconds: Int {
        return sessionInMinutes % 60
    }
    
    var breakMinutes: Int {
        return breakInMinutes / 60
    }
    
    var breakSeconds: Int {
        return breakInMinutes % 60
    }
    
    var body: some View {
        ZStack{
            Color("green").edgesIgnoringSafeArea(.all)
            VStack{
                HStack{
                    Spacer().frame(width: 190)
                    Image("owl3")
                        .resizable()
                        .frame(width: 125, height: 125)
                        .opacity(0.80)
                    
                }
                Spacer().frame(height: 610)
            }
           
            
            VStack(alignment: .center) {
                HStack(){
                    //Text("Focus like a Fukuro, undisturbed by the chaos.")
                    Text("Fukuro")
                        .multilineTextAlignment(.leading)
                        .foregroundColor(.black)
                        .opacity(0.80)
                        .font(.system(size: 50, weight:.medium, design: .rounded))
                        .padding()
                    Spacer().frame(width: 150)
                }
               
                    
                
                VStack(alignment: .center) {
                    Text("Session Time")
                        .font(.system(size: 20, weight:.bold, design: .rounded))
                        .foregroundColor(.black)
                    Text("\(isBreak ? String(format: "%02d:00", originalSessionTime) : String(format: "%02d:%02d", sessionMinutes, sessionSeconds))")
                        .font(.system(size: 80, weight: .bold, design: .rounded))
                        .foregroundColor(.black)
                        .opacity(0.80)
                }
                .padding()
                .frame(width: 330)
                .background(Color("thinGreen"))
                .cornerRadius(20)
                .overlay(RoundedRectangle(cornerRadius: 20).stroke(Color("borderColor"), lineWidth: 5))
                .padding()
                
                HStack{
                    VStack(alignment: .center) {
                        Text("Break Time")
                            .font(.system(size: 20, weight:.bold, design: .rounded))
                            .foregroundColor(.black)
                        Text("\(isSession ? String(format: "%02d:00", originalBreakTime) : String(format: "%02d:%02d", breakMinutes, breakSeconds))")
                            .font(.system(size: 40, weight: .bold, design: .rounded))
                            .foregroundColor(.black)
                            .opacity(0.80)
                    }
                    .padding()
                    .frame(width: 150)
                    .background(Color("thinGreen"))
                    .cornerRadius(20)
                    .overlay(RoundedRectangle(cornerRadius: 20).stroke(Color("borderColor"), lineWidth: 5))
                    
                    Spacer().frame(width: 30)
                    
                    VStack(alignment: .center){
                        Text("Sessions")
                            .font(.system(size: 20, weight:.bold, design: .rounded))
                            .foregroundColor(.black)
                        Text("x\(sessionAmount)")
                            .font(.system(size: 40, weight: .bold, design: .rounded))
                            .opacity(0.80)
                            .foregroundColor(.black)
                    }
                    .padding()
                    .frame(width: 150)
                    .background(Color("thinGreen"))
                    .cornerRadius(20)
                    .overlay(RoundedRectangle(cornerRadius: 20).stroke(Color("borderColor"), lineWidth: 5))
                }
                
                VStack(alignment: .center){
                    
                    // Slider for setting the session time
                    VStack {
                        Text("Set Session Time")
                            .font(.system(size: 20, weight:.medium, design: .rounded))
                            .foregroundColor(.black)
                        Slider(value: $sessionTime, in: 1...60, step: 1)
                            .disabled(isSession || isBreak)
                            .accentColor(Color("orange"))
                            .onChange(of: sessionTime) { sessionValue in
                                sessionInMinutes = Int(sessionValue) * 60
                            }
                        
                    }
                    .padding()
                    .frame(width: 300)
                    
                    // Slider for setting the break time
                    VStack {
                        Text("Set Break Time")
                            .font(.system(size: 20, weight:.medium, design: .rounded))
                            .foregroundColor(.black)
                        Slider(value: $breakTime, in: 1...60, step: 1)
                            .disabled(isSession || isBreak)
                            .accentColor(Color("orange"))
                            .onChange(of: breakTime) { breakValue in
                                breakInMinutes = Int(breakValue) * 60
                            }
                        
                    }
                    .padding()
                    .frame(width: 300)
                    
                    // Stepper for setting the amount of session
                    Stepper(value: $sessionAmount, in: 1...60, step: 1) {
                        Text("Session Amount")
                            .fontWeight(.medium)
                            .fontDesign(.rounded)
                            .foregroundColor(.black)
                    }
                    .disabled(isSession || isBreak)
                    .frame(width: 250)
                    .padding()
                }
                .padding()
                
                HStack(spacing: 30) {
                    if isPaused == false && (isSession == false && isBreak == false){
                        Button("Start") {
                            isPaused = false
                            isSession = true
                            originalBreakTime = Int(breakTime)
                            originalSessionTime = Int(sessionTime)
                            sessionEndAt = Date().addingTimeInterval(TimeInterval(sessionInMinutes))
                        }
                        .foregroundColor(Color("blue2"))
                        .font(.system(size: 30, weight:.bold, design: .rounded))
                    }
                    else if (isSession == true || isBreak == true) && isPaused == false{
                        Button(action:{ isPaused = true}){Text("Pause")}
                            .foregroundColor(Color("blue2"))
                            .font(.system(size: 30, weight:.bold, design: .rounded))
                    }
                    else if isPaused == true && (isSession == true || isBreak == true ){
                        Button(action:{isPaused = false}){Text("Resume")}
                            .foregroundColor(Color("blue2"))
                            .font(.system(size: 30, weight:.bold, design: .rounded))
                    }
                    
                    Button("Reset") {
                        if isSession == true || isBreak == true{
                            sessionInMinutes = Int(sessionTime) * 60
                            breakInMinutes = Int(breakTime) * 60
                            isPaused = false
                            isSession = false
                            isBreak = false
                        }
                        else{
                            sessionTime = 25
                            breakTime = 5
                            sessionAmount = 4
                        }
                    }
                    .foregroundColor(Color("red"))
                    .font(.system(size: 30, weight: .bold, design: .rounded))
                }
            }
            .onReceive(timer) { _ in
                if isPaused == false && sessionAmount != 0{
                    if isSession {
                        if let sessionEndAt = self.sessionEndAt {
                            let remainingTime = sessionEndAt.timeIntervalSince(Date())
                            if remainingTime > 0 {
                                sessionInMinutes = Int(remainingTime)
                            }
                            else {
                                isSession = false
                                isBreak = true
                                breakInMinutes = Int(breakTime) * 60
                                breakEndAt = Date().addingTimeInterval(TimeInterval(breakInMinutes))
                                NotificationManager.shared.sendNotification(title: "Session Ended", body: " Time for a break!", delay: 1)
                                sessionAmount -= 1
                            }
                        }
                    }
                    else if isBreak {
                        if let breakEndAt = self.breakEndAt {
                            let remainingTime = breakEndAt.timeIntervalSince(Date())
                            if remainingTime > 0 {
                                breakInMinutes = Int(remainingTime)
                            }
                            else {
                                isSession = true
                                isBreak = false
                                if sessionAmount > 0 {
                                    sessionInMinutes = Int(sessionTime) * 60
                                    sessionEndAt = Date().addingTimeInterval(TimeInterval(sessionInMinutes))
                                }
                                NotificationManager.shared.sendNotification(title: "Break Ended", body: "Time to get back to work!", delay: 1)
                            }
                        }
                    }
                }
            }
            .onAppear {
                NotificationManager.shared.requestNotificationPermisson()
                UNUserNotificationCenter.current().delegate = NotificationManager.shared.notificationDelegate
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


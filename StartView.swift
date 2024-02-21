//
//  StartView.swift
//  GrannysRecipebook
//
//  Created by Raissa Parente on 11/02/24.
//

import SwiftUI

struct StartView: View {
    
    @Binding var viewCount: Int

    @State var textStepCount = 1
    @State var font: Font?
    @State var animate = false
    
    var body: some View {
        GeometryReader { proxy in
            
            ZStack {
                //fundo
                Image("ladrilho")
                    .resizable()
                    .frame(minWidth: proxy.size.width)
                    .ignoresSafeArea()
                
                VStack {
                    
                    ZStack {
                        Image("description")
                            .resizable()
                            .scaledToFit()
                            .frame(width: proxy.size.width * 0.7)
                            
                        
                        Text(textContent)
                            .foregroundStyle(Color(.fontcolor))
                            .font(.system(size: textStepCount == 1 ? proxy.size.width * 0.11 : proxy.size.width * 0.048, design: .rounded))
                            .multilineTextAlignment(.center)
                            .frame(width: proxy.size.width * 0.58, height: proxy.size.height * 0.32)
                            .offset(y: proxy.size.height * 0.1)
                            .animation(.easeInOut(duration: 0.4), value: textStepCount)
                           
                    }
                    
                    Button {
                        textStepCount += 1
                        
                        if textStepCount == 6 {
                            viewCount = 2
                        }
                    } label: {
                        ZStack {
                            Image("startbutton")
                                .resizable()
                                .scaledToFit()
                                .frame(width: proxy.size.width * 0.28)
                                .scaleEffect(animate ? 1 : 1.04)
                                .animation(.easeInOut(duration: 0.5).repeatForever(autoreverses: true), value: animate)
                                .onAppear {
                                    animate = true
                                }
                            
                            Text(textStepCount < 5 ? "next" : "start")
                                .foregroundStyle(Color(.fontcolor))
                                .font(.system(size: proxy.size.width * 0.045, design: .rounded))
                        }
                        .padding(25)

                        
                
                    }
               }
                .position(x: proxy.size.width * 0.5, y: proxy.size.height * 0.5)
            }
        }
    }
    
    var textContent: String {
        if textStepCount == 1 {
           return "Granny's Recipebook"
        } else if textStepCount == 2 {
            return "Welcome to Granny’s Recipebook! Right in the heart of Northeastern Brazil, you find yourself in Granny’s warm cozy kitchen."
        } else if textStepCount == 3 {
            return "You have always been intimidated by the bold flavors of regional dishes, but Granny's seasoned hands are ready to guide you in this adventure!"
        } else if textStepCount == 4 {
            return "Follow Granny's instructions as she helps you make vatapá, a delicious stew-like dish starring Northeastern Brazil’s most vibrant ingredient: dendê oil."
        } else if textStepCount >= 5 {
            return "Are you ready to reconnect with your roots and embark on this culinary journey? Let's go!"
        } else {
            return "Unknown Option"
        }
    }
}

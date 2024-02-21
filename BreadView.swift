//
//  BreadView.swift
//  GrannysRecipebook
//
//  Created by Raissa Parente on 05/02/24.
//

import SwiftUI
import AVKit

struct EffectlessButtonStyle: ButtonStyle {
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
    }
    
}

struct BreadView: View {
    
    @Binding var viewCount: Int
    @State var textStepCount = 1
    @State var breadCounter: Double = 0
    @State var animate = false
    
    var backgroundPicture: String {
        if textStepCount < 4 {
            return "breadbackdrop1"
        } else {
            return "breadbackdrop2"
        }
    }
    
    
    var body: some View {
        
        GeometryReader { proxy in
            ZStack {
                
                Image(backgroundPicture)
                    .resizable()
                    .frame(minWidth: proxy.size.width)
                    .ignoresSafeArea()
                    .transition(.opacity)
                    .onAppear()
                    .animation(.easeInOut(duration: 0.6), value: textStepCount)

                if breadCounter > 0 {
                    ProgressView(value: breadCounter, total: 6.0)
                        .tint(.pink)
                        .scaleEffect(x: 1, y: 2, anchor: .center)
                        .frame(width: proxy.size.width * 0.7)
                        .position(x: proxy.size.width * 0.5, y: proxy.size.height * 0.75)
                }
                Spacer()
                //MARK: MILK
                Button {
                    if textStepCount >= 3 && breadCounter < 7 {
                        breadCounter += 1
                        SoundManager.playerInstance.playSound(sound: .milk)
                        if breadCounter == 6 {
                            textStepCount += 1
                        }
                    }
                } label: {
                    if textStepCount > 3{
                        Image(milkImage)
                            .resizable()
                            .scaledToFit()
                            .frame(width: proxy.size.width * 0.33)
                            .position(x: proxy.size.width * 0.590, y: proxy.size.height * 0.6370)
                    }
                }
                .buttonStyle(EffectlessButtonStyle())
                
                
                //MARK: GRANNY
                ZStack {
                    Image("granny")
                        .resizable()
                        .scaledToFit()
                        .padding(40)

                        Text(textContent)
                        .foregroundStyle(Color(.fontcolor))
                        .font(.system(size: proxy.size.width * 0.03, weight: .medium, design: .rounded))
                        .frame(width: proxy.size.width * 0.58, height: proxy.size.height * 0.11)
                        .offset(x: proxy.size.width * 0.12)
                        .animation(.easeInOut(duration: 0.4), value: textStepCount)
              
                    Button {
                        textStepCount += 1

                        if textStepCount == 6 {
                            viewCount = 3
                        }
                    } label: {
                        if (textStepCount != 4) {
                            Image("nextbutton")
                                .resizable()
                                .scaledToFit()
                                .frame(width: proxy.size.width * 0.075)
                                .scaleEffect(animate ? 1 : 1.05)
                                .animation(.easeInOut(duration: 0.5).repeatForever(autoreverses: true), value: animate)
                                .onAppear {
                                    animate = true
                                }
                        }
                    }
                    .offset(x: proxy.size.width * 0.43, y: proxy.size.height * 0.05)
                }
                    .frame(width: proxy.size.width * 0.99)
                    .position(x: proxy.size.width * 0.5, y: proxy.size.height * 0.88)
                
            }
        }
    }
    
    var textContent: String {
            if textStepCount == 1 {
                return "Hey sweetie, I heard you want to make vatapá! Did you know my own children used to be scared of vatapá?"
            } else if textStepCount == 2 {
                return "It turns out they absolutely love it. Come with me and I'll show you how to make it."
            } else if textStepCount == 3 {
                return "The first step might look strange, but soaking the bread in milk will make a thickener for the mixture. "
            } else if textStepCount == 4 {
                return "Just tap on the bread bowl until the bread is all covered in milk."
            } else {
                return "Very good! Now let it soak overnight and we'll jump to next step."
            }
        }
    
    var milkImage: String {
        switch breadCounter {
        case 1:
            return "leite1"
        case 2:
            return "leite2"
        case 3:
            return "leite3"
        case 4:
            return "leite4"
        case 5:
            return "leite5"
        case 6:
            return "leite6"
        default:
            return ""
        }
        
    }
}
    


//#Preview {
//    BreadView(viewCount: 2)
//}


//
//  BreadView.swift
//  GrannysRecipebook
//
//  Created by Raissa Parente on 05/02/24.
//

import SwiftUI
import AVKit

struct BlenderView: View {
    @Binding var viewCount: Int
  
    @State var blenderIngredient = [Ingredient(name: "Pepper", picture: "pepper", isCorrect: true),
                                    Ingredient(name: "Wood", picture: "woodchips", isCorrect: false),
                                    Ingredient(name: "Cilantro", picture:                                         "cilantro", isCorrect: true),
                                    Ingredient(name: "Tomato", picture: "tomato", isCorrect: true),
                                    Ingredient(name: "Glue", picture: "glue", isCorrect: false),
                                    Ingredient(name: "Soap", picture: "soap", isCorrect: false),
                                    Ingredient(name: "Onion", picture: "onion", isCorrect: true),
                                    Ingredient(name: "Bread", picture: "bread", isCorrect: true)

    ]
    
    
    @State var blenderCount: Int = 0
    @State var textStepCount: Int = 1
    @State var isShaking = false
    @State var animate = false
    @State var clickedWrongIndredient: String = ""
    
    
    @State var blenderIsAnimating = false
    
    let columns = [
        GridItem(.adaptive(minimum: 140))
    ]
    
    
    var body: some View {
        
        GeometryReader { proxy in
            
            ZStack {
                
                Image("blenderbackdrop")
                    .resizable()
                    .frame(height: proxy.size.height * 1.1)
                    .ignoresSafeArea()
                    .transition(.opacity)
                
                //MARK: BLENDER
                VStack {
                    Image(blenderImage)
                        .resizable()
                        .scaledToFit()
                        .frame(width: proxy.size.width * 0.43)
                        .rotationEffect(blenderIsAnimating ? .degrees(isShaking ? 2 : -2) : .zero)
                        .animation(.spring.repeatCount(10).speed(8), value: isShaking)
  
                }
                .offset(x: -proxy.size.width * 0.15, y: -19)
                
                //MARK: INGREDIENTS
                VStack {
                    LazyVGrid(columns: columns) {
                        ForEach(blenderIngredient.indices, id: \.self) { index in
                            Button {
                                if (textStepCount >= 2) {
                                    //correto e nao foi clicado
                                    if (blenderIngredient[index].isCorrect && !blenderIngredient[index].isClicked && textStepCount == 2) {
                                        blenderCount += 1
                                        blenderIngredient[index].isClicked = true
                                        //correto nao é ultimo
                                        if (blenderCount) < 5 {
                                            SoundManager.playerInstance.playSound(sound: .correctIngredient)
                                            //correto e ultimo
                                        } else {
                                            SoundManager.playerInstance.playSound(sound: .blender)
                                            blenderIsAnimating = true
                                            isShaking = true
                                        }
                                        //errado
                                    } else if (!blenderIngredient[index].isCorrect) {
                                        SoundManager.playerInstance.playSound(sound: .wrongIngredient)
                                        clickedWrongIndredient = blenderIngredient[index].name
                                        blenderIngredient[index].isClicked = true
                                    }
                                    //ultimo ingrediente libera o botao next
                                }
                                if (blenderCount >= 5) {
                                    textStepCount += 1
                                }
                                
                            } label: {
                                ZStack {
                                    
                                    Image("doily")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: proxy.size.width * 0.15)
                                    
                                    Image(blenderIngredient[index].picture)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: proxy.size.width * 0.1)
                                    
                                    
                                    Text(blenderIngredient[index].name)
                                        .foregroundStyle(Color(.fontcolor).opacity(0.9))
                                        .offset(y: proxy.size.height * 0.03)
                                }
                                .overlay {
                                    if blenderIngredient[index].isClicked && blenderIngredient[index].isCorrect {
                                        RoundedRectangle(cornerRadius: 12, style: .circular)
                                            .fill(Color(.clickedcolor).opacity(0.2))
                                            .padding(14)
                                    } else if blenderIngredient[index].isClicked && !blenderIngredient[index].isCorrect {
                                        RoundedRectangle(cornerRadius: 12, style: .circular)
                                            .fill(Color(.wrongcolor).opacity(0.3))
                                            .padding(14)
                                    }
                                    
                                }
                                .padding(.top)
                            }
                        }
                    }
                }
                .padding()
                .frame(width: 400, height: 300)
                .offset(x: proxy.size.width * 0.25, y: -proxy.size.height * 0.18)
                                
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
                        if textStepCount == 4 {
                            viewCount = 4
                        }
                    } label: {
                        if textStepCount != 2 {
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
                return "We're halfway there! This is where we use the soaked bread to make and season the base paste."
            }
        
            if textStepCount == 2 {
                if clickedWrongIndredient == "" {
                    return "Now, you must click on the correct ingredients for the paste. When you have them all the blender will start."
                }
                
                if clickedWrongIndredient == blenderIngredient[1].name {
                        return "Golly, woodchips in a vatapá? I'm afraid the texture will come out a bit funny. Why don't you try the bread instead?"
                    }
                
                if clickedWrongIndredient == blenderIngredient[4].name {
                        return "Hmm, I think glue will make the paste a bit too sticky. Try another ingredient."
                    }
                
                if clickedWrongIndredient == blenderIngredient[5].name {
                        return "I know soap smells nice, but it doesn't taste too good. Maybe try an onion for fragance instead."
                    }
            }
        
            if textStepCount == 3 {
                return "Well done, my dear! With the paste done we'll adjust the salt and proceed to the final step!"
            } else {
                return "Well done, my dear! With the paste done we'll adjust the salt and proceed to the final step!"
            }
        }
    
    var blenderImage: String {
        switch blenderCount {
        case 0:
            return "blender"
        case 1:
            return "blender2"
        case 2:
            return "blender3"
        case 3:
            return "blender4"
        case 4:
            return "blender5"
        case 5:
            return "blender6"
        default:
            return "blender7"
        }
    }
}

#Preview {
    @State var number = 3
    return BlenderView(viewCount: $number)
}

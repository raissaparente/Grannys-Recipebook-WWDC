//
//  PanView.swift
//  GrannysRecipebook
//
//  Created by Raissa Parente on 06/02/24.
//

import SwiftUI

struct PanView: View {
    
    @State var panIngredients : [Ingredient] = [
        Ingredient(name: "Paste", picture: "paste", isCorrect: false, isClicked: false),
        Ingredient(name: "Chicken", picture: "chicken", isCorrect: false, isClicked: false),
        Ingredient(name: "Dendê", picture: "dende", isCorrect: false, isClicked: false),


    ]
    
    @Binding var viewCount: Int
    @State var textStepCount = 1
    @State private var currentIndex = 0  
    @State private var isRotating = 0

    
    var body: some View {
        GeometryReader { proxy in
            
            ZStack {
                Image("panbackdrop")
                    .resizable()
//                    .frame(height: proxy.size.height * 1.1)
                    .ignoresSafeArea()
                
                HStack {
                    ForEach(panIngredients.indices, id: \.self) { index in
                        Button {
                            if !panIngredients.prefix(index).allSatisfy({ $0.isClicked }) {
                                return
                            }
                            panIngredients[index].isClicked = true
                            currentIndex += 1
                            textStepCount += 1
                            
                        } label: {
                            Image(panIngredients[index].picture)
                                .resizable()
                                .scaledToFit()
                                .frame(height: 200)
                                .opacity(textStepCount < 3 ? 0.5 : (currentIndex == index ? 1 : 0.5))
                                .padding(proxy.size.width * 0.05)
                                .overlay {
                                    if currentIndex == index && textStepCount > 2 {
                                        Image("atention")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: proxy.size.width * 0.5)

                                    }
                                }
                        }
                        .offset(y: -proxy.size.height * 0.40)

                    }
                }
                
                Image(panContent)
                    .resizable()
                    .scaledToFit()
                    .frame(width: proxy.size.width * 0.36)
                    .rotationEffect(.degrees(Double(isRotating)))
                    .position(x: proxy.size.width * 0.53, y: proxy.size.height * 0.46)
                    .animation(.easeInOut(duration: 0.6), value: textStepCount)

                //MARK: SPEECH BUBBLE
                ZStack {
                    if textStepCount < 7 {
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
                        
                    } else {
                        Image("dendescreen")
                            .resizable()
                            .frame(width: proxy.size.width * 0.95, height: proxy.size.height * 0.28)
                            .offset(y: -proxy.size.height * 0.05)
                            .padding()
                        
                        HStack {
                            Image(dendeImage)
                                .resizable()
                                .scaledToFit()
                                .frame(height: proxy.size.height * 0.25)
                                .animation(.easeInOut(duration: 0.6), value: textStepCount)
                            
                            Text(textContent)
                                .foregroundStyle(Color(.fontcolor))
                                .font(.system(size: proxy.size.width * 0.04, design: .rounded))
                                .frame(width: proxy.size.width * 0.58, height: proxy.size.height * 0.21)
                                .animation(.easeInOut(duration: 0.6), value: textStepCount)
                                
                        }
                        .offset(y: -proxy.size.height * 0.05)
                    }
                    
                    
                    
                    Button {
                        textStepCount += 1
                        if textStepCount == 7 {
                            startAnimation()
                        } else if textStepCount == 10 {
                            viewCount = 5
                        }
                    } label: {
                        if  textStepCount < 3 || textStepCount > 5 {
                            Image("nextbutton")
                                .resizable()
                                .scaledToFit()
                                .frame(width: proxy.size.width * 0.075)
 
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
           return "Almost done! Now, we can have many flavors of vatapá, but today we'll go with chicken."
        } else if textStepCount == 2 {
            return "On a pan we'll mix out base paste with shredded chicken and our secret ingredient: dendê oil!"
        } else if textStepCount == 3 {
            return "First click on the blender to add the seasoned bread paste to the pan."
        } else if textStepCount == 4 {
            return "Very good, now to the same to the shredded chicken. You can make your own or use store bought."
        } else if textStepCount == 5 {
            return "Finally add as much dendê oil and you think necessary, this is what will give our vatapá its distinct taste."
        } else if textStepCount == 6 {
            return "While you stir the mixture let me tell you a little bit about the dendê you just added."
        } else if textStepCount == 7 {
            return "Dendê oil comes from the dendezeiro tree (Elaeis guineensis). Its seeds are believed to have been brought from Africa to Brazil during the slave trade."
        }  else if textStepCount == 8 {
            return "Despite many hardships, the enslaved people brought their own culture and religion, which resisted and adapted throughout the years."
        } else if textStepCount == 9 {
            return "Because of this, dendê oil is not only used in popular dishes like vatapá and acarajé, but also in offerings to orixás, the deities of iorubá religion."
        } else {
            return "Unknown Option"
        }
    }
    
    var panContent: String {
        switch currentIndex {
        case 1:
            return "mix1"
        case 2:
            return "mix2"
        case 3:
            return "mix3"
        default:
            return ""
        }
    }
    
    var dendeImage: String {
        if textStepCount == 7 {
            return "dende1"
        } else if textStepCount == 8 {
            return "dende2"
        } else if textStepCount == 9 {
            return "dende3"
        } else {
            return ""
        }
    }
    
    func startAnimation() {
        withAnimation(.linear(duration: 1)
            .speed(0.08).repeatForever(autoreverses: false)) {
                isRotating = 360
            }
    }
}

#Preview {
    @State var number = 3
    return PanView(viewCount: $number)
}

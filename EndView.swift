//
//  EndView.swift
//  Granny's Kitchen Adventure
//
//  Created by Raissa Parente on 19/02/24.
//

import SwiftUI

struct EndView: View {
    
    @State var textStepCount = 1
    
    var body: some View {
        GeometryReader { proxy in
            
            ZStack {
                Image("endscene")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
                
                //MARK: SPEECH BUBBLE
                ZStack {

                    Image("dendescreen")
                        .resizable()
                        .frame(width: proxy.size.width * 0.75, height: proxy.size.height * 0.25)
                        .offset(y: -proxy.size.height * 0.05)
                        .padding()
                    

                            
                    Text(textContent)
                        .foregroundStyle(Color(.fontcolor))
                        .font(.system(size: proxy.size.width * 0.045, design: .rounded))
                        .frame(width: proxy.size.width * 0.58, height: proxy.size.height * 0.21)
                        .animation(.easeInOut(duration: 0.6), value: textStepCount)
                        .offset(y: -proxy.size.height * 0.05)
                    
                    
                
                    Button {
                        textStepCount += 1

                    } label: {
                        if  textStepCount < 3 {
                            Image("nextbutton")
                                .resizable()
                                .scaledToFit()
                                .frame(width: proxy.size.width * 0.09)
 
                        }
                    }
                    .offset(x: proxy.size.width * 0.35, y: proxy.size.height * 0.05)
                }
                .frame(width: proxy.size.width * 0.99)
                .position(x: proxy.size.width * 0.5, y: proxy.size.height * 0.88)
                
            }
 
        }
    }
    
    var textContent: String {
        switch textStepCount {
        case 1:
            return "Well done, child! You've successfully made vatapá! That wasn't so hard, was it?"
        case 2:
            return "I hope you've seen that regional cuisine is delicious and achievable and learned a thing or two."
        case 3:
            return "Until next time!"
        default:
            return ""

        }
    }
}

#Preview {
    EndView()
}

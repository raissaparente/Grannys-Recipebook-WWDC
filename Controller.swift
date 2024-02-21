
//
//  Controller.swift
//  GrannysRecipebook
//
//  Created by Raissa Parente on 12/02/24.
//

import Foundation
import SwiftUI

public struct Controller: View {
    @State var viewCount = 1
   
    public var body: some View {
        ZStack {
            switch viewCount {
            case 1:
                StartView(viewCount: $viewCount)
                    .transition(.opacity)
            case 2:
                BreadView(viewCount: $viewCount)
                    .transition(.opacity)
            case 3:
                BlenderView(viewCount: $viewCount)
                    .transition(.opacity)
            case 4:
                PanView(viewCount: $viewCount)
                    .transition(.opacity)
            case 5:
                EndView()
                    .transition(.opacity)
            default:
                Color.white
            }                
        }
        .animation(.easeIn(duration: 1), value: viewCount)
    }
}

//
//  PlusMenu.swift
//  CustomTabBar
//
//  Created by brown on 2021/08/22.
//

import SwiftUI

struct PlusMenu: View {
    let widthAndHeight: CGFloat

    var body: some View {
        HStack(spacing: 50) {
            ZStack {
                Circle()
                    .fill(Color("DarkPurple"))
                    .frame(width: widthAndHeight, height: widthAndHeight)
                                
                Image(systemName: "record.circle")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding(15)
                    .frame(width: widthAndHeight, height: widthAndHeight)
                    .foregroundColor(.white)
            }
            
            ZStack {
                Circle()
                    .fill(Color("DarkPurple"))
                    .frame(width: widthAndHeight, height: widthAndHeight)
                
                Image(systemName: "folder")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding(15)
                    .frame(width: widthAndHeight, height: widthAndHeight)
                    .foregroundColor(.white)
            }
        }
    }
}

struct PlusMenu_Previews: PreviewProvider {
    static var previews: some View {
        PlusMenu(widthAndHeight: 50)
            .previewLayout(.sizeThatFits)
    }
}

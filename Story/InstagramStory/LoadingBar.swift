//
//  LoadingBar.swift
//  Instagram_Stories
//
//  Created by Erim Şengezer on 11.08.2022.
//

import SwiftUI

struct LoadingBar: View {
    
    var progress: CGFloat
    
    var body: some View {
        GeometryReader{ geometry in
            ZStack(alignment: .leading) {
                Rectangle()
                    .foregroundColor(Color.white.opacity(0.5))
                    .cornerRadius(5)
                Rectangle()
                    .frame(width:  geometry.size.width * self.progress, height: nil, alignment: .leading)
                    .foregroundColor(.white)
                    .cornerRadius(5)
            }
        }
    }
}

struct LoadingBar_Previews: PreviewProvider {
    static var previews: some View {
        LoadingBar(progress: 0.1)
    }
}

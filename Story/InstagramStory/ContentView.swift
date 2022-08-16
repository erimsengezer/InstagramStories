//
//  ContentView.swift
//  Instagram_Stories
//
//  Created by Erim Şengezer on 11.08.2022.
//

import SwiftUI

struct ContentView: View {
    var dismiss: (() -> Void)?
    var images: [String] = [String]()
    var title: String?
    
    @ObservedObject var countTimer: CountTimer = CountTimer(items: 4, interval: 4.0, dismiss: nil)
    @State private var value = true
    
    var body: some View {
        
        GeometryReader{ geometry in
            ZStack(alignment: .top) {
                HStack(alignment: .firstTextBaseline, spacing: 5) {
                    Text(self.title ?? "")
                }
                
                Image(self.images[Int(self.countTimer.progress)])
                    .resizable()
                    .edgesIgnoringSafeArea(.all)
                    .scaledToFill()
                    .frame(width: geometry.size.width,height: nil,alignment: .center)
                HStack(alignment: .center, spacing: 4) {
                    ForEach(0..<self.images.count, id: \.self) { image in
                        LoadingBar(progress: min( max( (CGFloat(self.countTimer.progress) - CGFloat(image)), 0.0) , 1.0) )
                            .frame(width:nil,height: 2, alignment:.leading)
                            .animation(Animation.linear, value: min( max( (CGFloat(self.countTimer.progress) - CGFloat(image)), 0.0) , 1.0))
                    }
                }.padding()
                
                HStack(alignment: .center, spacing:  4) {
                    Rectangle()
                        .foregroundColor(.clear)
                        .contentShape(Rectangle())
                        .onTapGesture {
                            self.countTimer.advancePage(by: -1)
                        }
                    
                    Rectangle()
                        .foregroundColor(.clear)
                        .contentShape(Rectangle())
                        .onTapGesture {
                            self.countTimer.advancePage(by: 1)
                            if Int(self.countTimer.progress) == 0 {
                                NotificationCenter.default.post(name: NSNotification.Name.init(rawValue: "StoryChange"), object: nil)
                                dismiss!()
                            }
                        }
                }
                .onAppear {
                    self.countTimer.start()
                }
            }
        }
    }
}

//
//  ContentView.swift
//  Pinsh
//
//  Created by Asem on 19/06/2022.
//

import SwiftUI

struct ContentView: View {
    @State private var isAnimating           = false
    @State private var isDrawOpening         = false
    @State private var scaleImage   :CGFloat = 1.0
    @State private var ofsetImage   :CGSize  = CGSize(width: 0, height: 0)
    @State private var nameImage             = "magazine-front-cover"
    var body: some View {
        NavigationView{
            ZStack{
                Image(nameImage).resizable().scaledToFit()
                    .cornerRadius(10).padding()
                    .shadow(color: .black.opacity(0.2), radius: 12, x: 2, y: 2)
                    .opacity(isAnimating ? 1 : 0)
                    .scaleEffect(scaleImage)
                    .offset(ofsetImage)
                    .onTapGesture(count: 2) {
                        if scaleImage==1{ withAnimation {scaleImage=2}
                        }else{            withAnimation {scaleImage=1; ofsetImage = .zero}  }
                    }
                    .gesture (
                        DragGesture()
                            .onChanged { gesture in withAnimation(.linear(duration: 1)) { ofsetImage = gesture.translation      } }
                            .onEnded { _         in withAnimation(.linear(duration: 1)) {if scaleImage <= 1 {ofsetImage = .zero}   } }
                    )
                    .gesture(
                        MagnificationGesture()
                            .onChanged({ value in   if scaleImage >= 1{ withAnimation(.linear(duration: 1)){scaleImage = value             } } })
                            .onEnded  ({ _     in   if scaleImage < 1 { withAnimation(.linear(duration: 1)){scaleImage=1;ofsetImage = .zero} } })
                    )
                VStack{
                    InfoPanelView(ofset: ofsetImage, scal: scaleImage)
                    Spacer()
                }.padding(.horizontal)
                    .padding(.vertical,30)
                VStack{
                    
                    Spacer()
                    HStack{
                        Button(action: {    withAnimation {if scaleImage>1{scaleImage-=1};if scaleImage==1{ofsetImage = .zero} }    }) {
                            Image(systemName: "minus.magnifyingglass").font(.title)
                        }
                        Button(action: {    withAnimation { scaleImage=1;ofsetImage = .zero }   }) {
                            Image(systemName: "arrow.up.left.and.down.right.magnifyingglass").font(.title)
                        }
                        Button(action:      {withAnimation { scaleImage+=1 }   }) {
                            Image(systemName: "plus.magnifyingglass").font(.title)
                        }
                    }.padding(8).background(.ultraThinMaterial).cornerRadius(10)
                    
                }.padding(.horizontal)
                    .padding(.vertical,30)
                VStack{
                    HStack{
                        Spacer()
                        HStack{
                            Image(systemName: isDrawOpening ? "chevron.compact.right" : "chevron.compact.left").resizable().scaledToFit().frame(height: 40).padding(.trailing)
                                
                            Image("thumb-magazine-back-cover").resizable().scaledToFit()
                                .onTapGesture {withAnimation {nameImage="magazine-back-cover"}}
                            Image("thumb-magazine-front-cover").resizable().scaledToFit()
                                .onTapGesture {withAnimation {nameImage="magazine-front-cover"}}
                            Spacer()
                        }.padding().background(.ultraThinMaterial)
                            .cornerRadius(12).opacity(isAnimating ? 1 : 0)
                            .frame(width: 260).padding(.top,UIScreen.main.bounds.height/15)
                            .offset(x:isDrawOpening ? 5 : 220)
                            .onTapGesture {withAnimation {isDrawOpening.toggle()}}
                            
                    }
                    Spacer()
                }
            }
            .onAppear(perform: {withAnimation(.linear(duration: 0.5)){ isAnimating=true } })
            .navigationTitle("Pinch & Zoom")
            .navigationBarTitleDisplayMode(.inline)
        }.navigationViewStyle(.stack)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
    }
}

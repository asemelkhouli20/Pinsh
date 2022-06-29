//
//  InfoPanelView.swift
//  Pinsh
//
//  Created by Asem on 19/06/2022.
//

import SwiftUI

struct InfoPanelView: View {
    var ofset:CGSize
    var scal:CGFloat
    
    @State var isInfoPanelVisable=false
    var body: some View {
        HStack{
            Image(systemName: "circle.circle")
                .symbolRenderingMode(.hierarchical)
                .resizable()
                .frame(width: 30, height: 30)
                .onLongPressGesture(minimumDuration: 0.3) { withAnimation(.easeOut) {isInfoPanelVisable.toggle()} }

            Spacer()
            HStack{
                Image(systemName: "arrow.up.left.and.arrow.down.right")
                Text("\(scal)")
                Spacer()
                Image(systemName:"arrow.left.and.right")
                Text("\(ofset.width)")
                Spacer()
                Image(systemName:"arrow.up.and.down")
                Text("\(ofset.height)")
                Spacer()
            }.lineLimit(1)
            .font(.footnote)
            .padding(8)
            .background(.ultraThinMaterial)
            .cornerRadius(8)
            .frame(maxWidth:420)
            .opacity(isInfoPanelVisable ? 1 : 0)
           Spacer()
        }
    }
}

struct InfoPanelView_Previews: PreviewProvider {
    static var previews: some View {
        InfoPanelView(ofset: .zero, scal: .zero)
            .preferredColorScheme(.dark)
            .previewLayout(.sizeThatFits)
            .padding()
    }
}

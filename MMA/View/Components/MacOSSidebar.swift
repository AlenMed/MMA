//
//  MacOSSidebar.swift
//  MMA
//
//  Created by ektamannen on 14/02/2024.
//

import SwiftUI

struct MacOSSidebar: View {
    @Bindable var contentVM: ContentViewModel
    
    
    var body: some View {
        List {
            ForEach(contentVM.appStates.prefix(4), id: \.id) { state in
                Button {
                    withAnimation {
                        contentVM.appState = state.id
                    }
                } label: {
                    HStack(alignment: .bottom) {
                        Image(systemName: state.imageName)
                        Text(state.name)
                    }
                }
                .frame(maxWidth: 160, alignment: .leading)
                .padding(6)
                .buttonStyle(PlainButtonStyle())
                .background(contentVM.appState == state.id ? Color.accentColor : Color.clear)
                .font(.system(size: 13))
                .foregroundStyle(contentVM.appState == state.id ? Color.primary : Color.accentColor)
                .fontWeight(contentVM.appState == state.id ? .semibold : .medium)
                .clipShape(RoundedRectangle(cornerRadius: 8))
            }
        }
        .listStyle(SidebarListStyle())
    }
}

#Preview {
    MacOSSidebar(contentVM: ContentViewModel())
}

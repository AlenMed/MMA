//
//  MacOSSidebar.swift
//  MMA
//
//  Created by ektamannen on 14/02/2024.
//

//import SwiftUI
//
//struct MacSidebar: View {
//    @Bindable var contentVM: ContentViewModel
//    
//    
//    var body: some View {
//        List {
//            ForEach(contentVM.appStates.prefix(4), id: \.id) { state in
//                HStack {
//                    Button {
//                        withAnimation {
//                            contentVM.currentAppState = state
//                        }
//                    } label: {
//                        Image(systemName: state.image)
//                            .padding(2)
//                        Text(state.name)
//                            .padding(2)
//                    }
//                    .frame(maxWidth: 160, alignment: .leading)
//                    .padding(6)
//                    .buttonStyle(PlainButtonStyle())
//                    .background(contentVM.currentAppState.id == state.id ? Color.accentColor : Color.clear)
//                    .font(.system(size: 13))
//                    .foregroundStyle(contentVM.currentAppState.id == state.id ? Color.primary : Color.accentColor)
//                    .fontWeight(contentVM.currentAppState.id == state.id ? .semibold : .medium)
//                    .clipShape(RoundedRectangle(cornerRadius: 8))
//                }
//            }
//        }
//        .listStyle(SidebarListStyle())
//    }
//}
//
//#Preview {
//    MacSidebar(contentVM: ContentViewModel())
//}

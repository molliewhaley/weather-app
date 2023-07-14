//
//  CollapsibleContentView.swift
//  Weather
//
//  Created by Mollie Whaley on 7/3/23.
//

import SwiftUI

// creates collapsible appearance for forecast view
struct Collapsible<Label: View, Content: View>: View {
    
    var label: () -> Label
    var content: () -> Content
    @State private var collapsed: Bool = false
    
    var body: some View {
        VStack(spacing: 0) {
            Button(
                action: {
                    withAnimation {
                        self.collapsed.toggle()
                    }
                },
                label: {
                    self.label()
                }
            )}
            
            .buttonStyle(PlainButtonStyle())
            
            ZStack {
                VStack {
                    self.content()
                }
                .frame(minWidth: 0, maxWidth: .infinity)
                .foregroundColor(.white)
                .background(Color.black)
                .animation(.easeOut, value: 2)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.white, lineWidth: 2)
                )
                .opacity(collapsed ? 1 : 0)
            }
            .frame(maxHeight: collapsed ? .none : 0)
        }
    }

struct CollapsibleContentView_Previews: PreviewProvider {
    static var previews: some View {
        Collapsible(label: {Text("Label")},
                    content: {Text("Content")}
        )
    }
}

//
//  ConditionView.swift
//  Weather
//
//  Created by Mollie Whaley on 7/2/23.
//

import SwiftUI

struct ConditionView: View {
    
    let condition: String
    let conditionImage: String
    let conditionTitle: String
    let spacing: CGFloat
            
    var body: some View {
        VStack(spacing: spacing) {
            Text("\(condition)")
            
            Image(systemName: "\(conditionImage)")
            
            Text("\(conditionTitle)")
        }
    }
}

struct ConditionView_Previews: PreviewProvider {
    static var previews: some View {
        ConditionView(condition: "Condition", conditionImage: "sun.max.fill", conditionTitle: "Title", spacing: 10)
    }
}

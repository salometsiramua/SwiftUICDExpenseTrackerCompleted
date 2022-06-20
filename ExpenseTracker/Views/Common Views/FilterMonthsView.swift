//
//  FilterMonthsView.swift
//  ExpenseTracker
//
//  Created by Salome Tsiramua on 6/16/22.
//  Copyright © 2022 Alfian Losari. All rights reserved.
//

import SwiftUI

struct FilterMonthsView: View {
    
    @Binding var selectedMonths: Set<Month>
    private let months = Month.allCases
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 16) {
                ForEach(months) { month in
                    FilterMonthsButtonView(
                        month: month,
                        isSelected: self.selectedMonths.contains(month),
                        onTap: self.onTap
                    )
                        
                        .padding(.leading, month == self.months.first ? 16 : 0)
                        .padding(.trailing, month == self.months.last ? 16 : 0)
                    
                }
            }
        }
        .padding(.vertical)
    }
    
    func onTap(month: Month) {
        if selectedMonths.contains(month) {
            selectedMonths.remove(month)
        } else {
            selectedMonths.insert(month)
        }
    }
}

struct FilterMonthsButtonView: View {
    
    var month: Month
    var isSelected: Bool
    var onTap: (Month) -> ()
    
    var body: some View {
        Button(action: {
            self.onTap(self.month)
        }) {
            HStack(spacing: 8) {
                Text(month.rawValue.capitalized)
                    .fixedSize(horizontal: true, vertical: true)
                
                if isSelected {
                    Image(systemName: "xmark.circle.fill")
                }
            }
            .padding(.vertical, 8)
            .padding(.horizontal, 16)
                
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(isSelected ? month.color : Color(UIColor.lightGray), lineWidth: 1))
                .frame(height: 44)
        }
        .foregroundColor(isSelected ? month.color : Color(UIColor.gray))
    }
    
    
}


struct FilterMonthsView_Previews: PreviewProvider {
    static var previews: some View {
        FilterMonthsView(selectedMonths: .constant(Set()))
    }
}

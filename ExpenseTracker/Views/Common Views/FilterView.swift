//
//  FilterMonthsView.swift
//  ExpenseTracker
//
//  Created by Salome Tsiramua on 6/16/22.
//  Copyright © 2022 Alfian Losari. All rights reserved.
//

import SwiftUI

struct FilterView<FilterableView: Filterable>: View {
    
    @Binding var selectedViews: Set<FilterableView>
    let filterableViews: [FilterableView]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: Sizes.mediumSpacing.rawValue) {
                ForEach(filterableViews) { filterableView in
                    FilterButtonView(
                        filterableView: filterableView,
                        isSelected: self.selectedViews.contains(filterableView),
                        onTap: self.onTap
                    )
                        
                        .padding(.leading, filterableView == self.filterableViews.first ? Sizes.mediumSpacing.rawValue : 0)
                        .padding(.trailing, filterableView == self.filterableViews.last ? Sizes.mediumSpacing.rawValue : 0)
                    
                }
            }
        }
        .padding(.vertical)
    }
    
    func onTap(filterableView: FilterableView) {
        if selectedViews.contains(filterableView) {
            selectedViews.remove(filterableView)
        } else {
            selectedViews.insert(filterableView)
        }
    }
}

struct FilterButtonView<FilterableView: Filterable>: View {
    
    var filterableView: FilterableView
    var isSelected: Bool
    var onTap: (FilterableView) -> ()
    
    var body: some View {
        Button(action: {
            self.onTap(self.filterableView)
        }) {
            HStack(spacing: 8) {
                Text(filterableView.value.capitalized)
                    .fixedSize(horizontal: true, vertical: true)
                
                if isSelected {
                    Image(systemName: "xmark.circle.fill")
                }
            }
            .padding(.vertical, 8)
            .padding(.horizontal, Sizes.mediumSpacing.rawValue)
                
            .overlay(
                RoundedRectangle(cornerRadius: Sizes.mediumSpacing.rawValue)
                    .stroke(isSelected ? filterableView.color : Color(UIColor.lightGray), lineWidth: 1))
                .frame(height: 44)
        }
        .foregroundColor(isSelected ? filterableView.color : Color(UIColor.gray))
    }
}

struct FilterView_Previews: PreviewProvider {
    static var previews: some View {
        FilterView(selectedViews: .constant(Set()), filterableViews: Month.allCases)
    }
}

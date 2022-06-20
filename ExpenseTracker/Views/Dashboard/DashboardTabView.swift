//
//  DashboardTabView.swift
//  ExpenseTracker
//
//  Created by Alfian Losari on 19/04/20.
//  Copyright © 2020 Alfian Losari. All rights reserved.
//

import SwiftUI
import CoreData

struct DashboardTabView: View {
    
    @Environment(\.managedObjectContext)
    var context: NSManagedObjectContext
    
    @State var totalExpenses: Double?
    @State var categoriesSum: [CategorySum]?
    @State var rate: Double = 1
    @State var currency: Currency = .usd
    @State var selectedCurrencyIndex: Int = 0
    
    var body: some View {
        VStack(spacing: 0) {
            VStack(spacing: Sizes.mediumSpacing.rawValue) {
                if totalExpenses != nil {
                    HStack {
                        Spacer()
                        Picker("", selection: $selectedCurrencyIndex) {
                            Text(Currency.usd.symbol).tag(0)
                            Text(Currency.eur.symbol).tag(1)
                        }.pickerStyle(SegmentedPickerStyle()).frame(width: Sizes.pickerWidth.rawValue).padding().valueChanged(value: selectedCurrencyIndex, onChange: { (value) in
                            convert(to: currency.alternate)
                        })
                    }
                    
                    Text(Strings.Dashboard.totalExpenses.rawValue)
                        .font(.headline)
                    if totalExpenses != nil {
                        Text(totalSumFormatted ?? "")
                            .font(.largeTitle)
                    }
                }
            }
            
            if categoriesSum != nil {
                if totalExpenses != nil && totalExpenses! > 0 {
                    PieChartView(
                        data: categoriesSum!.map { ($0.sum, $0.category.color) },
                        style: Styles.pieChartStyleOne,
                        form: CGSize(width: Sizes.chartWidth.rawValue, height: Sizes.chartHeight.rawValue),
                        dropShadow: false
                    )
                }
                
                Divider()
                
                List {
                    Text(Strings.Dashboard.breakdown.rawValue).font(.headline)
                    ForEach(self.categoriesSum!) {
                        CategoryRowView(category: $0.category, sum: $0.sum, currency: $0.currency)
                            
                    }
                }.background(Colors.alternateBackground)
            }
            
            if totalExpenses == nil && categoriesSum == nil {
                Text(Strings.Dashboard.noExpenses.rawValue)
                    .multilineTextAlignment(.center)
                    .font(.headline)
                    .padding(.horizontal)
            }
        }
        .padding(.top)
        .onAppear(perform: fetchTotalSums)
        .background(Colors.background)
    }
    
    func fetchTotalSums() {
        ExpenseLog.fetchAllCategoriesTotalAmountSum(context: self.context) { (results) in
            guard !results.isEmpty else { return }
            
            let totalSum = results.map { $0.sum }.reduce(0, +)
            self.totalExpenses = totalSum
            self.categoriesSum = results.map({ (result) -> CategorySum in
                return CategorySum(sum: result.sum, category: result.category, currency: .usd)
            })
        }
    }
    
    func convert(to currency: Currency) {
        fetchRate(for: currency, completion: { result in
            self.rate = result?.rate ?? 1
            self.updateCategoryCurrency()
        })
    }
    
    func updateCategoryCurrency() {
        categoriesSum?.forEach({ (categorySum) in
            categorySum.changeCurrency(with: rate, currency: currency)
        })
    }
    
    var totalSumFormatted: String? {
        categoriesSum?.map { $0.sum }.reduce(0, +).formattedCurrencyText(for: currency)
    }
    
    func fetchRate(for currency: Currency, completion: @escaping (CurrencyResponse?) -> ()) {
        let manager = ServiceManager()
        let fromCurrency = self.currency
        let toCurrency = currency
        print("from: \(fromCurrency) to: \(toCurrency))")
        manager.fetchRate(from: fromCurrency, to: toCurrency, completion: { result in
            switch result {
            case .success(let response):
                self.currency = toCurrency
                completion(response)
                print(rate)
            case .failure(let error):
                completion(nil)
                print(error)
            }
        })
    }
}

class CategorySum: Identifiable, Equatable {
    static func == (lhs: CategorySum, rhs: CategorySum) -> Bool {
        lhs.sum == rhs.sum
            && lhs.category == rhs.category
            && lhs.currency == rhs.currency
    }
    
    var sum: Double
    var category: Category
    var currency: Currency
    
    init(sum: Double, category: Category = .other, currency: Currency = .usd) {
        self.sum = sum
        self.category = category
        self.currency = currency
    }
    
    var id: String { "\(category)\(sum)" }
    
    func changeCurrency(with rate: Double, currency: Currency) {
        self.currency = currency
        self.sum = sum * rate
    }
}

struct DashboardTabView_Previews: PreviewProvider {
    static var previews: some View {
        
        let coreDataStack = CoreDataStack(containerName: "ExpenseTracker")
        
        DashboardTabView(currency: .usd)
            .environment(\.managedObjectContext, coreDataStack.viewContext)
    }
}

//
//  ContentView.swift
//  LoanDetailsProject
//
//  Created by Claudio Vega on 12-08-24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        LoanDetailsView(viewModel: LoanDetailsViewModel())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

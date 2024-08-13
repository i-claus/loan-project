//
//  LoanDetailsView.swift
//  LoanDetailsProject
//
//  Created by Claudio Vega on 12-08-24.
//

import SwiftUI

struct LoanDetailsView: View {
    @ObservedObject var viewModel: LoanDetailsViewModel

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                if let loanDetails = viewModel.loanDetails {
                    PaymentDetailsView(paymentDetails: loanDetails.paymentDetails)
                    LoanSummaryView(loanDetails: loanDetails.loanDetails)
                    MoreOptionsView(loanDetails: loanDetails.loanDetails)
                } else if let errorMessage = viewModel.errorMessage {
                    Text("Error: \(errorMessage)")
                } else {
                    ProgressView("Loading...")
                }
            }
            .padding()
            .background(Styles.Colors.background.ignoresSafeArea())
        }
        .onAppear {
            viewModel.fetchLoanDetails()
        }
    }
}

struct PaymentDetailsView: View {
    let paymentDetails: LoanDetails.PaymentDetails

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Button(action: {
                    // Handle back action
                }) {
                    Image(systemName: "arrow.left")
                        .foregroundColor(.black)
                        .padding()
                        .background(Styles.Colors.circleBack)
                        .clipShape(Circle())
                }
                Spacer()
            }
            
            Spacer()
            
            Text("Due in \(paymentDetails.dueInDays) days")
                .font(Styles.Fonts.small)
                .foregroundColor(Styles.Colors.textSecondary)
            
            HStack(alignment: .bottom, spacing: 2) {
                let amountString = String(format: "%.2f", paymentDetails.amountDue)
                let amountParts = amountString.split(separator: ".")
                
                let integerPart = String(amountParts.first ?? "0")
                let decimalPart = String(amountParts.last ?? "00")
                
                Text("$\(integerPart)")
                    .font(Styles.Fonts.largeTitle)
                    .foregroundColor(Styles.Colors.textPrimary)
                Text(".\(decimalPart)")
                    .font(Styles.Fonts.small)
                    .foregroundColor(Styles.Colors.textSecondary)
                    .fontWeight(.bold)
                    .baselineOffset(4)
            }
            
            HStack {
                Text("Next payment")
                    .font(Styles.Fonts.small)
                    .foregroundColor(Styles.Colors.textSecondary)
                Text(formatDate(paymentDetails.nextPaymentDate))
                    .font(Styles.Fonts.small)
                    .fontWeight(.bold)
                    .foregroundColor(Styles.Colors.textPrimary)
                Spacer()
                HStack(spacing: 4) {
                    Image("iconcard") 
                        .resizable()
                        .frame(width: 64, height: 44)
                    (Text("\(paymentDetails.paymentProgress.currentPaymentNumber)").fontWeight(.bold) +
                     Text(" of \(paymentDetails.paymentProgress.totalPayments) payments"))
                        .font(Styles.Fonts.small)
                        .foregroundColor(Styles.Colors.textSecondary)
                }
            }
            Spacer(minLength: 5)
            
            Button(action: {
                // Handle Make a Payment Action
            }) {
                Text("Make a payment")
                    .font(Styles.Fonts.body)
                    .fontWeight(.bold)
                    .foregroundColor(Styles.Colors.buttonText)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Styles.Colors.primary)
                    .cornerRadius(25)
            }
        }
        .padding()
        .background(Styles.Images.coinBackground)
        .cornerRadius(20)
    }
    private func formatDate(_ date: String) -> String {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd"
        
        if let date = inputFormatter.date(from: date) {
            let outputFormatter = DateFormatter()
            outputFormatter.dateFormat = "dd MMM"
            return outputFormatter.string(from: date)
        }
        
        return date
    }
}

struct LoanSummaryView: View {
    let loanDetails: LoanDetails.LoanDetail

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Loan Details")
                .font(Styles.Fonts.title)
                .foregroundColor(Styles.Colors.textPrimary)
                .padding(.bottom, 10)
            
            HStack {
                VStack(alignment: .leading) {
                    Text("Left")
                        .font(Styles.Fonts.body)
                        .foregroundColor(Styles.Colors.textSecondary)
                    Text(formattedCurrency(loanDetails.remainingBalance))
                        .font(Styles.Fonts.body)
                        .fontWeight(.bold)
                        .foregroundColor(Styles.Colors.textPrimary)
                }
                Spacer()
                VStack(alignment: .leading) {
                    Text("Amount Borrowed")
                        .font(Styles.Fonts.body)
                        .foregroundColor(Styles.Colors.textSecondary)
                    Text(formattedCurrency(loanDetails.amountBorrowed))
                        .font(Styles.Fonts.body)
                        .fontWeight(.bold)
                        .foregroundColor(Styles.Colors.textPrimary)
                }
            }
            
            ProgressView(value: loanDetails.remainingBalance, total: loanDetails.amountBorrowed)
                .progressViewStyle(LinearProgressViewStyle(tint: Styles.Colors.progressBar))
                .frame(height: 8)
                .padding(.vertical, 8)
            
            VStack(spacing: 16) {
                HStack(spacing: 16) {
                    InfoCard(title: "Interest", value: formattedCurrency(loanDetails.interestPaidToDate))
                    InfoCard(title: "Interest Rate", value: formattedPercentage(loanDetails.interestRate))
                }
                HStack(spacing: 16) {
                    InfoCard(title: "Loan ID", value: loanDetails.loanID)
                    UpcomingPaymentsCard()
                }
            }
        }
        .padding()
        .background(Styles.Colors.secondary)
        .cornerRadius(20)
    }
    
    private func formattedCurrency(_ value: Double) -> String {
        return String(format: "$%.2f", value)
    }

    private func formattedPercentage(_ value: Double) -> String {
        return String(format: "%.1f%%", value)
    }
}

struct InfoCard: View {
    let title: String
    let value: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(Styles.Fonts.body)
                .foregroundColor(Styles.Colors.textSecondary)
            Spacer()
            Text(value)
                .font(Styles.Fonts.body)
                .fontWeight(.bold)
                .foregroundColor(Styles.Colors.textPrimary)
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .background(Color.white)
        .cornerRadius(15)
        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 5)
    }
}

struct UpcomingPaymentsCard: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Spacer()
                ZStack {
                    Circle()
                        .fill(Color.white.opacity(0.2))
                        .frame(width: 45, height: 45)
                    Image(systemName: "arrow.right")
                        .foregroundColor(.white)
                }
            }
            Spacer()
            Text("Upcoming payments")
                .font(Styles.Fonts.body)
                .foregroundColor(.white)
                .fontWeight(.bold)
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .background(Styles.Colors.primary)
        .cornerRadius(15)
        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 5)
    }
}

struct MoreOptionsView: View {
    let loanDetails: LoanDetails.LoanDetail

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("More Options")
                .font(Styles.Fonts.title)
                .foregroundColor(Styles.Colors.textPrimary)
                .padding(.bottom, 10)
            
            Button(action: {
                // Handle Increase Paydown Credit Action
            }) {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Increase Paydown Credit")
                        .font(Styles.Fonts.body)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    Text("Up to $10,000")
                        .font(Styles.Fonts.small)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                }
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Styles.Colors.sections)
                .cornerRadius(20)
                .overlay(
                    ZStack {
                        Circle()
                            .fill(Color.white.opacity(0.2))
                            .frame(width: 45, height: 45) 
                        Image(systemName: "arrow.right")
                            .foregroundColor(.white)
                    }
                    .padding(.trailing, 16), alignment: .trailing
                )
            }
            
            OptionRowView(iconName: "calendar", title: "Change repayment date", subtitle: "Currently on the \(loanDetails.repaymentDay)th")
            OptionRowView(iconName: "creditcard", title: "Update payment details", subtitle: "Account ending \(loanDetails.lastFourPaymentCard)")
            OptionRowView(iconName: "person", title: "Update personal information", subtitle: "dyalland@gmail.com")
            OptionRowView(iconName: "doc.text", title: "View saved documents", subtitle: "\(loanDetails.numberOfDocuments) documents")
        }
        .padding()
        .fontWeight(.bold)
        .background(Styles.Colors.secondary)
        .cornerRadius(20)
    }
}

struct OptionRowView: View {
    let iconName: String
    let title: String
    let subtitle: String

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(title)
                    .font(Styles.Fonts.body)
                    .foregroundColor(Styles.Colors.textPrimary)
                Text(subtitle)
                    .font(Styles.Fonts.small)
                    .foregroundColor(Styles.Colors.textSecondary)
            }
            Spacer()
            Image(systemName: iconName)
                .padding()
                .background(Styles.Colors.primary)
                .foregroundColor(.white)
                .clipShape(Circle())
                .frame(width: 40, height: 40) 
        }
        .padding()
        .background(Color.white)
        .cornerRadius(20)
        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 5)
    }
}

struct LoanDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        LoanDetailsView(viewModel: MockLoanDetailsViewModel())
    }
}


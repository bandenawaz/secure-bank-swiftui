//
//  Test.swift
//  SecureFinance_Playground
//
//  Created by Bandenawaz Bagwan on 10/12/25.
//

import Foundation

// --- MODELS ---

// struct: A blueprint for data.
// We use 'let' for IDs (immutable) and 'var' for status (mutable).
struct Customer {
    let id: String
    let name: String
    var kycCompleted: Bool
    var riskScore: Int
}

struct Policy {
    let id: String
    let type: String // "Life", "Health", "Vehicle"
    var premiumAmount: Double
    var isActive: Bool
}

// --- APP LOGIC WRAPPER ---

/// Wrap mutable state inside an isolated type to avoid global shared mutable state warnings.
struct SecureFinanceApp {
    // DATA STORE (Mock Database)
    var myCustomer = Customer(id: "CUST001", name: "Amit Patel", kycCompleted: false, riskScore: 700)
    var myPolicies: [Policy] = [
        Policy(id: "POL_LIFE_01", type: "Life", premiumAmount: 12000.0, isActive: true),
        Policy(id: "POL_CAR_99", type: "Vehicle", premiumAmount: 5000.0, isActive: false) // Lapsed
    ]
    var accountBalance: Double = 50000.0

    // --- BUSINESS LOGIC ---

    func printDashboard() {
        print("--- 🏦 SECURE FINANCE DASHBOARD ---")
        print("User: \(myCustomer.name)")

        // CONTROL FLOW: Check KYC
        if myCustomer.kycCompleted {
            print("Status: ✅ Verified")
        } else {
            print("Status: ⚠️ KYC Pending (Transaction limits applied)")
        }

        print("Balance: INR \(accountBalance)")
        print("-----------------------------------")
    }

    mutating func payPremium(policyID: String) {
        // HIGHER ORDER FUNCTION: Find the specific policy
        // We use first(where:) which returns an Optional (Policy might not exist)
        if let index = myPolicies.firstIndex(where: { $0.id == policyID }) {

            let policyToPay = myPolicies[index]

            // GUARD: Validation
            guard policyToPay.isActive else {
                print("❌ Error: Policy \(policyID) is inactive. Cannot pay premium.")
                return
            }

            if accountBalance >= policyToPay.premiumAmount {
                accountBalance -= policyToPay.premiumAmount
                print("✅ Success: Paid INR \(policyToPay.premiumAmount) for \(policyToPay.type) Insurance.")
            } else {
                print("❌ Error: Insufficient funds.")
            }

        } else {
            print("❌ Error: Policy not found.")
        }
    }

    func calculateRiskCategory() -> String {
        // SWITCH: categorizing ranges
        switch myCustomer.riskScore {
        case 750...: return "Low Risk (Premium Discount Eligible)"
        case 600..<750: return "Moderate Risk"
        default: return "High Risk (Review Required)"
        }
    }

    mutating func run() {
        // --- EXECUTION ---
        printDashboard()

        // Try to pay premium
        print("\nAttempting to pay Life Insurance Premium...")
        payPremium(policyID: "POL_LIFE_01")

        // Try to pay lapsed policy
        print("\nAttempting to pay Vehicle Insurance Premium...")
        payPremium(policyID: "POL_CAR_99")

        // Check risk
        print("\nRisk Analysis: \(calculateRiskCategory())")

        // Final Balance
        print("\nFinal Balance: INR \(accountBalance)")
    }
}

// --- ENTRY POINT ---
@main
struct Main {
    static func main() {
        var app = SecureFinanceApp()
        app.run()
    }
}

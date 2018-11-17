//
//  classes.swift
//  ECS189E
//
//  Created by Zhiyi Xu on 10/26/18.
//  Copyright © 2018 Zhiyi Xu. All rights reserved.
//
import Foundation

// Usage:
// Getting: phoneNumber = Storage.phoneNumberInE164
// Setting: Storage.phoneNumberInE164 = phoneNumber

struct Storage {
    static var phoneNumberInE164: String? {
        get {
            return UserDefaults.standard.string(forKey: "phoneNumberInE164")
        }
        
        set(phoneNumberInE164) {
            UserDefaults.standard.set(phoneNumberInE164, forKey: "phoneNumberInE164")
            print("Saving phone number was \(UserDefaults.standard.synchronize())")
        }
    }
    
    static var authToken: String? {
        get {
            return UserDefaults.standard.string(forKey: "authToken")
        }
        
        set(authToken) {
            UserDefaults.standard.set(authToken, forKey: "authToken")
            print("Saving auth token was \(UserDefaults.standard.synchronize())")
        }
    }
}

// Usage:
// In case you want me to generate a list of Accounts with random amounts and names
//      var wallet = Wallet.init(data: response, ifGenerateAccounts: true)
// In case you want to customized your accounts
//      var wallet = Wallet.init(data: response, ifGenerateAccounts: false)

class Wallet {
    var userName: String?
    var totalAmount: Double
    var phoneNumber: String
    var accounts: [Account]
    
    init() {
        self.userName = ""
        self.totalAmount = 0.0
        self.phoneNumber = ""
        self.accounts = [Account]()
    }
    
    init(data: [String: Any], ifGenerateAccounts: Bool) {
        let walletData = data["user"] as! [String:Any]
        self.userName = walletData["name"] as? String
        self.totalAmount = 0.0
        self.phoneNumber = walletData["e164_phone_number"] as! String
        self.accounts = [Account]()

        if ifGenerateAccounts {
            for i in 0 ..< Int.random(in: 8 ..< 16) {
                self.accounts.append(Account(index: i, randomAmount: true))
            }
        } else {
            if let accountsData = walletData["accounts"] as? [[String: Any]] {
                for each in accountsData {
                    self.accounts.append(Account.init(data: each))
                }
            } else {
                print("No account data found.")
            }
        }
        
        for i in 0 ..< self.accounts.count {
            self.totalAmount += self.accounts[i].amount
        }
    }
    
    func printWallet() {
        print("=======================")
        print("user:\(self.userName ?? "")")
        print("phone number:\(self.phoneNumber)")
        print("totle amount:\(self.totalAmount)")
        print("List of Accounts:")
        for account in self.accounts {
            print("  \(account.name) has \(account.amount)")
        }
    }
}

class Account {
    var name: String
    var ID: String
    var amount: Double
    
    init() {
        self.name = ""
        self.ID = UUID().uuidString
        self.amount = 0
    }
    
    // For random generating
    init(index: Int, randomAmount: Bool) {
        self.name = "Account " + String(index)
        self.ID = UUID().uuidString
        self.amount = 0
        if randomAmount {
            self.amount = round(Double.random(in: 10 ..< 10000) * 100) / 100
        }
    }
    
    // For data reading
    init(data: [String: Any]) {
        self.name = data["name"] as? String ?? ""
        self.ID = data["ID"] as? String ?? ""
        self.amount = Double(data["amount"] as? String ?? "") ?? 0.0
    }
    
    // For creating new account
    init(name: String) {
        self.name = name
        self.ID = UUID().uuidString
        self.amount = 0
    }
}

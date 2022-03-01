//
//  IAPManager.swift
//  Bloggers
//
//  Created by omair khan on 08/02/2022.
//
import Foundation
import Purchases
import StoreKit
/// 802576bcebc341559b79b3e7566f09b4



class IAPManager {
    

    static let shared = IAPManager()
    
    func isPremium() -> Bool {
        return UserDefaults.standard.bool(forKey: premium)
    }
    
    
    // Get Current User Purchases status
    public func getSubscritionStatus(completion: ((Bool) ->  Void)?){
        Purchases.shared.purchaserInfo { purchaserInfo, error in
            guard let entitlements = purchaserInfo?.entitlements , error == nil else{
                print(error!.localizedDescription)
                return
            }
            
            if entitlements.all[entitlementKey]?.isActive ==  true {
                // If user is subscribed
                UserDefaults.standard.set(true, forKey: premium)
                completion?(true)
                
            }else {
                // If user is not subscribed
                UserDefaults.standard.set(false, forKey: premium)
                completion?(false)
            }
        }
    }
    
    //  get your purchases packages
    public func getPurchasesPackages(completion: @escaping(Purchases.Package?) -> Void){
        
        Purchases.shared.offerings { offerings, error in
            
            /* Cannot get packages directly hence we've to refer
             to offering which returns an array of avaialble packages */
            
            guard let packages = offerings?.offering(identifier: "default")?.availablePackages.first, error == nil else {
                print(error!.localizedDescription)
                completion(nil)
                return
            }
            completion(packages)
        }
        
    }
    
    func subscribe(package: Purchases.Package, completion: @escaping(Bool) -> Void) {
        
        //Check  if user is not subscribed
        
        guard !isPremium() else {
            print("User is already subscribed")
            completion(true)
            return
        }
        
        
        Purchases.shared.purchasePackage(package) { transaction, purchaserInfo, error, userCancelled in
            
            guard let transaction = transaction,
                  let entitlements = purchaserInfo?.entitlements,
                  error == nil,
                  !userCancelled else {
                      print(error!.localizedDescription)
                      return
                  }
            // If all above goes well then we switch through transactions states
            
            switch transaction.transactionState {
                
            case .purchasing:
                print("Purchasing")
            case .purchased:
                print("Purchased \(entitlements)")
                
                if entitlements.all[entitlementKey]?.isActive ==  true {
                    // If purchase is succcessful
                    UserDefaults.standard.set(true, forKey: premium)
                    completion(true)
                    
                } else {
                    // If purchase is failed
                    UserDefaults.standard.set(false, forKey: premium)
                    completion(false)
                }
            case .failed:
                print("Transaction Fiales")
            case .restored:
                print("Restoring Purchase")
            case .deferred:
                print("deferred")
            @unknown default:
                print("default state")
            }
        }
    }
    
    func restorePurchase(completion: @escaping(Bool) -> Void) {
        
        Purchases.shared.restoreTransactions { purchaserInfo, error in
            
            guard let entitlements = purchaserInfo?.entitlements,
                  error == nil else {
                      
                      print(error!.localizedDescription)
                      return
                  }
            
            if entitlements.all[entitlementKey]?.isActive ==  true {
                // If purchase is succcessful
                UserDefaults.standard.set(true, forKey: premium)
                completion(true)
                
            } else {
                // If purchase is failed
                UserDefaults.standard.set(false, forKey: premium)
                completion(false)
            }
            
        }
    }
  
    
}





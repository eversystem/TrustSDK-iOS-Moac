// Copyright © 2018 Trust.
//
// This file is part of TrustSDK. The full TrustSDK copyright notice, including
// terms governing use, modification, and redistribution, is contained in the
// file LICENSE at the root of the source code distribution tree.

import Foundation
import TrustCore
import BigInt

@objc(TrustSDK)
public extension TrustSDK {
    @objc
    public func signMessage(_ message: Data, address: String? = nil, success: @escaping (Data) -> Void, failure: @escaping (NSError) -> Void) {
        signMessage(message) { result in
            switch result {
            case .success(let signedMesssage):
                success(signedMesssage)
            case .failure(let error):
                failure(error as NSError)
            }
        }
    }

    @objc
    public func signTransaction(_ gasPrice: String, _ gasLimit: UInt64, _ address: String, amount: String, shardingFlag: String, systemContract: String, via: String, success: @escaping (Data) -> Void, failure: @escaping (NSError) -> Void) {
        var transaction = Transaction(gasPrice: BigInt(gasPrice)!, gasLimit: gasLimit, to: MoacAddress(string: address)!, shardingFlag: BigInt(shardingFlag)!, systemContract: BigInt(systemContract)!, via: MoacAddress(string: via)!)
        transaction.amount = BigInt(amount)!

        signTransaction(transaction) { result in
            switch result {
            case .success(let signedMesssage):
                success(signedMesssage)
            case .failure(let error):
                failure(error as NSError)
            }
        }
    }

    @objc
    public func signPersonalMessage(_ message: Data, address: String? = nil, success: @escaping (Data) -> Void, failure: @escaping (NSError) -> Void) {
        signPersonalMessage(message, address: address.flatMap({ MoacAddress(string: $0) })) { result in
            switch result {
            case .success(let signedMesssage):
                success(signedMesssage)
            case .failure(let error):
                failure(error as NSError)
            }
        }
    }
}

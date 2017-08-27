//
//  ItemsModelMock.swift
//  Mocky
//
//  Created by przemyslaw.wosko on 19/05/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import Foundation
import Mocky
import XCTest
@testable import Mocky_Example
import RxSwift

// sourcery: mock = "ItemsModel"
class ItemsModelMock: ItemsModel, Mock {

    var some: Any = "manually supported property"
    var storedProperty: Any = ""

// sourcery:inline:auto:ItemsModelMock.autoMocked
    //swiftlint:disable force_cast

    var invocations = [MethodType]()
    var methodReturnValues: [MethodProxy] = []

    //MARK : ItemsModel
 
    var context: Any?     
    var storage: Any!     
    // var some: Any - not supported     
    // var storedProperty: Any - not supported    

    func getExampleItems() -> Observable<[Item]> {
        addInvocation(.getExampleItems)
        return methodReturnValue(.getExampleItems) as! Observable<[Item]> 
    }
    
    func getItemDetails(item: Item) -> Observable<ItemDetails> {
        addInvocation(.getItemDetails(item: .value(item)))
        return methodReturnValue(.getItemDetails(item: .value(item))) as! Observable<ItemDetails> 
    }
    
    enum MethodType: Equatable {

        case getExampleItems    
        case getItemDetails(item : Parameter<Item>)     
    
        static func ==(lhs: MethodType, rhs: MethodType) -> Bool {
            switch (lhs, rhs) {

                case (.getExampleItems, .getExampleItems): return true                
                case (let .getItemDetails(lhsParams), let .getItemDetails(rhsParams)): return lhsParams == rhsParams                 
                default: return false   
            }
        }
    }

    struct MethodProxy {
        var method: MethodType 
        var returns: Any? 

        static func getExampleItems(willReturn: Observable<[Item]>) -> MethodProxy {
            return MethodProxy(method: .getExampleItems, returns: willReturn)
        }
        
        static func getItemDetails(item: Parameter<Item>, willReturn: Observable<ItemDetails>) -> MethodProxy {
            return MethodProxy(method: .getItemDetails(item: item), returns: willReturn)
        }
         
    }

    private func methodReturnValue(_ method: MethodType) -> Any? {
        let all = methodReturnValues.filter({ proxy -> Bool in
            return proxy.method == method
        })

        return all.last?.returns
    }
// sourcery:end
}

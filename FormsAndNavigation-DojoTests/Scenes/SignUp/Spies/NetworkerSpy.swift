//
//  NetworkerSpy.swift
//  FormsAndNavigation-DojoTests
//
//  Created by Kauê Sales on 01/02/22.
//

import Foundation
@testable import FormsAndNavigation_Dojo
import XCTest

final class NetworkerSpy: NetworkerProtocol {
    // MARK: - Properties
    private(set) var verifyRequestArgs: [Networker.Target] = []
    var completionToBeReturned: Result<Bool, Error> = .success(true)
    
    // MARK: - NetworkerProtocol Methods
    func request(
        target: Networker.Target,
        completion: (Result<Bool, Error>) -> Void
    ) {
        verifyRequestArgs.append(target)
        
        completion(completionToBeReturned)
    }
}

// MARK: - Verifier Methods
extension NetworkerSpy {
    func verifyRequestWasCalledOnce(
        arg: Networker.Target,
        file: StaticString = #file,
        line: UInt = #line
    ) {
        guard verifyRequestArgs.count > 0 else {
            return
        }
        
        XCTAssertEqual(
            verifyRequestArgs.count,
            1,
            file: file,
            line: line
        )
        
        XCTAssertEqual(
            verifyRequestArgs.first,
            arg,
            file: file,
            line: line
        )
    }
}

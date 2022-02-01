//
//  NetworkerSpy.swift
//  FormsAndNavigation-DojoTests
//
//  Created by Kauê Sales on 01/02/22.
//

import Foundation
@testable import FormsAndNavigation_Dojo

final class NetworkerSpy: NetworkerProtocol {
//    private(set) var
    func request(target: Networker.Target, completion: (Result<Bool, Error>) -> Void) {
        completion(.success(true))
    }
}

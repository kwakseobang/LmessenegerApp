//
//  DIContainer.swift
//  LMessenger
//
//  Created by 곽서방 on 7/17/24.
//

import Foundation

///  앱 외부에서 주입되어야하는 정보나 로직을 관리하는 컨테이너

class DIContainer: ObservableObject {
    //TODO: service
    var services: ServiceType
    
    init(services: ServiceType) {
        self.services = services
    }
}

extension DIContainer {
    static var stub: DIContainer {
        .init(services: StubService())
    }
}

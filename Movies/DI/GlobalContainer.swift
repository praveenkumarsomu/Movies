//
//  GlobalContainer.swift
//  Movies
//
//  Created by Praveen on 3/3/21.
//

import UIKit
import Swinject
/// Global container for the application. All global objects are register here
let globalContainer: Container = {
    let container = Container()
    /// Register Service Class
    container.register(Service.self) { resolver in
        ServiceImpl()
    }.inObjectScope(.container)
    /// Register search repository
    container.register(MoviesRepository?.self) { resolver in
        if let service = container.resolve(Service.self) {
            let moviesRepo = MoviesRepositoryImpl(service: service)
            return moviesRepo
        }
        return nil
    }
    /// Register main coordinator
    
    container.register(MainCoordinator?.self) { resolver in
        let rootViewController = UINavigationController()
        let mainCoordinator = MainCoordinator(navigationController: rootViewController)
        return mainCoordinator
    }
    return container
}()

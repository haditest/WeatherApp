//
//  Interfaces.swift
//  TestApp
//
//  Created by Hadi Faturrahman on 20/05/21.
//

import Foundation

enum RequestState<T> {
    case success(model: T)
    case loading
    case error(message: String?)
}

protocol ViewModelInterface: AnyObject {
    var view: ViewControllerInterface? { get }
    
    func getWeather(city: String)
}

protocol ViewControllerInterface: AnyObject {
    var viewModel: ViewModelInterface! { get }
    
    func updateView(state: RequestState<WeatherModel>)
}

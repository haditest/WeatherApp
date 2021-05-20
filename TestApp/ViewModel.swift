//
//  ViewModel.swift
//  TestApp
//
//  Created by Hadi Faturrahman on 20/05/21.
//

import Foundation

class ViewModel: ViewModelInterface {
    weak var view: ViewControllerInterface?
    let service = MainService()
    
    init(view: ViewControllerInterface) {
        self.view = view
    }
    
    func getWeather(city: String) {
        view?.updateView(state: .loading)
        service.get(params: ["q": city]) { [weak self] (result: Result<WeatherModel, Error>) in
            switch result {
            case .success(let model):
                self?.view?.updateView(state: .success(model: model))
            case .failure(let error):
                self?.view?.updateView(state: .error(message: error.localizedDescription))
            }
        }
    }
}

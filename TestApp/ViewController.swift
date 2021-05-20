//
//  ViewController.swift
//  TestApp
//
//  Created by Hadi Faturrahman on 20/05/21.
//

import UIKit

class ViewController: UIViewController {
    
    var viewModel: ViewModelInterface!
    
    @IBOutlet weak var mainImage: UIImageView!
    @IBOutlet weak var overlayView: UIView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    @IBOutlet weak var textField: UITextField!
    
    override func loadView() {
        super.loadView()
        viewModel = ViewModel(view: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textField.delegate = self
        overlayView.layer.opacity = 0.8
        overlayView.layer.cornerRadius = 12
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.getWeather(city: textField.text?.lowercased() ?? "")
    }

    func showLoading() {
        loadingIndicator.isHidden = false
        loadingIndicator.startAnimating()
        temperatureLabel.isHidden = true
        descriptionLabel.isHidden = true
    }
    
    func hideLoading() {
        loadingIndicator.isHidden = true
        loadingIndicator.stopAnimating()
        temperatureLabel.isHidden = false
        descriptionLabel.isHidden = false
    }
}

extension ViewController: ViewControllerInterface {
    
    func updateView(state: RequestState<WeatherModel>) {
        switch state {
        case .success(let model):
            hideLoading()
            let temp = Int(model.main.temp ?? 0)
            temperatureLabel.text = "\(temp)°C"
            descriptionLabel.text = model.weather.first?.description
            UIView.animate(withDuration: 1) {
                self.mainImage.image = UIImage(named: model.weather.first?.main?.rawValue ?? "")
            }
        case .loading:
            showLoading()
        case .error(let error):
            debugPrint(error as Any)
        }
    }
}

extension ViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        viewModel.getWeather(city: textField.text ?? "")
        return true
    }
}

//
//  ViewController.swift
//  App2
//
//  Created by BTCYZ465 on 18.07.2025.
//

import UIKit
import NetworkModule

protocol ViewModelProtocol {
    var view: ViewControllerProtocol? { get set }
    func fetch()
}

class ViewModel: ViewModelProtocol {
    weak var view: ViewControllerProtocol?
    
    func fetch() {
        Task {
            await NetworkModuleManager.fetchData()
            view?.reloadData()
        }
    }
}


protocol ViewControllerProtocol: AnyObject {
    func reloadData()
}

class ViewController: UIViewController, ViewControllerProtocol {
    
    var viewModel: ViewModelProtocol!
    
    init(viewModel: ViewModelProtocol) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
        self.viewModel.view = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue.withAlphaComponent(0.3)
    }
    
    // ViewControllerProtocol Protocols
    func reloadData() {
        /// reloaded
    }

}


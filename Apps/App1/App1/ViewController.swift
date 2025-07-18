//
//  ViewController.swift
//  App1
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
        // Do any additional setup after loading the view.
        view.backgroundColor = .gray
    }
    
    // ViewControllerProtocol Protocols
    func reloadData() {
        /// reloaded
    }

}


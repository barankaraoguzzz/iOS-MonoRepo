//
//  ViewController.swift
//  App2
//
//  Created by BTCYZ465 on 18.07.2025.
//

import UIKit
import NetworkModule
import DavinciKit

protocol ViewModelProtocol {
    var view: ViewControllerProtocol? { get set }
    func fetch()
}

class ViewModel: ViewModelProtocol {
    weak var view: ViewControllerProtocol?
    
    func fetch() {
        Task {
            await NetworkModuleManager.fetchData()
            await MainActor.run {
                view?.reloadData()
            }
            
        }
    }
}


protocol ViewControllerProtocol: AnyObject {
    func reloadData()
}

class DetailViewController: UIViewController, ViewControllerProtocol {
    var viewModel: ViewModelProtocol!
    
    private let headerLabel: DavinciLabel = {
        let lbl = DavinciLabel()
        lbl.style = .title
        lbl.text = "Detay"
        lbl.numberOfLines = 0
        return lbl
    }()
    
    private let bodyLabel: DavinciLabel = {
        let lbl = DavinciLabel()
        lbl.style = .body
        lbl.text = "Aşağıda detayları görebilirsin."
        lbl.numberOfLines = 0
        return lbl
    }()
    
    private let refreshButton: DavinciButton = {
        let btn = DavinciButton()
        btn.style = .secondary
        btn.setTitle("Yenile", for: .normal)
        return btn
    }()
    
    private let deleteButton: DavinciButton = {
        let btn = DavinciButton()
        btn.style = .destructive
        btn.setTitle("Sil", for: .normal)
        return btn
    }()
    
    init(viewModel: ViewModelProtocol) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
        self.viewModel.view = self
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        layoutComponents()
        setupActions()
        viewModel.fetch()
    }
    
    private func layoutComponents() {
        [headerLabel, bodyLabel, refreshButton, deleteButton].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            headerLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 24),
            headerLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            headerLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            bodyLabel.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 12),
            bodyLabel.leadingAnchor.constraint(equalTo: headerLabel.leadingAnchor),
            bodyLabel.trailingAnchor.constraint(equalTo: headerLabel.trailingAnchor),
            
            refreshButton.topAnchor.constraint(equalTo: bodyLabel.bottomAnchor, constant: 30),
            refreshButton.leadingAnchor.constraint(equalTo: bodyLabel.leadingAnchor),
            refreshButton.trailingAnchor.constraint(equalTo: bodyLabel.trailingAnchor),
            refreshButton.heightAnchor.constraint(equalToConstant: 48),
            
            deleteButton.topAnchor.constraint(equalTo: refreshButton.bottomAnchor, constant: 12),
            deleteButton.leadingAnchor.constraint(equalTo: bodyLabel.leadingAnchor),
            deleteButton.trailingAnchor.constraint(equalTo: bodyLabel.trailingAnchor),
            deleteButton.heightAnchor.constraint(equalTo: refreshButton.heightAnchor)
        ])
    }
    
    private func setupActions() {
        refreshButton.addTarget(self, action: #selector(didTapRefresh), for: .touchUpInside)
        deleteButton.addTarget(self, action: #selector(didTapDelete), for: .touchUpInside)
    }
    
    @objc private func didTapRefresh() {
        viewModel.fetch()
    }
    
    @objc private func didTapDelete() {
        // Silme işlemi; bu örnekte sadece UI güncellemesi
        deleteButton.setTitle("Silindi", for: .normal)
    }
    
    func reloadData() {
        // Veri geldiğinde UI güncellenebilir
        bodyLabel.text = "Yeni içerik yüklendi!"
    }
}

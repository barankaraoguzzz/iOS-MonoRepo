//
//  ViewController.swift
//  App1
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

final class ViewModel: ViewModelProtocol {
    weak var view: ViewControllerProtocol?
    
    
    func fetch() {
        Task { @Sendable in
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

class FormViewController: UIViewController, ViewControllerProtocol {
    var viewModel: ViewModelProtocol!
    
    private let nameField = DavinciTextField()
    private let emailField = DavinciTextField()
    
    private let submitButton = DavinciButton()
    private let cancelButton = DavinciButton()
    
    private let titleLabel: DavinciLabel = {
        let lbl = DavinciLabel()
        lbl.style = .title
        lbl.text = "Kaydol"
        lbl.textAlignment = .center
        return lbl
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
        setupLayout()
        setupActions()
        viewModel.fetch()
    }
    
    private func setupLayout() {
        [titleLabel, nameField, emailField, submitButton, cancelButton].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        nameField.placeholder = "Adınız"
        emailField.placeholder = "E‑posta"
        
        submitButton.style = .primary
        submitButton.setTitle("Gönder", for: .normal)
        
        cancelButton.style = .secondary
        cancelButton.setTitle("İptal", for: .normal)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            nameField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 30),
            nameField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            nameField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            nameField.heightAnchor.constraint(equalToConstant: 44),
            
            emailField.topAnchor.constraint(equalTo: nameField.bottomAnchor, constant: 16),
            emailField.leadingAnchor.constraint(equalTo: nameField.leadingAnchor),
            emailField.trailingAnchor.constraint(equalTo: nameField.trailingAnchor),
            emailField.heightAnchor.constraint(equalTo: nameField.heightAnchor),
            
            submitButton.topAnchor.constraint(equalTo: emailField.bottomAnchor, constant: 32),
            submitButton.leadingAnchor.constraint(equalTo: emailField.leadingAnchor),
            submitButton.trailingAnchor.constraint(equalTo: emailField.trailingAnchor),
            submitButton.heightAnchor.constraint(equalToConstant: 50),
            
            cancelButton.topAnchor.constraint(equalTo: submitButton.bottomAnchor, constant: 12),
            cancelButton.leadingAnchor.constraint(equalTo: submitButton.leadingAnchor),
            cancelButton.trailingAnchor.constraint(equalTo: submitButton.trailingAnchor),
            cancelButton.heightAnchor.constraint(equalTo: submitButton.heightAnchor)
        ])
    }
    
    private func setupActions() {
        submitButton.addTarget(self, action: #selector(didTapSubmit), for: .touchUpInside)
        cancelButton.addTarget(self, action: #selector(didTapCancel), for: .touchUpInside)
    }
    
    @objc private func didTapSubmit() {
        viewModel.fetch()
    }
    
    @objc private func didTapCancel() {
        // Example: alanları temizle veya ekrandan çık
        nameField.text = ""
        emailField.text = ""
    }
    
    func reloadData() {
        submitButton.setTitle("Tamamlandı ✓", for: .normal)
        cancelButton.setTitle("Kapat ✓", for: .normal)
    }
}

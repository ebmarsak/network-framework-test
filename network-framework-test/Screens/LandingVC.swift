//
//  LandingVC.swift
//  network-framework-test
//
//  Created by Emre Beytullah Marsak  on 1.05.2022.
//

import UIKit

class LandingVC: UIViewController {
    
    // props
    
    let questionLabel : UILabel = {
        let label = UILabel()
        label.text = "Tap CLIENT or SERVER to become one"
        return label
    }()
    
    let clientButton : UIButton = {
        let button = UIButton()
        button.setTitle("Client", for: .normal)
        button.backgroundColor = .systemOrange
        button.layer.cornerRadius = 10
        return button
    }()
    
    let serverButton : UIButton = {
        let button = UIButton()
        button.setTitle("Server", for: .normal)
        button.backgroundColor = .systemTeal
        button.layer.cornerRadius = 10
        return button
    }()
    
    // init app

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        configureLayout()
    }
    
    // UI config
    
    private func configureLayout() {
        view.addSubview(questionLabel)
        view.addSubview(clientButton)
        view.addSubview(serverButton)
        
        questionLabel.translatesAutoresizingMaskIntoConstraints = false
        clientButton.translatesAutoresizingMaskIntoConstraints = false
        serverButton.translatesAutoresizingMaskIntoConstraints = false
        
        clientButton.addTarget(self, action: #selector(pushClientVC), for: .touchUpInside)
        serverButton.addTarget(self, action: #selector(pushServerVC), for: .touchUpInside)

        NSLayoutConstraint.activate([
            questionLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            questionLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 150),
            
            clientButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            clientButton.topAnchor.constraint(equalTo: questionLabel.bottomAnchor, constant: 100),
            clientButton.widthAnchor.constraint(equalToConstant: 150),
            
            serverButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            serverButton.topAnchor.constraint(equalTo: clientButton.bottomAnchor, constant: 20),
            serverButton.widthAnchor.constraint(equalToConstant: 150),
        ])
    }
    
    @objc func pushClientVC() {
        navigationController?.pushViewController(ClientVC(), animated: true)
    }
    
    @objc func pushServerVC() {
        navigationController?.pushViewController(ServerVC(), animated: true)
    }
}

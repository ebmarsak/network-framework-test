//
//  ServerVC.swift
//  network-framework-test
//
//  Created by Emre Beytullah Marsak  on 1.05.2022.
//

import UIKit
import Network

class ServerVC: UIViewController {
    
    // create listener, queue
    var listener = try! NWListener(using: .tcp, on: 8888)
    var nwConnection : NWConnection
    var queue = DispatchQueue(label: "tcp server queue")
        
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        setupServer()
        
    }
    
    func setupServer() {
        
        // handle incoming connection
        listener.newConnectionHandler = { (newConnection) in
            newConnection.start(queue: self.queue)
        }
        
        listener.stateUpdateHandler = { (state) in
            switch(state) {
            case .ready:
                print("listening on port 8888")
            case .failed(let error):
                print("listener failed with error: \(error)")
            default:
                break
            }
        }
        
        listener.start(queue: queue)
    }
}

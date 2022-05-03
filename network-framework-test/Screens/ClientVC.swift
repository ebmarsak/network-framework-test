//
//  ClientVC.swift
//  network-framework-test
//
//  Created by Emre Beytullah Marsak  on 1.05.2022.
//

import UIKit
import Network

class ClientVC: UIViewController {
    
    var connection = NWConnection(host: NWEndpoint.Host("local"), port: 8888, using: .tcp)
    var queue = DispatchQueue(label: "tcp client queue")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        setupClient()
        sendInitialMessage()
}
    
    func setupClient() {
        
        // state update handler
        connection.stateUpdateHandler = { state in
            switch state {
            case .preparing:
                print("preparing")
            case .cancelled:
                print("cancelled")
            case .ready:
                print("ready to send")
                self.sendInitialMessage()
            case .failed(let error):
                print("Client connection failed with error: \(error)")
            default:
                break
            }
        }
        
        // start connection
        connection.start(queue: queue)
        print("client connection started on 8888")

    }
   
    func sendInitialMessage() {
        let message = "hello".data(using: .utf8)
        connection.send(content: message, completion: .contentProcessed({ error in
            if let error = error {
                print("Send error: \(error)")
            }
        }))
        connection.receiveMessage { completeContent, contentContext, isComplete, error in
            if completeContent != nil {
                print("got connected!")
            }
        }
            
    }
    
    func send(message: Data) {
        connection.send(content: message, completion: .contentProcessed({ error in
            if let error = error {
                print("send error: \(error)")
            }
            
        }))
        
    }
}

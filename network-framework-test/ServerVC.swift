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
    var nwConnection : NWConnection?
//    var queue = DispatchQueue(label: "tcp server queue")
        
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        stateUpdateHandler()
        newConnectionHandler()
        listener.start(queue: .main)
        
    }
    
    private func stateUpdateHandler() {     // update listener state changes
        listener.stateUpdateHandler = { (state) in
            switch(state) {
            case .ready:
                print("state: ready")
            case .failed(let error):
                print("listener failed with error: \(error)")
            default:
                break
            }
        }
    }
    
    private func newConnectionHandler() {    // handle incoming connection
        listener.newConnectionHandler = { (newConnection) in
            newConnection.start(queue: .main)
            
            self.nwConnection?.receive(minimumIncompleteLength: 1, maximumLength: 65536, completion: { content, contentContext, isComplete, error in
                if let data = content, !data.isEmpty {
                    let message = String(data: data, encoding: .utf8)
                    print(message)
//                    NSLog("did receive, data: %@", data as NSData)
                }
                print("veri geldi")
            })
        }
    }
}

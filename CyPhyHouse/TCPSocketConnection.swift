//
//  MessageObject.swift
//  CyPhyHouse
//
//  Created by Suki on 3/9/20.
//  Copyright © 2020 CSL. All rights reserved.
//

import Foundation
import CocoaAsyncSocket

class TCPSocketConnection: NSObject, GCDAsyncSocketDelegate {
    var tcpSocket: GCDAsyncSocket?
    
    init(host: String, port: UInt16) {
        super.init()

        self.tcpSocket = GCDAsyncSocket(delegate: self, delegateQueue: DispatchQueue.main)
        do {
            try tcpSocket?.connect(toHost: host, onPort: port, withTimeout: 5.0)
        } catch let error {
            print("Cannot open socket to \(host):\(port): \(error)")
        }
    }
    
    func socket(_ sock: GCDAsyncSocket, didConnectToHost host: String, port: UInt16) {
        print("SUCCESFULLY CONNECTED TO HOST")
        self.tcpSocket?.readData(toLength: 1024, withTimeout: 60.0, tag: 0)
    }
    
    func socket(_ sock: GCDAsyncSocket, didRead data: Data, withTag tag: Int) {
        self.tcpSocket?.readData(toLength: 1024, withTimeout: 60.0, tag: 0)
    }
    
    func send(_ data: Data) {
        self.tcpSocket?.write(data, withTimeout: 10, tag: 0)
    }
}


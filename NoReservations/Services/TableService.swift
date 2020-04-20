//
//  TableService.swift
//  NoReservations
//
//  Adapted from: https://medium.com/apple-developer-academy-federico-ii/multipeerconnectivity-swiftui-5faa62a611a9
//  by Evan Platzer on 4/18/20.
//  Copyright © 2020 Evan Platzer. All rights reserved.
//

import Foundation
import SwiftUI
import MultipeerConnectivity

protocol TableServiceDelegate {
    
    func guestDiscovered(
        manager: TableService,
        guestID: MCPeerID,
        guestName: String
    )
    
    func guestLost(manager: TableService, guestID: MCPeerID)
    
    func receivedInvitation(
        manager: TableService,
        hostName: String,
        invitationHandler: @escaping (Bool, MCSession?) -> Void
    )
    
    func peerChangedState(
        manager: TableService,
        peerID: MCPeerID,
        state: MCSessionState
    )
    
    //    Refactor to receive restaurant data
    func messageReceived(manager: TableService, message: String)
}

class TableService: NSObject, ObservableObject {
    
    private let TableServiceType = "NoReservations"
    
    private let peerId = MCPeerID(displayName: UIDevice.current.name)
    private let serviceBrowser: MCNearbyServiceBrowser
    private let serviceAdvertiser: MCNearbyServiceAdvertiser
    
    var delegate: TableServiceDelegate?
    
    lazy var session: MCSession = {
        let session = MCSession(
            peer: self.peerId,
            securityIdentity: nil,
            encryptionPreference: .required
        )
        session.delegate = self
        return session
    }()
    
    init(userName: String) {
        self.serviceBrowser = MCNearbyServiceBrowser(
            peer: peerId,
            serviceType: TableServiceType
        )
        self.serviceAdvertiser = MCNearbyServiceAdvertiser(
            peer: peerId,
            discoveryInfo: ["Name" : userName],
            serviceType: TableServiceType
        )
        super.init()
        self.serviceAdvertiser.delegate = self
        self.serviceBrowser.delegate = self
    }
    
    deinit {
        self.serviceAdvertiser.stopAdvertisingPeer()
        self.serviceBrowser.stopBrowsingForPeers()
    }
    
    func createTable() {
        NSLog("%@", "Table Service began browsing for peers")
        self.serviceBrowser.startBrowsingForPeers()
    }
    
    func closeTable() {
        self.serviceBrowser.stopBrowsingForPeers()
    }
    
    func searchForTable() {
        NSLog("%@", "Table service began advertising to peers")
        self.serviceAdvertiser.startAdvertisingPeer()
    }
    
    func stopSearchingForTable() {
        self.serviceAdvertiser.stopAdvertisingPeer()
    }
    
    func send(exchangeData: String){
        NSLog("%@", "sendData: \(exchangeData) to \(session.connectedPeers.count) peers,\(session.connectedPeers.self)")
        if session.connectedPeers.count > 0 {
            do {
                try self.session.send(
                    exchangeData.data(using: .utf8)!,
                    toPeers: session.connectedPeers,
                    with: .reliable
                )
            }
                
            catch let error {
                NSLog("%@", "Error for sending: \(error)")
            }
        }
    }
    
    func inviteGuest(guestID: MCPeerID, hostName: String) {
        self.serviceBrowser.invitePeer(
            guestID,
            to: self.session,
            withContext: hostName.data(using: .utf8), timeout: 10)
    }
}

extension TableService : MCNearbyServiceBrowserDelegate {
    
    func browser(_ browser: MCNearbyServiceBrowser, didNotStartBrowsingForPeers error: Error) {
        NSLog("%@", "didNotStartBrowsingForPeers: \(error)")
    }
    
    //    Update SelectGuestsView
    func browser(_ browser: MCNearbyServiceBrowser, foundPeer peerID: MCPeerID, withDiscoveryInfo info: [String : String]?) {
        NSLog("%@", "foundPeer: \(info?["Name"] ?? peerID.displayName)")
        self.delegate?.guestDiscovered(manager: self, guestID: peerID, guestName: info?["Name"] ?? peerID.displayName)
        //        browser.invitePeer(peerID, to: self.session, withContext: nil, timeout: 10)
    }
    
    func browser(_ browser: MCNearbyServiceBrowser, lostPeer peerID: MCPeerID) {
        NSLog("%@", "lostPeer: \(peerID)")
        self.delegate?.guestLost(manager: self, guestID: peerID)
    }
}

extension TableService : MCNearbyServiceAdvertiserDelegate {
    
    func advertiser(_ advertiser: MCNearbyServiceAdvertiser, didNotStartAdvertisingPeer error: Error) {
        NSLog("%@", "didNotStartAdvertisingPeer: \(error)")
    }
    
    func advertiser(_ advertiser: MCNearbyServiceAdvertiser, didReceiveInvitationFromPeer peerID: MCPeerID, withContext context: Data?, invitationHandler: @escaping (Bool, MCSession?) -> Void) {
        NSLog("%@", "didReceiveInvitationFromPeer \(peerID)")
        let hostName = String(decoding: context!, as: UTF8.self)
        self.delegate?.receivedInvitation(manager: self, hostName: hostName, invitationHandler: invitationHandler)
    }
}

extension TableService : MCSessionDelegate {
    
    func session(_ session: MCSession, peer peerID: MCPeerID, didChange state: MCSessionState) {
        NSLog("%@", "peer \(peerID) didChangeState: \(state.rawValue)")
        self.delegate?.peerChangedState(manager: self, peerID: peerID, state: state)
    }
    
    //    Update to receive restaurant data
    func session(_ session: MCSession, didReceive data: Data, fromPeer peerID: MCPeerID) {
        NSLog("%@", "didReceiveData: \(data)")
        let str = String(data: data, encoding: .utf8)!
        NSLog("%@", str)
        self.delegate?.messageReceived(manager: self, message: str)
    }
    
    func session(_ session: MCSession, didReceive stream: InputStream, withName streamName: String, fromPeer peerID: MCPeerID) {
        NSLog("%@", "didReceiveStream")
    }
    
    func session(_ session: MCSession, didStartReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, with progress: Progress) {
        NSLog("%@", "didStartReceivingResourceWithName")
    }
    
    func session(_ session: MCSession, didFinishReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, at localURL: URL?, withError error: Error?) {
        NSLog("%@", "didFinishReceivingResourceWithName")
    }
}

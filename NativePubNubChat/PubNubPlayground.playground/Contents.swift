//: Playground - noun: a place where people can play

import UIKit
import PubNub
import XCPlayground

extension PubNub {
    
    static func makePubNubClient(withUUID uuid: String) -> PubNub {
        let configuration = PNConfiguration(publishKey: "pub-c-daf7877d-2242-4a2a-b3be-c22c1d5e1a3d", subscribeKey: "sub-c-a8e24fb2-ef3b-11e6-b753-0619f8945a4f")
        configuration.uuid = uuid
        let client: PubNub = PubNub.clientWithConfiguration(configuration)
        return client
    }
    
}

class AppInstance: NSObject, PNObjectEventListener {
    let client: PubNub
    
    init(withClient client: PubNub) {
        self.client = client

        super.init()
        
        self.client.addListener(self)
    }
    
    // Handle new message from one of channels on which client has been subscribed.
    func client(_ client: PubNub, didReceiveMessage message: PNMessageResult) {
        
        // Handle new message stored in message.data.message
        if message.data.channel != message.data.subscription {
            
            // Message has been received on channel group stored in message.data.subscription.
        }
        else {
            
            // Message has been received on channel stored in message.data.channel.
        }
        
        print("Received message: \(message.data.message) on channel \(message.data.channel) " +
            "at \(message.data.timetoken) from \(message.data.publisher)")
        /*
        client.hereNowForChannel("global", withVerbosity: .UUID, completion: { (result, status) in
            guard let result = result else {
                return
            }
            
            if status == nil {
                print("\(result.data.uuids) are present")
                print("\(result.data.occupancy) are present")
            }
        })
        */
    }
    
    /*
    // New presence event handling.
    func client(_ client: PubNub, didReceivePresenceEvent event: PNPresenceEventResult) {
        
        // Handle presence event event.data.presenceEvent (one of: join, leave, timeout, state-change).
        if event.data.channel != event.data.subscription {
            
            // Presence event has been received on channel group stored in event.data.subscription.
        }
        else {
            
            // Presence event has been received on channel stored in event.data.channel.
        }
        
        if event.data.presenceEvent != "state-change" {
            
            print("\(event.data.presence.uuid) \"\(event.data.presenceEvent)'ed\"\n" +
                "at: \(event.data.presence.timetoken) on \(event.data.channel) " +
                "(Occupancy: \(event.data.presence.occupancy))");
        }
        else {
            
            print("\(event.data.presence.uuid) changed state at: " +
                "\(event.data.presence.timetoken) on \(event.data.channel) to:\n" +
                "\(event.data.presence.state)");
        }
    }
    */

    
    
}

var john = PubNub.makePubNubClient(withUUID: "John")
var appInstance = AppInstance(withClient: john)
appInstance.client.subscribeToChannels(["global"], withPresence: true)


var stew = PubNub.makePubNubClient(withUUID: "Stew")
var appInstance2 = AppInstance(withClient: stew)
appInstance2.client.subscribeToChannels(["global"], withPresence: true)


appInstance.client.publish("Hey I'm John", toChannel: "global") { (publishStatus) in
    if !publishStatus.isError {
        print("Message from \(john.uuid()) successful")
    } else {
        print("Error \(publishStatus.errorData)")
    }
}


appInstance2.client.hereNowWithCompletion { (globalHereNowResult, status) in
    guard let globalHereNowResult = globalHereNowResult else {
        return
    }
    
    if status == nil {
        print("\(globalHereNowResult.data.totalOccupancy) Total Occupied")
    }
}

XCPlaygroundPage.currentPage.needsIndefiniteExecution = true


//
//  BoardingPassInterfaceController.swift
//  AirAber
//
//  Created by David Szurma on 10/17/16.
//  Copyright © 2016 Mic Pringle. All rights reserved.
//

import WatchKit
import Foundation
import WatchConnectivity

class BoardingPassInterfaceController: WKInterfaceController {

  @IBOutlet var originLabel: WKInterfaceLabel!
  @IBOutlet var destinationLabel: WKInterfaceLabel!
  @IBOutlet var boardingPassImage: WKInterfaceImage!
  
  var flight: Flight? {
    didSet {
      if let _ = flight?.boardingPass {
        showBoardingPass()
      }
      
      if let flight = flight {
        originLabel.setText(flight.origin)
        destinationLabel.setText(flight.destination)
      }
    }
  }
  
  var session: WCSession? {
    didSet {
      if let session = session {
        session.delegate = self
        session.activate()
      }
    }
  }
  
  override func awake(withContext context: Any?) {
    super.awake(withContext: context)
    
    if let flight = context as? Flight { self.flight = flight }
    // Configure interface objects here.
  }
  
  override func didAppear() {
    super.didAppear()
    // 1
    if let flight = flight , flight.boardingPass == nil && WCSession.isSupported() {
      // 2
      session = WCSession.default()
      // 3
      session!.sendMessage(["reference": flight.reference], replyHandler: { (response) -> Void in
        // 4
        if let boardingPassData = response["boardingPassData"] as? NSData, let boardingPass = UIImage(data: boardingPassData as Data) {
          // 5
          flight.boardingPass = boardingPass
          
          DispatchQueue.main.async(execute: { () -> Void in
            self.showBoardingPass()
          })
        }
        }, errorHandler: { (error) -> Void in
          // 6
          print(error)
      })
    }
  }
  
  private func showBoardingPass() {
    boardingPassImage.stopAnimating()
    boardingPassImage.setWidth(120)
    boardingPassImage.setHeight(120)
    boardingPassImage.setImage(flight?.boardingPass)
  }

}

extension BoardingPassInterfaceController: WCSessionDelegate {

  public func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
    
  }

  
}

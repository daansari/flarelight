//
//  BackgroundOperation.swift
//  Pods
//
//  Created by Marcus Kida on 13/12/2015.
//
//

import UIKit

class BackgroundOperation: NSBlockOperation {

    let automaticallyEndsBackgroundTask: Bool
    var backgroundTaskIdentifier: UIBackgroundTaskIdentifier
    
    override init() {
        automaticallyEndsBackgroundTask = true
        backgroundTaskIdentifier = UIBackgroundTaskInvalid
    }
    
    init(automaticallyEndsBackgroundTask: Bool) {
        self.automaticallyEndsBackgroundTask = automaticallyEndsBackgroundTask
        backgroundTaskIdentifier = UIBackgroundTaskInvalid
    }
    
    func startBackgroundTask() {
        self.backgroundTaskIdentifier = UIApplication.sharedApplication().beginBackgroundTaskWithExpirationHandler {
            self.endBackgroundTask()
        }
    }
    
    func endBackgroundTask() {
        if self.backgroundTaskIdentifier != UIBackgroundTaskInvalid {
            UIApplication.sharedApplication().endBackgroundTask(self.backgroundTaskIdentifier)
            self.backgroundTaskIdentifier = UIBackgroundTaskInvalid
        }
    }
    
    override func addExecutionBlock(block: () -> Void) {
        super.addExecutionBlock { [unowned self] in
            self.startBackgroundTask()
            block()
            if self.automaticallyEndsBackgroundTask {
                self.endBackgroundTask()
            }
        }
    }
}

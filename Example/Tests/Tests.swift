import UIKit
import XCTest
import CoreLocation
import Flarelight

class Tests: XCTestCase, FlarelightDelegate {
    
    var sut: Flarelight?
    
    override func setUp() {
        super.setUp()
        sut = Flarelight(delegate: self)
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func flarelight(client: Flarelight, didUpdateLocation: CLLocation?) {
        //TODO: Implement tests
    }
    
    func flarelight(client: Flarelight, didChangeAuthorizationStatus: CLAuthorizationStatus) {
        //TODO: Implement tests
    }
}

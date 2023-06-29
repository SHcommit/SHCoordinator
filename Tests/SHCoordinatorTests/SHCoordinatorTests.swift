//
//  SHCoordinatorTests.swift
//  
//
//  Created by 양승현 on 2023/06/29.
//

#if os(iOS)
import XCTest
@testable import SHCoordinator

final class SHCoordinatorTests: XCTestCase {
  var parent: FlowCoordinator!
  
  override func setUp() {
    super.setUp()
    parent = MockParentCoordinator()
  }
  
  override func tearDown() {
    parent = nil
    super.tearDown()
  }
  
  func testSet_WhenAppendChildCoordinatorUsingSet_ReturnSuccess() {
    // Arrange
    let child = MockChildCoordinator()
    // Act
    child.set { coordinator in
      coordinator.parent = self.parent
      self.parent.addChild(with: coordinator)
    }
    // Assert
    XCTAssertNotNil(child.parent)
    XCTAssertTrue(child.parent === parent)
    XCTAssertTrue(parent.child.contains(where: {$0 === child}))
  }
  
  func testRemoveSelf_WhenRemoveChildCoordinatorFromParentCoordinator_ReturnFailure() {
    let child = MockChildCoordinator()
    // Arrange
    parent.addChild(with: child)
    // Act
    child.removeSelf(from: parent)
    // Assert
    XCTAssertFalse(parent.child.contains(where: {$0 === child}))
  }
  
  func testFinishMethod_WhenChildCoordinatorWillFinish_ReturnFailure() {
    // Act
    let child = MockChildCoordinator()
    // Assert
    parent.addChild(with: child)
    child.finish()
    // Assert
    XCTAssertFalse(parent.child.contains(where: {$0 === child}))
  }
  
  func testIsTypeOfCoordinator_WhenGivenCoordinatorTypeIsChild_ReturnFailure() {
    // Act
    let isTyepOfCoordinator = parent.isCoordinator(
      ofType: MockChildCoordinator.self)
    // Assert
    XCTAssertFalse(isTyepOfCoordinator)
  }
  
  func testIsTypeOfCoordinator_WhenGivenCoordinatorTypeIsParent_ReturnSuccess() {
    // Act
    let isTyepOfCoordinator = parent.isCoordinator(
      ofType: MockParentCoordinator.self)
    // Assert
    XCTAssertTrue(isTyepOfCoordinator)
  }
}
#endif

//
//  File.swift
//
//
//  Created by 양승현 on 2023/06/29.
//

#if os(iOS)
import UIKit
@testable import SHCoordinator

final class MockParentCoordinator: FlowCoordinator {
  var parent: FlowCoordinator!
  var child: [FlowCoordinator] = []
  let presenter: UINavigationController
  var viewController: UIViewController!
  
  init() {
    presenter = UINavigationController()
  }
  
  func start() {
    // Mock implementation of start method
    print("MockFlowCoordinator: Start")
  }
}
#endif


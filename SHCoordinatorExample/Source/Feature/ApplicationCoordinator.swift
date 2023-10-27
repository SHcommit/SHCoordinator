//
//  ApplicationCoordinator.swift
//  SHCoordinatorExample
//
//  Created by 양승현 on 2023/09/18.
//

import UIKit
import SHCoordinator
 
final class ApplicationCoordinator: FlowCoordinator {
  // MARK: - Properties
  var parent: FlowCoordinator?
  var child: [FlowCoordinator] = []
  var presenter: UINavigationController?
  var viewController: UIViewController?
  private let window: UIWindow
  
  init(window: UIWindow) {
    self.window = window
  }
  
  init(presenter: UINavigationController?) {
    fatalError()
  }
  
  func start() {
    gotoMainPage()
  }
  
  func finish() {
    NSLog("DEBUG: App clided.")
  }
}

extension ApplicationCoordinator {
  func gotoMainPage() {
    let mainCoordinator = MainCoordinator(presenter: nil)
    window.rootViewController = mainCoordinator.presenter
    addChild(with: mainCoordinator)
  }
}

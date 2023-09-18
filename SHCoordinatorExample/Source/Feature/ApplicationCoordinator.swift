//
//  ApplicationCoordinator.swift
//  SHCoordinatorExample
//
//  Created by 양승현 on 2023/09/18.
//

import UIKit
import SHCoordinator
 
final class ApplicationCoordinator: FlowCoordinator {
  var parent: FlowCoordinator!
  var child: [FlowCoordinator] = []
  var presenter: UINavigationController!
  weak var viewController: UIViewController?
  private let window: UIWindow
  
  init(window: UIWindow) {
    self.window = window
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

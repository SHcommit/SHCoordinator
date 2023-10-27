//
//  MainCoordinator.swift
//  SHCoordinatorExample
//
//  Created by 양승현 on 2023/09/18.
//

import UIKit
import SHCoordinator

protocol MainCoordinatorDelegate: FlowCoordinatorDelegate {
  func gotoSubPage()
}

final class MainCoordinator: FlowCoordinator {
  // MARK: - Properties
  var parent: FlowCoordinator?
  var child: [SHCoordinator.FlowCoordinator] = []
  var presenter: UINavigationController?
  var viewController: UIViewController?
  
  init(presenter: UINavigationController?) {
    let viewController = MainViewController()
    self.viewController = viewController
    self.presenter = .init(rootViewController: viewController)
    viewController.coordinator = self
  }
  
  func start() {
    guard let viewController else { return }
    presenter?.viewControllers = [viewController]
  }
  
  deinit {
    print("deinitt")
  }
}

extension MainCoordinator: MainCoordinatorDelegate {
  func gotoSubPage() {
    let childCoordinator = SubCoordinator(presenter: presenter)
    addChild(with: childCoordinator)
  }
}

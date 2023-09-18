//
//  MainCoordinator.swift
//  SHCoordinatorExample
//
//  Created by 양승현 on 2023/09/18.
//

import UIKit
import SHCoordinator

protocol MainCoordinatorDelegate: AnyObject {
  func finish()
  func gotoSubPage()
}

final class MainCoordinator: FlowCoordinator {
  var parent: SHCoordinator.FlowCoordinator!
  var child: [SHCoordinator.FlowCoordinator] = []
  var presenter: UINavigationController!
  var viewController: UIViewController!
  
  init(presenter: UINavigationController!) {
    let vc = MainViewController()
    self.presenter = .init(rootViewController: vc)
    vc.coordinator = self
    viewController = vc
  }
  
  func start() {
    presenter.viewControllers = [viewController]
  }
  
  deinit {
    print("deinitt")
  }
}

extension MainCoordinator: MainCoordinatorDelegate {
  func gotoSubPage() {
    print(presenter.viewControllers.count)
    let childCoordinator = SubCoordinator(presenter: presenter)
    addChild(with: childCoordinator)
  }
}

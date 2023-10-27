//
//  SubCoordinator.swift
//  SHCoordinatorExample
//
//  Created by 양승현 on 2023/09/18.
//

import UIKit
import SHCoordinator

protocol SubCoordinatorDelegate: FlowCoordinatorDelegate {
  
}

final class SubCoordinator: NSObject, FlowCoordinator {
  var parent: FlowCoordinator?
  var child: [FlowCoordinator] = []
  var presenter: UINavigationController?
  var viewController: UIViewController?

  init(presenter: UINavigationController?) {
    super.init()
    self.presenter = presenter
    let viewController = SubViewController()
    self.viewController = viewController
    viewController.coordinator = self
    self.presenter?.delegate = self
  }
  
  func start() {
    guard let viewController else { return }
    presenter?.pushViewController(viewController, animated: true)
  }
  
  deinit {
    print("\(Self.self) deinit")
  }
}

// MARK: - SubCoordinatorDelegate
extension SubCoordinator: SubCoordinatorDelegate {
  
}

// MARK: - UINavigationControllerDelegate
extension SubCoordinator: UINavigationControllerDelegate {
  func navigationController(
    _ navigationController: UINavigationController,
    didShow viewController: UIViewController,
    animated: Bool
  ) {
    handlePopViewController(navigationController, didShow: viewController, animated: animated)
  }
}

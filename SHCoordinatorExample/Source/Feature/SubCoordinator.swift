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
    
    /// 네비게이션 컨트롤러에서 pop되는 뷰 컨트롤러 타입이 sub coordinator에서 관리하는 SubViewController.self가 맞는지 type전달합니다.
    isTargetViewController = { [weak self] someViewController in
      return self?.checkViewController(
        someViewController, 
        ofType: SubViewController.self) ?? false
    }
    self.presenter?.delegate = self
  }
  
  func start() {
    let vc = SubViewController()
    vc.coordinator = self
    presenter?.pushViewController(vc, animated: true)
  }
  
  deinit {
    print("sub deinit")
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

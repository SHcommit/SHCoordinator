//
//  SubCoordinator.swift
//  SHCoordinatorExample
//
//  Created by 양승현 on 2023/09/18.
//

import UIKit
import SHCoordinator

protocol SubCoordinatorDelegate: AnyObject {
  func finish()
}

final class SubCoordinator: FlowCoordinator {
  var parent: FlowCoordinator!
  var child: [FlowCoordinator] = []
  var presenter: UINavigationController!
  
  init(presenter: UINavigationController?) {
    self.presenter = presenter
  }
  
  func start() {
    let vc = SubViewController()
    vc.coordinator = self
    presenter.pushViewController(vc, animated: true)
  }
  
  deinit {
    print("sub deinit")
  }
}

extension SubCoordinator: SubCoordinatorDelegate {}

final class SubViewController: UIViewController {
  weak var coordinator: SubCoordinatorDelegate?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .yellow
    setLabel()
  }
  
  deinit {
    coordinator?.finish()
  }
  
  private func setLabel() {
    let screenWidth = Int(UIScreen.main.bounds.width)
    let width = 200
    let rect = CGRect(x: (screenWidth-width)/2, y: 300, width: width, height: 100)
    let lb = UILabel(frame: rect)
    lb.textAlignment = .center
    lb.text = "Sub View Controller"
    view.addSubview(lb)
  }
}

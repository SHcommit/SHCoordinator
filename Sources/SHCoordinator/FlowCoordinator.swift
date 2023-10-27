//
//  FlowCoordinator.swift
//  SHCoordinator
//
//  Created by 양승현 on 2023/06/28.
//

#if os(iOS)
import UIKit

public protocol FlowCoordinator: FlowCoordinatorDelegate {
  // MARK: - Properties
  var parent: FlowCoordinator? { get set }
  var child: [FlowCoordinator] { get set }
  var presenter: UINavigationController? { get }
  var isTargetViewController: ((UIViewController) -> Bool)? { get set }
  
  init(presenter: UINavigationController?)
  
  func start()
}
#endif

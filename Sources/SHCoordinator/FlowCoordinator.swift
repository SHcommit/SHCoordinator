//
//  FlowCoordinator.swift
//  SHCoordinator
//
//  Created by 양승현 on 2023/06/28.
//

#if os(iOS)
import UIKit

public protocol FlowCoordinator: AnyObject {
  // MARK: - Properties
  var parent: FlowCoordinator! { get set }
  var child: [FlowCoordinator] { get set }
  var presenter: UINavigationController! { get }
  
  func start()
}

extension FlowCoordinator {
  /// If a ChildCoordinator needs to be deallocated when a viewController is about to disappear,
  /// it is important to call the **finish** method on the weakly held coordinator in the deinit of the viewController to prevent memory leaks.
  ///
  /// In the child coordinator, the parent coordinator is holding the child coordinator instance as a chid array instance.
  /// That's why instances can be maintained so that the child Coordinator can switch between multiple screens.
  /// When it is deleted, it must be removed from the parent holding its object.
  ///
  /// Here is an example:
  ///
  /// ```
  /// class MyViewController: UIViewController {
  ///   weak var coordinator: ChildCoordinator?
  ///
  ///   deinit {
  ///     coordinator?.finish()
  ///   }
  /// }
  /// ```
  public func finish() {
    guard let parent = parent else {
      print("DEBUG: current coordinator is root coordinator")
      return
    }
    removeSelf(from: parent)
  }
}
#endif

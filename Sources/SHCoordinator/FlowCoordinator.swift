//
//  FlowCoordinator.swift
//  SHCoordinator
//
//  Created by 양승현 on 2023/06/28.
//

#if os(iOS)
import UIKit

protocol FlowCoordinator: AnyObject {
  // MARK: - Properties
  var parent: FlowCoordinator! { get set }
  var child: [FlowCoordinator] { get set }
  var presenter: UINavigationController { get }
  var viewController: UIViewController! { get set }
  
  // MARK: - Helpers
  func start()
}

extension FlowCoordinator {
  
  /// If a ChildCoordinator needs to be deallocated when a viewController is about to disappear,
  /// it is important to call the **finish** method on the weakly held coordinator in the viewWillDisappear(_:) or viewDidDisappear(_:) method of the viewController to prevent memory leaks.
  ///
  /// In the child coordinator, the parent coordinator is holding the child coordinator instance as a chid array instance.
  /// That's why instances can be maintained so that the child Coordinator can switch between multiple screens.
  /// When it is deleted, it must be removed from the parent holding its object.
  ///
  /// Here is an example in English:
  ///
  /// ```
  /// class MyViewController: UIViewController {
  ///   weak var coordinator: ChildCoordinator?
  ///
  ///   override func viewWillDisappear(_ animated: Bool) {
  ///     super.viewWillDisappear(animated)
  ///     //
  ///     coordinator?.finish()
  ///   }
  /// }
  /// ```
  func finish() {
    guard let parent = parent else {
      print("DEBUG: current coordinator is root coordinator")
      return
    }
    removeSelf(from: parent)
  }
}
#endif
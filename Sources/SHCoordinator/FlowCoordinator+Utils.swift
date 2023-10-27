//
//  FlowCoordinator+Utils.swift
//  SHCoordinator
//
//  Created by 양승현 on 2023/06/28.
//

#if os(iOS)
import UIKit

// MARK: - Convenience coordinator setting
extension FlowCoordinator {
  /// Child coordinator convenience init + setting!!
  ///
  /// Example:
  /// ```
  /// MainCoordinator(apiClient: apiClient).set {
  ///   $0.partentCoordinator = self
  ///   addChild($0)
  ///   ...
  ///   $0.start()
  /// }
  /// ```
  public func set(apply: @escaping (Self) -> Void) {
    apply(self)
  }
}

// MARK: - Manage child coordinator
extension FlowCoordinator {
  
  /// If new ViewController will push from presenter(UINavigationController),
  /// you must **append** VC's coordinator from **parent coordinator**
  /// Then, start child coordinator : ]
  ///
  /// - Param with coordinator : parent's child coordinator
  public func addChild<Coordinator>(with childCoordinator: Coordinator) where Coordinator: FlowCoordinator {
    childCoordinator.set { [weak self] in
      self?.child.append($0)
      $0.parent = self
      $0.start()
    }
  }
  
  /// When ViewController deallocate from navigation controller's stack,
  /// the coordinator instance that manages the transition of the current view controller must be removed from the holding parent coordinator.
  ///
  /// - Param from parent : The parent coordinator of the child coordinator to be deleted
  ///
  /// Notes:
  ///  1. When a particular ViewController is deinit, it must use this method to remove itself from the child array owned by its parent.
  ///  Otherwise, the object that handles the child coordinator of the parent coordinator continues to hold unnecessary coordinator instances. If so, a memory leak occurs.
  public func removeSelf(from parent: FlowCoordinator) {
    guard let idx = parent.child.firstIndex(where: {$0===self}) else {
      print("DEBUG: Delete target \(self) is not available in child coordinators")
      return
    }
    self.removeAllChild()
    parent.child.remove(at: idx)
  }
  
  public func removeAllChild() {
    child.removeAll()
  }
}

// MARK: - Validation
extension FlowCoordinator {
  
  /// Check whether a given coordinator is of a specific type <T>
  ///
  /// - Param coordinator : check coordinator's type
  /// - Param ofType : The type <T> or the subtype that we want to check against
  ///
  /// Example:
  /// ```
  /// let myCoordinator = MyCoordinator()
  ///  if myCoordinator.isCoordinator(ofType: SomeCoordinator.self) {
  ///    // my coordinator type is some coordinator
  ///  }
  /// ```
  public func isCoordinator<T: FlowCoordinator>(
    ofType type: T.Type
  ) -> Bool {
    return self is T
  }
  
  public func checkViewController<TargetViewController: UIViewController>(
    _ specificViewController: UIViewController,
    ofType type: TargetViewController.Type
  ) -> Bool {
    return specificViewController is TargetViewController
  }
}

// MARK: - Manage from UINavigationControllerDelegate
public extension FlowCoordinator where Self: UINavigationControllerDelegate {
  /// 특정 Coordinator에서 자동으로 네비게이션 스택에서 pop될때, 코디네이터가 관리하는 뷰인지 여부에 따라 자동으로 finish를 호출할 수 있는 함수입니다.
  func handlePopViewController(
    _ navigationController: UINavigationController,
    didShow viewController: UIViewController,
    animated: Bool
  ) {
    guard let poppedViewController = navigationController
      .transitionCoordinator?
      .viewController(forKey: .from)
    else { return }
    guard
      let isTargetViewController,
      isTargetViewController(poppedViewController)
    else { return }
    if isTargetViewController(poppedViewController) {
      finish()
    }
  }
}
#endif

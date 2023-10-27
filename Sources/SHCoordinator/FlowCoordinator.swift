//
//  FlowCoordinator.swift
//  SHCoordinator
//
//  Created by 양승현 on 2023/06/28.
//

#if os(iOS)
import UIKit

public protocol FlowCoordinator: AnyObject, FlowCoordinatorDelegate {
  // MARK: - Properties
  var parent: FlowCoordinator? { get set }
  var child: [FlowCoordinator] { get set }
  var presenter: UINavigationController? { get }
  
  init(presenter: UINavigationController?)
  
  func start()
}

// MARK: - FlowCoordinatorDelegate
/// ACoordinator -> BCoordinator일때, Bcoordinator에서 ACoordinator로 되돌아가는 경우, 반드시 finish함수를 호출해야합니다. 그렇지 않을 경우
/// 메모리 릭이 발생됩니다.
///
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
  ///
  /// /// 이전 화면으로 되돌아 갈 경우 PopViewController를 호출하지 않았을 때
  /// class MyViewController: UIViewController {
  ///   weak var coordinator: ChildCoordinator?
  ///
  ///   func gotoPrevPage() {
  ///       coordinator?.finish(with: true)
  ///   }
  /// }
  /// ```
  public func finish(withAnimated animated: Bool = true) {
    finish()
    presenter?.popViewController(animated: animated)
  }
  
  /// 상위 코디네이터로 (상위화면) 전환해야 하는 경우 presenter?.popViewController(animated:)를 직접 호춣했을 때, 해당 코드 scpoe안에서 이 함수를 호출해야 합니다.
  /// 예를들어 BaseViewController를 상속한 커스텀뷰인데, 네비바 뒤로가기 버튼에 자동으로 navigationController.popViewController(animated:) 함수를 호출하는 경우
  /// 해당 커스텀 컨트롤러의 뒤로가기 함수를 오버라이드 해서 coordinator.finish()이 함수를 호출해야 합니다.
  public func finish() {
    guard let parent = parent else {
      print("DEBUG: current coordinator is root coordinator")
      return
    }
    removeSelf(from: parent)
  }
}
#endif

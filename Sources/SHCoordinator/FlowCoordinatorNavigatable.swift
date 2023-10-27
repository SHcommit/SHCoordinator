//
//  FlowCoordinatorNavigatable.swift
//  SHCoordinator
//
//  Created by 양승현 on 10/27/23.
//

#if os(iOS)
import UIKit

/// 코디네이터에서 UINavigationControllerDelegate 관련된 프로토콜입니다.
///
/// - Param viewController : UIViewController
///     이를 준수하는 코디네이터 객체에서 start()에서 호출하는 뷰 컨트롤러가 와야 합니다.
///
/// Notes:
/// 1. FlowCoordinatorNavigatable을 준수하는 코디네이터가 FlowCoordinatorDelegate, UINavigationControllerDelegate를 준수할 경우
///     handlePopViewController(_:didShow:animated:)를 호출할 수 있습니다.
///
///   만약 네비게이션 컨트롤러가 popVIewController를 호출할때, 네비게이션 스택에서 pop되는 viewController를 관리하는 코디네이터의 finish()나 finish(withAnimated:)를
///     호출하지 않을 경우 Memory Leak이 발생됩니다. 뷰 컨트롤러는 화면에서 사라지지만 해당 코디네이터는 상위 코디네이터로인해 강한 참조로 메모리에 계속 유지중이기 때문입니다.
///
///   이 경우 네비게이션 컨트롤러가  popViewController 호출하는 경우, 해당 scope내에 finish(), finish(withAnimated:)를 명시적으로 호출해서 상위 코디네이터로부터 해제시켜야  합니다.
///
///   만약 코디네이터가 위 두 프로토콜을 준수한다면, UINavigationControllerDelegate's navigationController(_:didShow:animated:) 메서드를 구현할 때,
///     handlePopViewControlelr(_:didShow:animated:)를 호출한다면, 현재 네비게이션 스택에서 pop되는 topViewController가 코디네이터에서 관리하는 주요 뷰 컨트롤러일때,
///       해당 뷰 컨트롤러가 네비게이션 스택에서의 강한참조를 해제시키고, 해당 뷰컨트롤러를 참조중인 코디네이터가 finish()를 호출하며, 코디네이터 인스턴스도 해제됨으로,
///       코디네이터 내부 프로퍼티인 viewController 인스턴스도 **자동**으로 해제됩니다.
///         단, 위 경우는 네비게이션 스택에서 viewController를 strong reference로 참조, specific coordinaotr에서 내부 프로퍼티로 소유하며 strong reference를 띄고 있을 경우입니다.
///
///         예외적으로 해제가 되지 않는 경우는 아래 포스트에 정리했습니다.
///         포스트 URL:  https://dev-with-precious-dreams.tistory.com/275#:~:text=%EC%83%81%EB%8B%B9%ED%9E%88%20%EC%BB%A4%EC%A7%88%20%EA%B2%83%EC%9E%85%EB%8B%88%EB%8B%A4.-,%ED%94%84%EB%A1%9C%EC%A0%9D%ED%8A%B8,-runtime%20%EB%95%8C%20strong
///
/// Examples:
/// ```
/// ACoordinator: NSObject, FlowCoordinatorDelegate, UINavigationControllerDelegate {
///   let viewController: UIViewController? = AViewController()
///   ...
///   func navigationController(
///     _ navigationController: UINavigationController:,
///     didShow: viewController: UIViewController,
///     animated: Bool
///   ) {
///     handlePopViewController(navigationController, viewController, animated)
///   }
/// ```
///
public protocol FlowCoordinatorNavigatable {
  var viewController: UIViewController? { get }
}

// MARK: - Utils
public extension FlowCoordinatorNavigatable
where Self: FlowCoordinatorDelegate,
      Self: UINavigationControllerDelegate {
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
    if self.viewController === poppedViewController {
      finish()
    }
  }
}
#endif

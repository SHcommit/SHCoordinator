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
  var viewController: UIViewController? { get }
  
  /// 뷰 컨트롤러의 popViewController가 호출될 때, popViewController를 관리하는 코디네이터 또한 제거되야하는 경우
  /// popViewController 호출 scope내에서 coordinator.finish() 또는 coordinaotr.finish(withAnimated:)를 호출하지 않는다면,
  /// memory leak가 발생됩니다.
  ///
  /// 이 클로저를 통해 naivgationController의 popViewController가 특정 코디네이터가 관리하는 구체타입의 뷰 컨트롤러인지 캐스팅을 통해 확인하기 위해 사용할 수 있습니다.
  ///
  /// checkViewController(_:ofType:) 을 통해 확인하는 로직을 이 클로저에 작성 후 UINavigationControllerDelegate를 준수한 특정 코디네이터는
  ///   navigationController(_:didShow:animated:)를 준수한 후에 handlePopViewController(_:didShow:,animated:)를 호출해야 합니다.
  /// 이 경우 자동으로 popViewController가 호출될 때 현재 pop되는 뷰 컨트롤러를 관리하는 특정 코디네이터 또한 finish()가 호출되며 상위 코디네이터의 자식 객체로부터 해제되며 메모리 release됩니다.
  // var isTargetViewController: ((UIViewController) -> Bool)? { get set }
  
  init(presenter: UINavigationController?)
  
  func start()
}
#endif

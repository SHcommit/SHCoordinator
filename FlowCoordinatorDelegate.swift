//
//  FlowCoordinatorDelegate.swift
//  SHCoordinator
//
//  Created by 양승현 on 10/27/23.
//

#if os(iOS)
import Foundation

public protocol FlowCoordinatorDelegate: AnyObject {
  /// 현재 보여지는 coordinator의 인스턴스를 제거하기 위해선 이 함수를 호출해야 합니다.
  /// 특정 흐름에 의해 뒤로가야하는 경우일떄, navigationController.popViewController(animated:)를 호출하지 않은 경우 이 함수를 호출해야 합니다.
  func finish(withAnimated animated: Bool)
  
  /// 현재 보여지는 coordinator의 인스턴스를 제거하기 위해서 이 함수를 호출해야합니다.
  /// 만약 baseViewController에서 네비게이션 백 버튼을 추가해둘 경우 이 함수를 호출해야합니다.
  func finish()
}
#endif

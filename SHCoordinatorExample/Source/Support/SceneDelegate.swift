//
//  SceneDelegate.swift
//  SHCoordinatorExample
//
//  Created by 양승현 on 2023/06/29.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
  func scene(
    _ scene: UIScene,
    willConnectTo session: UISceneSession,
    options connectionOptions: UIScene.ConnectionOptions
  ) {
    guard let windowScene = (scene as? UIWindowScene) else { return }
    let window = UIWindow(windowScene: windowScene)
    let appCoordinator = ApplicationCoordinator(window: window)
    appCoordinator.start()
    window.makeKeyAndVisible()
  }
}

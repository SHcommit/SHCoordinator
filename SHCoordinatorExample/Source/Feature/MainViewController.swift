//
//  MainViewController.swift
//  SHCoordinatorExample
//
//  Created by 양승현 on 2023/09/18.
//

import UIKit
import SHCoordinator

class MainViewController: UIViewController {
  weak var coordinator: MainCoordinatorDelegate?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setButton()
    view.backgroundColor = .white
  }
  
  private func setButton() {
    let screenWidth = UIScreen.main.bounds.width
    let buttonWidth = 200
    let rect = CGRect(
      x: Int((screenWidth - 200)/2),
      y: 300,
      width: buttonWidth,
      height: 100)
    let btn = UIButton(frame: rect)
    btn.addTarget(self, action: #selector(didTapNextButton), for: .touchUpInside)
    btn.setTitle("NextPage", for: .normal)
    btn.backgroundColor = .systemPink
    btn.titleLabel?.font = .systemFont(ofSize: 20)
    btn.layer.cornerRadius = 8
    view.addSubview(btn)
  }
  
  @objc func didTapNextButton() {
    coordinator?.gotoSubPage()
  }
}

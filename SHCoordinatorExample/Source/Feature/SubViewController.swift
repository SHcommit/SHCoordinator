//
//  SubViewController.swift
//  SHCoordinatorExample
//
//  Created by 양승현 on 2023/09/18.
//

import UIKit

final class SubViewController: UIViewController {
  weak var coordinator: SubCoordinatorDelegate?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .yellow
    setLabel()
  }
  
  private func setLabel() {
    let screenWidth = Int(UIScreen.main.bounds.width)
    let width = 200
    let rect = CGRect(x: (screenWidth-width)/2, y: 300, width: width, height: 100)
    let lb = UILabel(frame: rect)
    lb.textAlignment = .center
    lb.text = "Sub View Controller"
    view.addSubview(lb)
  }
  
  deinit {
    print("\(Self.self) deinit")
  }
}

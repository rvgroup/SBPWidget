//
//  HalfModalTransition.swift
//  SBPWidget
//
//  Created by Mykola Hordynchuk on 6/9/19.
//  Copyright © 2019 Mykola Hordynchuk. All rights reserved.
//

import UIKit

protocol TransitionProtocol: class {
  func open(_ viewController: UIViewController, from parent: UIViewController?, completion: VoidClosure?)
  func close(_ viewController: UIViewController?, completion: VoidClosure?)
}

class HalfModalTransition: NSObject {
  private var isAnimated: Bool = true
  private var modalTransitionStyle: UIModalTransitionStyle
  private var modalPresentationStyle: UIModalPresentationStyle
  
  init(isAnimated: Bool = true,
       modalTransitionStyle: UIModalTransitionStyle = UIModalTransitionStyle.coverVertical,
       modalPresentationStyle: UIModalPresentationStyle = UIModalPresentationStyle.custom) {
    self.isAnimated = isAnimated
    self.modalTransitionStyle = modalTransitionStyle
    self.modalPresentationStyle = modalPresentationStyle
  }
}


// MARK: - Transition
extension HalfModalTransition: TransitionProtocol {
  func open(_ viewController: UIViewController, from parent: UIViewController?, completion: VoidClosure? = nil) {
    viewController.transitioningDelegate = self
    viewController.modalTransitionStyle = modalTransitionStyle
    viewController.modalPresentationStyle = modalPresentationStyle
    parent?.present(viewController, animated: isAnimated, completion: completion)
  }
  
  func close(_ viewController: UIViewController?, completion: VoidClosure? = nil) {
    viewController?.dismiss(animated: isAnimated, completion: completion)
  }
}


// MARK: - UIViewControllerTransitioningDelegate
extension HalfModalTransition: UIViewControllerTransitioningDelegate {
  func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
    return HalfModalPresentationController(presentedViewController: presented, presenting: presenting)
  }
}

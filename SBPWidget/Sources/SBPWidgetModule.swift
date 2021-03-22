//
//  SBPWidgetModule.swift
//  SBPWidget
//
//  Created by m on 22.03.2021.
//

import UIKit

typealias EventHandler<T> = ((T) -> Void)
public typealias VoidClosure = () -> Void

public class SBPWidgetModule: SBPWidgetModuleOutput {
  public typealias CompletionHandler = (String) -> ()
  var completion: CompletionHandler?
  
  public init() {}
  public func show(on viewController: UIViewController, completion: CompletionHandler?) {
    let transition = HalfModalTransition()
    let sbpModule = AnyModuleFactory().create(SBPWidgetModuleFactory.self)
    sbpModule.input.moduleOutput = self
    self.completion = completion
    transition.open(sbpModule.viewable.viewController, from: viewController, completion: nil)
  }
  
  func selectedBankApplicationScheme(_ scheme: String) {
    self.completion?(scheme)
  }
}


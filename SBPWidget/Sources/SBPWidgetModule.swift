//
//  SBPWidgetModule.swift
//  SBPWidget
//
//  Created by m on 22.03.2021.
//

import UIKit

typealias EventHandler<T> = ((T) -> Void)
public typealias VoidClosure = () -> Void

public class SBPWidgetModule {
  public typealias CompletionHandler = (String?) -> ()
  
  var completion: CompletionHandler?
  
  public init() {}
  
  public func show(on viewController: UIViewController, completion: CompletionHandler?) {
    self.completion = completion
    
    let sbpModule = AnyModuleFactory().create(SBPWidgetModuleFactory.self)
    sbpModule.input.moduleOutput = self
    sbpModule.router.transition.open(sbpModule.viewable.viewController, from: viewController, completion: nil)
  }
}

extension SBPWidgetModule: SBPWidgetModuleOutput {
  func selectedBankApplicationScheme(_ scheme: String?) {
    self.completion?(scheme)
  }
}


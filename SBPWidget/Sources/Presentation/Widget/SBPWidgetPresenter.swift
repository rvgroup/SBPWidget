//
//  SBPWidgetPresenter.swift
//  SBPWidget
//
//  Created by Mykola Hordynchuk on 04.12.2020.
//  Copyright © 2020 Mykola Hordynchuk. All rights reserved.
//

import Foundation

protocol SBPWidgetViewToPresenterProtocol: AnyObject {
  func onViewFirstWillAppear()
  func onViewEvent(_ event: SBPWidgetViewEvent)
}

protocol SBPWidgetInteractorToPresenterProtocol: ErrorHandlable {
  func onInteractorReceivedBankApplications(_ banks: [SBPBank])
  func onInteractorSelectedBankApplicationScheme(_ scheme: String)
}

protocol SBPWidgetModuleOutput: AnyObject {
  func selectedBankApplicationScheme(_ scheme: String)
}

protocol SBPWidgetModuleInput: AnyObject {
  var moduleOutput: SBPWidgetModuleOutput? { get set }
}


final class SBPWidgetPresenter: SBPWidgetModuleInput {
  weak var view: SBPWidgetPresenterToViewProtocol?
  var interactor: SBPWidgetPresenterToInteractorProtocol?
  var router: SBPWidgetRouter.Routes?
  
  //Module input
  var moduleOutput: SBPWidgetModuleOutput?
}


extension SBPWidgetPresenter: SBPWidgetViewToPresenterProtocol {
  func onViewFirstWillAppear() {
    view?.setupInitialState()
    interactor?.getBankApplications()
  }
  
  func onViewEvent(_ event: SBPWidgetViewEvent) {
    switch event {
    case .onTableViewEvent(let event):
      switch event {
      case .onRowCellTap(let index):
        interactor?.getApplicationSchema(with: index)
      }
    case .onCloseTap:
      router?.toClose()
    }
  }
}


extension SBPWidgetPresenter: SBPWidgetInteractorToPresenterProtocol {
  func onInteractorError(_ error: Error) {
    
  }
  
  func onInteractorSelectedBankApplicationScheme(_ scheme: String) {
    moduleOutput?.selectedBankApplicationScheme(scheme)
    router?.toClose()
  }
  
  func onInteractorReceivedBankApplications(_ banks: [SBPBank]) {
    view?.update(with: banks.map { SBPWidgetBankViewItem(with: $0) })
  }
}

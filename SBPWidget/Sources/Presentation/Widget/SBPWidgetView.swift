//
//  SBPWidgetView.swift
//  SBPWidget
//
//  Created by Mykola Hordynchuk on 04.12.2020.
//  Copyright © 2020 Mykola Hordynchuk. All rights reserved.
//

import UIKit

class SBPWidgetView: BaseInteractiveView {
  private let headerView = UIView()
  let closeButton = UIButton()
  let logoImageView = UIImageView()
  let descriptionTextLabel = UILabel()
  let bankContainer = UIView()
  
  let tableView = UITableView()
  let emptyContainer = UIView()
  let emptyTextLabel = UILabel()
  
  var bankContainerHeightConstraint: NSLayoutConstraint?

  override func addViews() {
    [headerView,
     logoImageView,
     descriptionTextLabel,
     bankContainer].forEach { addSubview($0) }
    [closeButton].forEach { headerView.addSubview($0) }
    [emptyContainer, tableView].forEach { bankContainer.addSubview($0) }
    [emptyTextLabel].forEach { emptyContainer.addSubview($0) }
  }
  
  override func anchorViews() {
    headerView
      .anchorLeft(leftAnchor, 0)
      .anchorRight(rightAnchor, 0)
      .anchorTop(topAnchor, 12)
      .anchorHeight(20)
    
    closeButton
      .anchorWidth(40)
      .anchorHeight(10)
      .anchorCenterSuperview()
    
    logoImageView
      .anchorCenterXToSuperview()
      .anchorTop(headerView.bottomAnchor, 12)
      .anchorWidth(100)
      .anchorHeight(50)
    
    descriptionTextLabel
      .anchorCenterXToSuperview()
      .anchorTop(logoImageView.bottomAnchor, 10)

    bankContainer
      .anchorLeft(leftAnchor, 15)
      .anchorTop(descriptionTextLabel.bottomAnchor, 15)
      .anchorRight(rightAnchor, 15)
      .anchorBottom(bottomAnchor, 15 + UIWindow.safeAreaTopBottomHeight)
    
    emptyContainer.fillSuperview()
    emptyTextLabel.fillSuperview()
    
    tableView
      .anchorLeft(bankContainer.leftAnchor, 0)
      .anchorRight(bankContainer.rightAnchor, 0)
      .anchorTop(bankContainer.topAnchor, 0)
      .anchorBottom(bankContainer.bottomAnchor, 0)
    
    bankContainerHeightConstraint = bankContainer._anchorHeight(82 * 4)
  }
  
  override func configureViews() {
    backgroundColor = .white
    
    closeButton.adjustsImageWhenHighlighted = false
    closeButton.setImage(UIImage(named: "arrowDown", in: Bundle.sbpBundle, compatibleWith: nil), for: .normal)
    emptyContainer.isHidden = true
    
    logoImageView.image = UIImage(named: "sbp_logo", in: Bundle.sbpBundle, compatibleWith: nil)
    
    descriptionTextLabel.font = .systemFont(ofSize: 14, weight: .regular)
    descriptionTextLabel.textAlignment = .center
    descriptionTextLabel.text = LS.SBPWidget.descriptionText
    descriptionTextLabel.textColor = .black
    descriptionTextLabel.numberOfLines = 0
    
    logoImageView.contentMode = .scaleAspectFit
    logoImageView.setContentHuggingPriority(.required, for: .horizontal)
    logoImageView.setContentCompressionResistancePriority(.required, for: .horizontal)
    
    emptyContainer.backgroundColor = .lightGray
    emptyContainer.layer.cornerRadius = 16
    
    emptyTextLabel.text = LS.SBPWidget.emptyText
    emptyTextLabel.textAlignment = .center
    emptyTextLabel.font = .systemFont(ofSize: 14, weight: .regular)
    emptyTextLabel.textColor = UIColor.black.withAlphaComponent(0.5)
    emptyTextLabel.numberOfLines = 0
    
    tableView.tableFooterView = UIView(frame: .zero)
    tableView.backgroundColor = .clear
    tableView.estimatedRowHeight = 72
    tableView.rowHeight = UITableView.automaticDimension
    tableView.registerClass(SBPBankCell.self)
    tableView.delaysContentTouches = false
    tableView.separatorInset = .zero
    tableView.separatorStyle = .none
    tableView.allowsSelection = true
    tableView.showsVerticalScrollIndicator = false
    tableView.showsHorizontalScrollIndicator = false
  }

}


//
//  SBPBankCell.swift
//  SBPWidget
//
//  Created by Mykola Hordynchuk on 05.12.2020.
//  Copyright © 2020 Mykola Hordynchuk. All rights reserved.
//

import UIKit

class SBPBankCell: BaseTableViewCell<SBPBankCellView> {
  func configure(with item: SBPWidgetBankViewItem) {
    mainView.titleLabel.text = item.title
    mainView.logoImageView.download(from: item.logoURL)
  }
}

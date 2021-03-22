//
//  SBPBankService.swift
//  SBPWidget
//
//  Created by Mykola Hordynchuk on 05.12.2020.
//  Copyright © 2020 Mykola Hordynchuk. All rights reserved.
//

import Foundation

enum SBPBankServiceError: Error {
  case invalidPath
}

protocol SBPBankServiceProtocol {
  func getBankApplications() -> [SBPBank]?
}

final class SBPBankService: SBPBankServiceProtocol {
  let url = "https://qr.nspk.ru/proxyapp/c2bmembers.json"
  
  func getBankApplications() -> [SBPBank]? {
    guard let url = URL(string: url) else { return nil }
    do {
      let data = try Data(contentsOf: url, options: .alwaysMapped)
      let decoder = JSONDecoder()
      let jsonData = try decoder.decode(SBPBankRaw.self, from: data)
      return jsonData.dictionary
    } catch {
      return nil
    }
  }
}

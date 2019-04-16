//
//  DateExtensions.swift
//  LiveMetric
//
//  Created by Aleksandr Sisiov on 12/6/18.
//  Copyright © 2018 Provision Lab. All rights reserved.
//

import Foundation

extension Date {
  
  func dateToFormatString(_ format: String) -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = format
    formatter.timeZone = TimeZone(abbreviation: "GMT+0:00")
    let str = formatter.string(from: self)
    return str
  }
}

extension Date {
  func toMillis() -> Double! {
    return Double(self.timeIntervalSince1970 * 1000)
  }
  
  init(milliseconds:Int) {
    self = Date(timeIntervalSince1970: TimeInterval(milliseconds) / 1000)
  }
}

extension Date {
  
  mutating func changeDays(by days: Int) {
    self = Calendar.current.date(byAdding: .day, value: days, to: self)!
  }
  
  static func dates(from fromDate: Date, to toDate: Date) -> [Date] {
    var dates: [Date] = []
    var date = fromDate
    
    while date <= toDate {
      dates.append(date)
      guard let newDate = Calendar.current.date(byAdding: .day, value: 1, to: date) else { break }
      date = newDate
    }
    return dates
  }
}

//
//  DateExtensions.swift
//  LiveMetric
//
//  Created by Aleksandr Sisiov on 12/6/18.
//  Copyright © 2018 Provision Lab. All rights reserved.
//

import Foundation

extension Date {
  func dateToString() -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd"
    let str = formatter.string(from: self)
    return str.replacingOccurrences(of: "-", with: "")
  }
  
  func ageFromDate() -> Int {
    let gregorian = Calendar(identifier: .gregorian)
    let ageComponents = gregorian.dateComponents([.year], from: self, to: Date())
    return ageComponents.year!
  }
  
  func dateToHours() -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = "HH-MM"
    let str = formatter.string(from: self)
    return str
  }
  
  func fullTimeString() -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyy-MM-dd HH-MM"
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

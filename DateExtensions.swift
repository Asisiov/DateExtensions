//
//  DateExtensions.swift
//
//  Created by Aleksandr Sisiov on 12/6/18.
//

import Foundation

// MARK: Format to string
extension Date {
  
  func dateToFormatString(_ format: String) -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = format
    formatter.timeZone = TimeZone.current
    let str = formatter.string(from: self)
    return str
  }
  
  func dateToString() -> String {
    return dateToFormatString("yyyyMMdd")
  }
  
  func ageFromDate() -> Int {
    let gregorian = Calendar(identifier: .gregorian)
    let ageComponents = gregorian.dateComponents([.year], from: self, to: Date())
    return ageComponents.year!
  }
  
  func dateToHours() -> String {
    return dateToFormatString("HH:mm")
  }
  
  func fullTimeString() -> String {
    return dateToFormatString("yyy-MM-dd HH:mm")
  }
}

// MARK: Miliseconds
extension Date {
  func toMillis() -> Double! {
    return Double(self.timeIntervalSince1970 * 1000)
  }
  
  init(milliseconds:Int) {
    self = Date(timeIntervalSince1970: TimeInterval(milliseconds) / 1000)
  }
}

// MARK: Change
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
  
  func add(byAdding component: Calendar.Component, value: Int) -> Date? {
    return Calendar.current.date(byAdding: component, value: value, to: self)
  }
}

// MARK: Compare
extension Date {
  
  enum Distance {
    case unknown
    case today
    case yesterday
  }
  
  func compare(with date: Date, only component: Calendar.Component) -> ComparisonResult {
    let days1 = Calendar.current.component(component, from: self)
    let days2 = Calendar.current.component(component, from: date)
    return ComparisonResult.fromInt(days1 - days2)
  }
  
  func dayDistance(_ date: Date) -> Distance {
    let days1 = Calendar.current.component(.day, from: self)
    let days2 = Calendar.current.component(.day, from: date)
    let res = days1 - days2
    if res == 0 { return .today }
    if res == 1 { return .yesterday }
    return .unknown
  }
}


// MARK: Private
private extension ComparisonResult {
  static func fromInt(_ value: Int) -> ComparisonResult {
    if value < 0 { return .orderedAscending }
    if value > 0 { return .orderedDescending }
    return .orderedSame
  }
}

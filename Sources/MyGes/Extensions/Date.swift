//
//  Date.swift
//  Simple GES (iOS)
//
//  Created by Adri on 28/11/2021.
//

import Foundation

extension Date {
	static var currentYear: String {
		DateFormatter.year.string(from: Date())
	}
	
	static var currentMonth: String {
		DateFormatter.month.string(from: Date())
	}
	
    mutating func add(type: Calendar.Component, _ value: Int) {
        self = Calendar.current.date(byAdding: type, value: value, to: self)!
    }
    
    mutating func rem(type: Calendar.Component, _ value: Int) {
        self = Calendar.current.date(byAdding: type, value: -value, to: self)!
    }
    
    static func getStartOfDay() -> Date {
        Calendar.current.date(bySettingHour: 1, minute: 30, second: 0, of: Date())!
    }
    
    static func getEndOfDay() -> Date {
        var date = Calendar.current.date(bySettingHour: 0, minute: 30, second: 0, of: Date())!
        date.add(type: .day, 1)
        return date
    }
    
    var millisecondsSince1970: UInt64 {
        UInt64((self.timeIntervalSince1970 * 1000.0).rounded())
    }
    
    var daySymbol: String {
        Calendar.current.weekdaySymbols[Calendar.current.component(.weekday, from: self) - 1]
    }
    
    func startOfWeek(using calendar: Calendar = .current) -> Date {
        calendar.dateComponents([.calendar, .yearForWeekOfYear, .weekOfYear], from: self).date!
    }
    
    static func getFirstDayOfMonth(month: Int = Calendar.current.component(.month, from: Date()), year: Int = Calendar.current.component(.year, from: Date()), offset : Int = 0) -> Date {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd HH:mm"
        
        let date : Date
        
        if offset != 0 {
            var monthOff : Int
            var yearOff = year + (offset / 12)
            let offsetModified : Int
            
            if offset < 0 {
                offsetModified = -(abs(offset) % 12)
            } else {
                offsetModified = offset % 12
            }
            
            monthOff = month + offsetModified
            
            if monthOff < 1 {
                monthOff = 12 - monthOff
                yearOff -= 1
            } else if monthOff > 12 {
                monthOff = monthOff - 12
                yearOff += 1
            }
            date = formatter.date(from: yearOff.description + "/" + monthOff.description + "/01 00:00")!
        } else {
            date = formatter.date(from: year.description + "/" + month.description + "/01 00:00")!
        }
        
        return date
    }
    
    static func getLastDayOfMonth(month: Int = Calendar.current.component(.month, from: Date()), year: Int = Calendar.current.component(.year, from: Date()), offset : Int = 0) -> Date {
        var futureDate = getFirstDayOfMonth(offset: offset)
        futureDate.add(type: .month, 1)
        futureDate.rem(type: .hour, 1)
        return futureDate
    }
}

extension DateFormatter {
	static var year: DateFormatter {
		let formatter = DateFormatter()
		formatter.dateFormat = "yyyy"
		return formatter
	}
	
	static var month: DateFormatter {
		let formatter = DateFormatter()
		formatter.dateFormat = "MM"
		return formatter
	}
}

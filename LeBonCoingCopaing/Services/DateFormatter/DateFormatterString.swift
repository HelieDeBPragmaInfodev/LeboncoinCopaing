//
//  DateFormatterString.swift
//  LeBonCoingCopaing
//
//  Created by Hélie de Bernis on 08/08/2022.
//

import Foundation


final class DateFormatterString {
    
    public static func formatDateStringToDayMonthYearHourMin(dateString: String) -> String {
        
        
        let isoDate = "2016-04-14T10:44:00+0000"
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let date = dateFormatter.date(from:isoDate)!
        
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day, .hour], from: date)
        
        let finalDate = calendar.date(from:components)!
        
        let dateFormatterFinal = DateFormatter()
        dateFormatterFinal.dateFormat = "dd-MM-yyyy HH:mm"
        
        let finalDateToReturn = dateFormatterFinal.string(from: finalDate)
        return finalDateToReturn
    }
}

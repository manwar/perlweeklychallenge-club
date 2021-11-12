import Foundation

/*

Week 138:

    https://theweeklychallenge.org/blog/perl-weekly-challenge-138

Task #1: Workdays

    You are given a year in 4-digits form. Write a script to calculate the total number of workdays in the given year.

*/

enum ParamError: Error {
    case missingYear
    case invalidYear
}

do {
    let paramCount:Int = Int(CommandLine.argc)

    if paramCount <= 1 {
        throw ParamError.missingYear
    }

    let year:Int = Int(CommandLine.arguments[1])!

    if year >= 1 {
        print(workdays(year))
    }
    else {
        throw ParamError.invalidYear
    }
}
catch ParamError.missingYear {
    print("Missing year.")
}
catch ParamError.invalidYear {
    print("Invalid year.")
}
catch let error {
    print(error)
}

//
//
// Functions

func workdays(_ year:Int) -> Int {

    var d:Int = 1
    var m:Int = 1
    var y:Int = year

    var workdays: Int = 0
    while year == y {
        var date = date(y, m, d)

        if weekDay(date) < 6 {
            workdays += 1
        }

        date = addDays(date, 1)
        y = Calendar.current.dateComponents([.year],  from: date).year!
        m = Calendar.current.dateComponents([.month], from: date).month!
        d = Calendar.current.dateComponents([.day],   from: date).day!
    }

    return workdays
}

func date(_ year: Int, _ month: Int, _ day: Int) -> Date {
    let calendar = NSCalendar(calendarIdentifier: .gregorian)!

    var dateComponents   = DateComponents()
    dateComponents.year  = year
    dateComponents.month = month
    dateComponents.day   = day

    return calendar.date(from: dateComponents)!
}

func weekDay(_ date: Date) -> Int {
    return Calendar.current.component(.weekday, from: date)
}

func addDays(_ date: Date, _ days: Int) -> Date {
    return Calendar.current.date(byAdding: .day, value: days, to: date)!
}

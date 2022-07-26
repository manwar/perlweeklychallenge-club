import Foundation

/*

Week 175:

    https://theweeklychallenge.org/blog/perl-weekly-challenge-175

Task #1: Last Sunday

    Write a script to list Last Sunday of every month in the given year.

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
    if year >= 1900 {
        for month in 1...12 {
            print(lastSundayOf(month, 2022))
        }
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

func lastSundayOf(_ month:Int, _ year:Int) -> Date {
    var dcomp = DateComponents()
    dcomp.year  = year
    dcomp.month = month
    dcomp.day   = 1

    let date = Calendar.current.date(from: dcomp) ?? Date()
    let nm   = addMonths(date, 1)
    let pd   = addDays(nm, -1)
    let dow  = dayOfWeek(pd)

    if dow == 7 {
        return pd
    }

    return addDays(pd, -dow)
}

func dayOfWeek(_ d:Date) -> Int {
    let index = Calendar(identifier: .gregorian).component(.weekday, from: d)
    return index - 1
}

func addMonths(_ date:Date, _ m:Int) -> Date {
    var dc = DateComponents()
    dc.month = m

    return Calendar.current.date(byAdding: dc, to:date) ?? Date()
}

func addDays(_ date:Date, _ d:Int) -> Date {
    var dc = DateComponents()
    dc.day = d

    return Calendar.current.date(byAdding: dc, to:date) ?? Date()
}

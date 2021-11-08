#!/usr/local/bin/node

//
// See ../README.md
//

//
// Run as: node ch-1a.js < input-file
//

let SUNDAY    = 0
let MONDAY    = 1
let TUESDAY   = 2
let WEDNESDAY = 3
let THURSDAY  = 4
let FRIDAY    = 5
let SATURDAY  = 6

function doomsday (year) {
    let anchor   = [TUESDAY, SUNDAY, FRIDAY, WEDNESDAY]
                   [Math . floor (year / 100) % 4]
    let y        = year % 100
    let doomsday = ((Math . floor  (y / 12) + (y % 12) +
                     Math . floor ((y % 12) / 4)) + anchor) % 7
    return (doomsday)
}

function is_leap (year) {
    return ((year % 400 == 0) || (year % 4 == 0 && year % 100 != 0))
}

for (year = 1900; year <= 2100; year ++) {
    let dec_31 = (doomsday (year) + 31 - 12) % 7
    if (dec_31 == THURSDAY || dec_31 == FRIDAY && is_leap (year)) {
        console . log (year)
    }
}

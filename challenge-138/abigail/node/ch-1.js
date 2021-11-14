#!/usr/local/bin/node

//
// See ../README.md
//

//
// Run as: node ch-1.js < input-file
//

let SUNDAY    = 0
let MONDAY    = 1
let TUESDAY   = 2
let WEDNESDAY = 3
let THURSDAY  = 4
let FRIDAY    = 5
let SATURDAY  = 6

let lookup    = [
    [261, 260, 260, 261, 261, 261, 261],
    [262, 261, 260, 261, 262, 262, 262],
]

function doomsday (year) {
    let anchor   = [TUESDAY, SUNDAY, FRIDAY, WEDNESDAY]
                   [Math . floor (year / 100) % 4]
    let y        = year % 100
    let doomsday = ((Math . floor  (y / 12) + (y % 12) +
                     Math . floor ((y % 12) / 4)) + anchor) % 7
    return (doomsday)
}

//
// Given a year, return whether it's a leap year or not
//
function is_leap (year) {
    return ((year % 400 == 0) || (year % 4 == 0 && year % 100 != 0) ? 1 : 0)
}

  require ('readline')
. createInterface ({input: process . stdin})   
. on              ('line', year => {
    console . log (lookup [is_leap (+year)] [doomsday (+year)])
})

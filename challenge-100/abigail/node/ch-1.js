#!/usr/local/bin/node

//
// See ../README.md
//

//
// Run as: node ch-1.js < input-file
//

let printf = require ("printf")

require ('readline')
. createInterface ({input: process . stdin})   
. on ('line', _ => {
    //
    // Parse data
    //
    let [m, hour, minute, ampm] = _ . match (/([0-9]+):([0-9]+)\s*([ap]?)/)

    let new_ampm = ampm == "" ? hour >= 12 ? "pm" : "am" : ""

    hour = hour % 12
    if (ampm == "" && hour == 0) {
        hour = 12
    }
    if (ampm == "p") {
        hour += 12
    }

    printf (process . stdout, "%02d:%02d%s\n", hour, minute, new_ampm)
});

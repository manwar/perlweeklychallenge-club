#! /usr/bin/node

"use strict"

function seniorcitizens(a) {
    let p = 0
    for (let st of a) {
        if (st.charAt(11) >= '6') {
            p += 1;
        }
    }
    return p;
}

if (seniorcitizens(['7868190130M7522', '5303914400F9211', '9273338290F4010']) == 2) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (seniorcitizens(['1313579440F2036', '2921522980M5644']) == 0) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write("\n");

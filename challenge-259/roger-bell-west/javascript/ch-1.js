#! /usr/bin/node

"use strict"

function bankingdayoffset(start, offset, bankholidays) {
    let bh = new Set(bankholidays.map(x => new Date(Date.parse(x)).toString()));
    let d = new Date(Date.parse(start));
    for (let i = 1; i <= offset; i++) {
        d.setDate(d.getDate() + 1);
        while (bh.has(d.toString()) || d.getDay() == 0 || d.getDay() == 6) {
            d.setDate(d.getDate() + 1);
        }
    }
    return d.getFullYear().toString().padStart(4, "0") + "-" +
        (d.getMonth()+1).toString().padStart(2, "0") + "-" +
        d.getDate().toString().padStart(2, "0");
}

if (bankingdayoffset('2018-06-28', 3, ['2018-07-03']) == '2018-07-04') {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (bankingdayoffset('2018-06-28', 3, []) == '2018-07-03') {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write("\n");

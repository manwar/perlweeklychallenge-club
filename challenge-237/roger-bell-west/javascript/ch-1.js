#! /usr/bin/node

"use strict"

function seizetheday(year, month, weekcount, dayofweek) {
    let dt = new Date(year, month-1, 1, 12, 0, 0);
    let wd = dt.getDay();
    if (wd == 0) {
        wd = 7;
    }
    if (wd != dayofweek) {
        dt.setDate(dt.getDate() + (dayofweek - wd + 7) % 7);
    }
    if (weekcount > 1) {
        dt.setDate(dt.getDate() + 7 * (weekcount - 1));
    }
    if (dt.getMonth() != month-1 || dt.getYear() != year-1900) {
        return 0;
    }
    return dt.getDate();
}

if (seizetheday(2024, 4, 3, 2) == 16) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (seizetheday(2025, 10, 2, 4) == 9) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (seizetheday(2026, 8, 5, 3) == 0) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write("\n");

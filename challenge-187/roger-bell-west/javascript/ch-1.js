#! /usr/bin/node

"use strict"

function s2date(ds) {
    let dm = ds.split("-");
    if (dm.length == 2) {
        return Date.UTC(2022, parseInt(dm[1])-1, parseInt(dm[0]), 0, 0, 0, 0)/86400000;
    }
}

function daystogether(a, b) {
    let starts = [s2date(a[0]), s2date(b[0])];
    starts.sort(function(a,b) {
        return a-b;
    });
    let ends = [s2date(a[1]), s2date(b[1])];
    ends.sort(function(a,b) {
        return a-b;
    });
    if (ends[0] >= starts[1]) {
        return ends[0]-starts[1]+1;
    } else {
        return 0;
    }
}

if (daystogether(["12-01", "20-01"], ["15-01", "18-01"]) == 4) {
    process.stdout.write("Pass");
} else {
    process.stdout.write("FAIL");
}
process.stdout.write(" ");

if (daystogether(["02-03", "12-03"], ["13-03", "14-03"]) == 0) {
    process.stdout.write("Pass");
} else {
    process.stdout.write("FAIL");
}
process.stdout.write(" ");

if (daystogether(["02-03", "12-03"], ["11-03", "15-03"]) == 2) {
    process.stdout.write("Pass");
} else {
    process.stdout.write("FAIL");
}
process.stdout.write(" ");

if (daystogether(["30-03", "05-04"], ["28-03", "02-04"]) == 4) {
    process.stdout.write("Pass");
} else {
    process.stdout.write("FAIL");
}
process.stdout.write("\n");

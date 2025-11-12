#! /usr/bin/node

"use strict"

function format(n, w) {
    let s = n.toString();
    while (s.length < w) {
        s = "0" + s;
    }
    return s;
}
function formatdate(a) {
    const dmy = a.split(" ");
    let out = [];
    out.push(parseInt(dmy[2]));
    out.push(new Map([
        [ "Jan", 1 ],
        [ "Feb", 2 ],
        [ "Mar", 3 ],
        [ "Apr", 4 ],
        [ "May", 5 ],
        [ "Jun", 6 ],
        [ "Jul", 7 ],
        [ "Aug", 8 ],
        [ "Sep", 9 ],
        [ "Oct", 10 ],
        [ "Nov", 11 ],
        [ "Dec", 12 ]
    ]).get(dmy[1]));
    {
        let c = dmy[0].split('');
        let d = parseInt(c[0]);
        if (c[1].search("[0-9]") != -1) {
            d = d * 10 + parseInt(c[1]);
        }
        out.push(d);
    }
    return [
        format(out[0], 4),
        format(out[1], 2),
        format(out[2], 2)
    ].join('-');
}

if (formatdate('1st Jan 2025') == '2025-01-01') {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (formatdate('22nd Feb 2025') == '2025-02-22') {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (formatdate('15th Apr 2025') == '2025-04-15') {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (formatdate('23rd Oct 2025') == '2025-10-23') {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (formatdate('31st Dec 2025') == '2025-12-31') {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write("\n");

#! /usr/bin/node

"use strict"

function upperlower(a) {
    let out = "";
    a.split("").forEach (c => {
        out += String.fromCharCode(c.charCodeAt(0) ^ 32);
    });
    return out;
}

if (upperlower('pERL') == 'Perl') {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (upperlower('rakU') == 'RAKu') {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (upperlower('PyThOn') == 'pYtHoN') {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write("\n");

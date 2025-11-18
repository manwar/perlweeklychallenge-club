#! /usr/bin/node

"use strict"

function hm2m(a) {
    const p = a.match(/(\d+):(\d+)/);
    return parseInt(p[1]) * 60 + parseInt(p[2]);
}

function converttime(ssrc, ttgt) {
    const src = hm2m(ssrc);
    let tgt = hm2m(ttgt);
    if (tgt < src) {
        tgt += 24 * 60;
    }
    let delta = tgt - src;
    let oc = 0;
    for (let op of [60, 15, 5, 1]) {
        oc += Math.floor(delta / op);
        delta %= op;
    }
    return oc;
}

if (converttime('02:30', '02:45') == 1) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (converttime('11:55', '12:15') == 2) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (converttime('09:00', '13:00') == 4) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (converttime('23:45', '00:30') == 3) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (converttime('14:20', '15:25') == 2) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write("\n");

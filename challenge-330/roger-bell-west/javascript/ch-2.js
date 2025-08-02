#! /usr/bin/node

"use strict"

function titlecapital(a) {
    let out = [];
    for (let w of a.split(" ")) {
        let p = w.toLowerCase();
        if (p.length > 2) {
            let c = p.split("")
            c[0] = c[0].toUpperCase();
            p = c.join("");
        }
        out.push(p);
    }
    return out.join(" ");
}

if (titlecapital('PERL IS gREAT') == 'Perl is Great') {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (titlecapital('THE weekly challenge') == 'The Weekly Challenge') {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (titlecapital('YoU ARE A stAR') == 'You Are a Star') {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write("\n");

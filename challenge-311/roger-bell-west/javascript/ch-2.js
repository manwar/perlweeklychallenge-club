#! /usr/bin/node

"use strict"

function groupdigitsum(a, sz) {
    let s = a;
    let n = 0;
    while (true) {
        let t = "";
        s.split("").forEach((c, i) => {
            n += parseInt(c);
            if (i == s.length - 1 || (i + 1) % sz == 0) {
                t += n;
                n = 0;
            }
        });
        s = t;
        if (s.length <= sz) {
            break;
        }
    }
    return s;
}

if (groupdigitsum('111122333', 3) == '359') {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (groupdigitsum('1222312', 2) == '76') {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (groupdigitsum('100012121001', 4) == '162') {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write("\n");

#! /usr/bin/node

"use strict"

function onesandzeroes(a, zeroes, ones) {
    let ax = [];
    for (let ns of a) {
        let o = 0;
        let n = 0;
        for (let c of ns.split("")) {
            switch(c) {
            case '0':
                o += 1;
                break;
            case '1':
                n += 1;
                break;
            }
        }
        ax.push([o, n]);
    }
    let mx = 0;
    for (let mask = 1; mask < (1 << ax.length); mask++) {
        let o = 0;
        let n = 0;
        let ct = 0;
        ax.forEach((x, i) => {
            if ((mask & (1 << i)) > 0) {
                o += x[0];
                n += x[1];
                ct++;
            }
        });
        if(o <= zeroes && n <= ones) {
            mx = Math.max(mx, ct);
        }
    }
    return mx;
}

if (onesandzeroes(['10', '0001', '111001', '1', '0'], 5, 3) == 4) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (onesandzeroes(['10', '1', '0'], 1, 1) == 2) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write("\n");
